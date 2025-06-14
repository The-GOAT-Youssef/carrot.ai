import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carrot_ai/providers/app_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Switch.adaptive(
      value: provider.isDarkMode,
      activeColor: const Color.fromARGB(255, 194, 190, 5),
      onChanged: (value) {
        provider.toggleTheme(value);
      },
    );
  }
}
