import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Drawer(
      backgroundColor: const Color(0xFF0C113F),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/aura.png',
                    height: height * 0.125,
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const IconTextmerge(
                        icon: Icon(
                          Icons.share,
                          size: 25,
                          color: Colors.white,
                        ),
                        text: 'Share'),
                  ),
                  const IconTextmerge(
                      icon: FaIcon(
                        FontAwesomeIcons.shieldHalved,
                        color: Colors.white,
                        size: 24,
                      ),
                      text: 'Privacy policy'),
                  const IconTextmerge(
                      icon: FaIcon(
                        FontAwesomeIcons.clipboardCheck,
                        color: Colors.white,
                        size: 26,
                      ),
                      text: 'Terms and condiitions'),
                  const IconTextmerge(
                      icon: FaIcon(
                        FontAwesomeIcons.circleInfo,
                        color: Colors.white,
                        size: 23,
                      ),
                      text: 'About us'),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.05),
                  child: const Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Color(0xFF9C9C9C), fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconTextmerge extends StatelessWidget {
  final Widget icon;
  final String text;

  const IconTextmerge({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
