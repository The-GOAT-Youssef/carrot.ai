import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carrot_ai/providers/app_provider.dart';
import 'package:carrot_ai/widgets/theme_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingsCard(
              context,
              title: 'Appearance',
              children: [
                ListTile(
                  leading: const Icon(Icons.brightness_6),
                  title: const Text('Dark Mode'),
                  trailing: const ThemeSwitch(),
                  onTap: () {
                    final provider =
                        Provider.of<AppProvider>(context, listen: false);
                    provider.toggleTheme(!provider.isDarkMode);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Accent Color'),
                  trailing: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 12,
                  ),
                  onTap: () {
                    // Color picker implementation
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              context,
              title: 'Gemini API',
              children: [
                ListTile(
                  leading: const Icon(Icons.key),
                  title: const Text('API Key'),
                  subtitle: const Text('••••••••••••••••••••••'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // API key editor
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              context,
              title: 'About',
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Version'),
                  subtitle: const Text('1.0.0'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    // Open privacy policy
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
