import 'dart:ui';
import 'package:carrot_ai/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CodeViewScreen extends StatefulWidget {
  const CodeViewScreen({super.key});

  @override
  State<CodeViewScreen> createState() => _CodeViewScreenState();
}

class _CodeViewScreenState extends State<CodeViewScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isGenerating = false;
  bool _showPreview = false;
  final List<_ChatMessage> _messages = [];
  String? _aiError;

  final Color carrotYellow = const Color.fromARGB(255, 194, 190, 5);

  // Replace with your actual Gemini API key
  static const String _geminiApiKey = ApiKeys.geminiApiKey;
  static const String _geminiApiUrl =
      'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=';

  Future<String> _getGeminiResponse(String prompt) async {
    final url = Uri.parse(_geminiApiUrl + _geminiApiKey);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt} // Raw user input only
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.9, // For creative responses
          'topP': 1.0, // Broad sampling
        }
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates']?[0]?['content']?['parts']?[0]?['text'] ??
          'Gemini did not return a valid response.';
    } else {
      throw Exception('API error ${response.statusCode}: ${response.body}');
    }
  }

  void _sendPrompt() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) return;

    setState(() {
      _isGenerating = true;
      _aiError = null;
      _messages.clear(); // Only keep latest prompt/response
      _messages.add(_ChatMessage(role: ChatRole.user, text: prompt));
      _promptController.clear();
    });

    try {
      final response = await _getGeminiResponse(prompt);
      setState(() {
        _messages.add(_ChatMessage(role: ChatRole.ai, text: response));
      });
    } catch (e) {
      setState(() {
        _aiError = e.toString();
        _messages.add(_ChatMessage(role: ChatRole.error, text: _aiError!));
      });
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    _ChatMessage? latestAiMsg;
    for (var i = _messages.length - 1; i >= 0; i--) {
      if (_messages[i].role == ChatRole.ai ||
          _messages[i].role == ChatRole.error) {
        latestAiMsg = _messages[i];
        break;
      }
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF232526),
                  const Color(0xFF414345),
                  carrotYellow.withOpacity(0.08),
                ]
              : [
                  carrotYellow.withOpacity(0.08),
                  const Color(0xFFF7F7E8),
                  Colors.white,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(24)),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.background.withOpacity(0.7),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark ? Colors.black26 : Colors.grey.withOpacity(0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
                backgroundBlendMode: BlendMode.overlay,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: carrotYellow,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    'Carrot.ai',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: carrotYellow.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Code',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                              color: _showPreview
                                  ? theme.colorScheme.onBackground
                                      .withOpacity(0.5)
                                  : carrotYellow,
                            ),
                          ),
                          Switch.adaptive(
                            value: _showPreview,
                            activeColor: carrotYellow,
                            onChanged: (value) {
                              setState(() {
                                _showPreview = value;
                              });
                            },
                          ),
                          Text(
                            'Preview',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                              color: _showPreview
                                  ? carrotYellow
                                  : theme.colorScheme.onBackground
                                      .withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: TextField(
                        controller: _promptController,
                        style: theme.textTheme.bodyLarge,
                        enabled: true,
                        readOnly: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.cardColor.withOpacity(0.85),
                          hintText: 'Describe the app you want to build...',
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.hintColor.withOpacity(0.7),
                            letterSpacing: 1.1,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: carrotYellow,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: carrotYellow.withOpacity(0.18),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(Icons.send,
                                    color:
                                        isDark ? Colors.black : Colors.white),
                                onPressed: _isGenerating ? null : _sendPrompt,
                              ),
                            ),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 220, maxHeight: 420),
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black26
                                : Colors.grey.withOpacity(0.13),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: _showPreview
                                ? const PreviewPane(
                                    flutterCode: 'Your Flutter code here')
                                : const CodeEditor(),
                          ),
                          if (!_showPreview)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    Clipboard.setData(const ClipboardData(
                                        text: 'Your Flutter code here'));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            'Code copied to clipboard'),
                                        backgroundColor:
                                            carrotYellow.withOpacity(0.95),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: carrotYellow,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: carrotYellow.withOpacity(0.18),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.copy,
                                        color: Colors.white, size: 22),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_isGenerating)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (latestAiMsg != null &&
                        latestAiMsg.role == ChatRole.ai)
                      AiResponseCard(response: latestAiMsg.text)
                    else if (latestAiMsg != null &&
                        latestAiMsg.role == ChatRole.error)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.red.withOpacity(0.18)),
                        ),
                        child: Text(
                          latestAiMsg.text,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ChatRole { user, ai, error }

class _ChatMessage {
  final ChatRole role;
  final String text;
  _ChatMessage({required this.role, required this.text});
}

// These would be your existing widget classes
class PreviewPane extends StatelessWidget {
  final String flutterCode;
  const PreviewPane({super.key, required this.flutterCode});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Preview: $flutterCode'));
  }
}

class CodeEditor extends StatelessWidget {
  const CodeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Code Editor'));
  }
}

class AiResponseCard extends StatelessWidget {
  final String response;
  const AiResponseCard({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(response),
      ),
    );
  }
}
