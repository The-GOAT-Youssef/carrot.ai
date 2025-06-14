import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AiResponseCard extends StatelessWidget {
  final String response;
  const AiResponseCard({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 194, 190, 5).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'AI Response',
                    style: TextStyle(
                      color: Color.fromARGB(255, 194, 190, 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: response));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Response copied to clipboard'),
                        duration: Duration(milliseconds: 1200),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            SelectableText(
              response,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
