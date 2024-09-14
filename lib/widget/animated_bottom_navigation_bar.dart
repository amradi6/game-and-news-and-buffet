import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      backgroundColor: Colors.black,
      activeColor: Colors.orange,
      inactiveColor: Colors.grey,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.smoothEdge,
      icons: const [
        Icons.home,
        FontAwesomeIcons.utensils,
        Icons.info,
      ],
      activeIndex: currentIndex,
      onTap: onTap,
    );
  }
}
