import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:carrot_ai/providers/app_provider.dart';
import 'package:carrot_ai/screens/home_screen.dart';
import 'package:carrot_ai/screens/code_view_screen.dart';
import 'package:carrot_ai/screens/preview_screen.dart';
import 'package:carrot_ai/services/local_storage_service.dart';
import 'package:carrot_ai/themes/app_themes.dart';
import 'secret.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final localStorageService = LocalStorageService();
  String? apiKey = await localStorageService.loadApiKey();
  apiKey ??= ApiKeys.geminiApiKey;

  // Initialize Gemini
  try {
    Gemini.init(apiKey: apiKey);
    print('🔥 Gemini API initialized with key: ${apiKey.substring(0, 4)}...');
  } catch (e) {
    print('❌ Failed to initialize Gemini API: $e');
  }

  runApp(const CarrotAI());
}

class CarrotAI extends StatelessWidget {
  const CarrotAI({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Carrot.ai',
            theme: provider.isDarkMode
                ? AppThemes.darkTheme
                : AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routes: {
              '/': (context) => const HomeScreen(),
              '/code': (context) => const CodeViewScreen(),
              '/preview': (context) => const PreviewScreen(),
            },
            initialRoute: '/',
            builder: (context, child) {
              return AnimatedTheme(
                data: Theme.of(context),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
