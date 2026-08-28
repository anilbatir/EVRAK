import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/document_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const EvrakApp());
}

class EvrakApp extends StatelessWidget {
  const EvrakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocumentProvider(),
      child: MaterialApp(
        title: 'EVRAK',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
