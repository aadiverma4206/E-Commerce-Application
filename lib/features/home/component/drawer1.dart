import 'package:e_commerce_application/features/favorites/favorites_screen.dart';
import 'package:e_commerce_application/features/home/DrawerPages/version/anim_text_version.dart';
import 'package:e_commerce_application/features/product/upload_product_screen.dart';
import 'package:flutter/material.dart';
import '../DrawerPages/pages/developer.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3c72), Color(0xff2a5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.03,
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    const SizedBox(width: 15),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'E-Commerce',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'help@gmail.com',
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    _buildTile(
                      context,
                      icon: Icons.home,
                      title: "Home",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    _buildTile(
                      context,
                      icon: Icons.upload,
                      title: "Upload Product",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UploadProductScreen(),
                          ),
                        );
                      },
                    ),
                    _buildTile(
                      context,
                      icon: Icons.favorite,
                      title: "Favorites",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FavoriteScreen(),
                          ),
                        );
                      },
                    ),
                    _buildTile(
                      context,
                      icon: Icons.code,
                      title: "Developer",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DeveloperAadi(),
                          ),
                        );
                      },
                    ),
                    _buildTile(
                      context,
                      icon: Icons.info_outline,
                      title: "Version",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AnimTextVersion(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white.withOpacity(0.08),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
