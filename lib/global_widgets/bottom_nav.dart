import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required int selectedIndex,
  }) : _selectedIndex = selectedIndex;

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).colorScheme.primary,
              hoverColor: Theme.of(context).colorScheme.secondary,
              gap: 8,
              activeColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.explore_outlined,
                  text: 'Discover',
                ),
                GButton(
                  icon: Icons.file_copy_outlined,
                  text: 'portfolio',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                // setState(() {
                //   _selectedIndex = index;
                // });
              },
            ),
          ),
        ));
  }
}
