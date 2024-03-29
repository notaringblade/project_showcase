import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_showcase/main_pages/discover_page.dart';
import 'package:project_showcase/main_pages/home_page.dart';
import 'package:project_showcase/main_pages/portfolios_page.dart';
import 'package:project_showcase/main_pages/user_profile_page.dart';
import 'package:project_showcase/services/auth_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> pages = const [
    HomePage(),
    DiscoverPage(),
    PortfoliosPage(),
    UserProfilePage()
  ];

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: pages[_selectedIndex],
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
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
                    tabBackgroundColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor!,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor,
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
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ))),
    );
  }
}
