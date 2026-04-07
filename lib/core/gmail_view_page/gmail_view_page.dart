import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GmailViewPage extends StatefulWidget {
  final String email;
  final String subject;
  final String body;
  ///////////////////////////////////future me krna hai ise complete
  const GmailViewPage({
    super.key,
    required this.email,
    this.subject = "",
    this.body = "",
  });

  @override
  State<GmailViewPage> createState() => _GmailViewPageState();
}

class _GmailViewPageState extends State<GmailViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          "https://mail.google.com/mail/?view=cm&to=${widget.email}&su=${Uri.encodeComponent(widget.subject)}&body=${Uri.encodeComponent(widget.body)}",
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: _controller),
    );
  }
}

/*
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GmailViewPage(
                              email: "aadiverma4206@gmail.com",
                              subject: " ",
                              body: " ",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.email_outlined, size: 26),
                      label: const Text(
                        'Open Gmail',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.redAccent),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        elevation: WidgetStateProperty.all(10),
                        shadowColor: WidgetStateProperty.all(Color.fromRGBO(244, 67, 54, 0.4)),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        overlayColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Colors.red.shade700;
                            }
                            if (states.contains(WidgetState.pressed)) {
                              return Colors.red.shade900;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    */
