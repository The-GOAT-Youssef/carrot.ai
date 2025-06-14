import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PreviewPane extends StatefulWidget {
  final String flutterCode;
  const PreviewPane({super.key, required this.flutterCode});

  @override
  State<PreviewPane> createState() => _PreviewPaneState();
}

class _PreviewPaneState extends State<PreviewPane> {
  bool _isFullPreview = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Live Preview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color.fromARGB(255, 194, 190, 5),
                  ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isFullPreview ? Icons.fit_screen : Icons.fullscreen,
                    color: const Color.fromARGB(255, 194, 190, 5),
                  ),
                  onPressed: () {
                    setState(() {
                      _isFullPreview = !_isFullPreview;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: const Color.fromARGB(255, 194, 190, 5),
                  ),
                  onPressed: () {
                    // Refresh preview logic
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height:
              _isFullPreview ? MediaQuery.of(context).size.height * 0.7 : 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 194, 190, 5).withOpacity(0.3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  'App Preview Rendering...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: FloatingActionButton.small(
                  backgroundColor: const Color.fromARGB(255, 194, 190, 5),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.flutterCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Code copied to clipboard')),
                    );
                  },
                  child: const Icon(Icons.copy, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
