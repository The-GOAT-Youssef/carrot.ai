import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/darcula.dart';

class CodeEditor extends StatelessWidget {
  const CodeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    const exampleCode = '''
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrot.ai Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}
''';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color.fromARGB(255, 194, 190, 5).withOpacity(0.9)),
      ),
      child: HighlightView(
        exampleCode.replaceAll(
            'Colors.orange', 'Color.fromARGB(255, 194, 190, 5)'),
        language: 'dart',
        theme: darculaTheme,
        padding: const EdgeInsets.all(22),
        textStyle: const TextStyle(
          fontFamily: 'Courier',
          fontSize: 14,
        ),
      ),
    );
  }
}
