import 'package:e_commerce_application/features/home/component/appbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperAadi extends StatefulWidget {
  const DeveloperAadi({super.key});

  @override
  State<DeveloperAadi> createState() => _DeveloperAadiState();
}

class _DeveloperAadiState extends State<DeveloperAadi>
    with TickerProviderStateMixin {
  late AnimationController mainController;
  late AnimationController floatingController;

  late Animation<double> fade;
  late Animation<Offset> slide;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();

    mainController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200));

    floatingController =
    AnimationController(vsync: this, duration: Duration(seconds: 3))
      ..repeat(reverse: true);

    fade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: mainController, curve: Curves.easeIn));

    slide = Tween(begin: Offset(0, 0.3), end: Offset.zero).animate(
        CurvedAnimation(parent: mainController, curve: Curves.easeOut));

    scale = Tween(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: mainController, curve: Curves.elasticOut));

    mainController.forward();
  }

  @override
  void dispose() {
    mainController.dispose();
    floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Appbar(),
      body: AnimatedBuilder(
        animation: mainController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff0f2027),
                  Color(0xff203a43),
                  Color(0xff2c5364)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FadeTransition(
                    opacity: fade,
                    child: SlideTransition(
                      position: slide,
                      child: Container(
                        height: size.height * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(40)),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/DeveloperAadi/aditya.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  FadeTransition(
                    opacity: fade,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: floatingController,
                          builder: (_, __) {
                            return Transform.translate(
                              offset: Offset(
                                  0, floatingController.value * 8),
                              child: ScaleTransition(
                                scale: scale,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundImage: AssetImage(
                                        'assets/images/DeveloperAadi/aditya.png'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ADITYA KUMAR",
                              style: TextStyle(
                                fontSize: size.width * 0.055,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Student of SOS in CS & IT",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  _card(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pt. Ravishankar Shukla University",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "M.Sc IT (2024-2026)",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  _card(
                    Column(
                      children: [
                        Text(
                          "PRSU TOUR",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "App developed by ADITYA KUMAR VERMA",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  _card(
                    Column(
                      children: [
                        Text(
                          "Contact Developer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "aadiverma4206@gmail.com",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: "aadiverma4206@gmail.com",
                            );
                            await launchUrl(emailUri);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.orange, Colors.red],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.email, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  "Send Email",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _card(Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white.withOpacity(0.08),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: child,
      ),
    );
  }
}