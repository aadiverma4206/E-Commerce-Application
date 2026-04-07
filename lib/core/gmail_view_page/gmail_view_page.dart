import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GmailViewPage extends StatefulWidget {
  final String email;
  final String subject;
  final String body;

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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final uri = Uri.parse(
      "https://mail.google.com/mail/?view=cm&to=${widget.email}&su=${Uri.encodeComponent(widget.subject)}&body=${Uri.encodeComponent(widget.body)}",
    );

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => isLoading = false);
            }
          },
        ),
      )
      ..loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gmail"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}