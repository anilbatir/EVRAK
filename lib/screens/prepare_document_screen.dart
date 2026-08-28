import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/document_template.dart';
import '../providers/profile_provider.dart';
import '../services/pdf_service.dart';
import '../services/template_engine.dart';
import '../theme/app_theme.dart';
import '../utils/field_labels.dart';
import 'document_result_screen.dart';

/// Collects only the fields the user's profile doesn't already cover,
/// then renders the template and generates the PDF.
class PrepareDocumentScreen extends StatefulWidget {
  const PrepareDocumentScreen({super.key, required this.template});

  final DocumentTemplate template;

  @override
  State<PrepareDocumentScreen> createState() => _PrepareDocumentScreenState();
}

class _PrepareDocumentScreenState extends State<PrepareDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, String> _data;
  late List<String> _missingFields;
  final Map<String, TextEditingController> _controllers = {};
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _data = {
      ...profile.variableMap,
      'document.date': DateFormat('dd.MM.yyyy').format(DateTime.now()),
    };
    _missingFields = TemplateEngine.missingRequiredFields(widget.template, _data);
    for (final field in _missingFields) {
      _controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _generate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isGenerating = true);

    for (final entry in _controllers.entries) {
      _data[entry.key] = entry.value.text.trim();
    }

    final result = TemplateEngine.render(widget.template, _data);

    try {
      final file = await PdfService.generateDocumentPdf(
        title: widget.template.title,
        bodyText: result.text,
      );
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => DocumentResultScreen(template: widget.template, file: file)),
        );
      }
    } on FileSystemException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belge oluşturulurken bir hata oluştu, tekrar deneyin.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fieldBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Scaffold(
      appBar: AppBar(title: const Text('Belgeyi Hazırla')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              widget.template.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              _missingFields.isEmpty
                  ? 'Profilindeki bilgiler bu belge için yeterli. Onayla ve belgeyi oluştur.'
                  : 'Profilinde olmayan birkaç bilgiyi tamamlaman gerekiyor. Diğer alanlar profilinden otomatik dolduruldu.',
              style: const TextStyle(fontSize: 13, color: Color(0xFF9A97B0)),
            ),
            const SizedBox(height: 20),
            for (final field in _missingFields)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TextFormField(
                  controller: _controllers[field],
                  decoration: InputDecoration(
                    labelText: fieldLabel(field),
                    filled: true,
                    fillColor: fieldBg,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? '${fieldLabel(field)} zorunludur' : null,
                ),
              ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isGenerating ? null : _generate,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isGenerating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Belgeyi Oluştur', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
