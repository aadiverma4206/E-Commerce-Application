import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class AnimTextVersion extends StatefulWidget {
  const AnimTextVersion({super.key});

  @override
  State<AnimTextVersion> createState() => _AnimTextVersionState();
}

class _AnimTextVersionState extends State<AnimTextVersion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Version 1.0'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

          AnimatedTextKit(animatedTexts: [
            WavyAnimatedText(
              'HELLO WORLD',
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            WavyAnimatedText(
              'Version 1.0',
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            WavyAnimatedText(
              'The Aadi',
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ])
        ]),
      ),
    );
  }
}