import 'package:flutter/material.dart';

import '../models/document.dart';

class FileBadge extends StatelessWidget {
  const FileBadge({super.key, required this.fileType, this.size = 38});

  final EvrakFileType fileType;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.27),
      child: Container(
        width: size,
        height: size,
        color: fileType.color,
        child: Stack(
          children: [
            Positioned(
              top: -size * 0.18,
              right: -size * 0.18,
              child: Transform.rotate(
                angle: 0.785398,
                child: Container(
                  width: size * 0.42,
                  height: size * 0.42,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
            Center(
              child: Text(
                fileType.label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: size * 0.22,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
