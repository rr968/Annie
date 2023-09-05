import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:build/main.dart';
import 'package:build/view/Auth/login.dart';
import 'package:build/view/Language/language.dart';

import 'package:build/view/homepage/homepage.dart';
import 'package:build/view/offers/mainlist.dart';
import 'package:build/view/profile/profile.dart';
import 'package:build/view/requests/requests.dart';
import 'package:build/view/settings/settings.dart';
import 'package:flutter/material.dart';

import 'notification/notification.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 6;

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomePage(),
    const Profile(),
    const Notifications(),
    const MainListOffers(),
    const Requests(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        extendBody: true,
        bottomNavigationBar: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 30,
                color: maincolor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedNotchBottomBar(
                  notchBottomBarController: _controller,
                  color: const Color(0xff4C2963),
                  showLabel: true,
                  notchColor: Colors.pink,
                  itemLabelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  durationInMilliSeconds: 400,
                  removeMargins: true,
                  bottomBarItems: [
                    BottomBarItem(
                      inActiveItem: const Icon(
                        Icons.home_filled,
                        color: Colors.white,
                      ),
                      activeItem: const Icon(
                        Icons.home_filled,
                        color: Colors.white,
                      ),
                      itemLabel: translateText["Home"]![language],
                    ),
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        'assets/profile.png',
                        color: Colors.white,
                      ),
                      activeItem: Image.asset(
                        'assets/profile.png',
                        color: Colors.white,
                      ),
                      itemLabel: translateText["Profile"]![language],
                    ),
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        'assets/notification.png',
                        color: Colors.white,
                      ),
                      activeItem: Image.asset(
                        'assets/notification.png',
                        color: Colors.white,
                      ),
                      itemLabel: translateText["Notifications"]![language],
                    ),
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        'assets/offer.png',
                        color: Colors.white,
                      ),
                      activeItem: Image.asset(
                        'assets/offer.png',
                        color: Colors.white,
                      ),
                      itemLabel: translateText["offers"]![language],
                    ),
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        'assets/sevices.png',
                        color: Colors.white,
                      ),
                      activeItem: Image.asset(
                        'assets/sevices.png',
                        color: Colors.white,
                      ),
                      itemLabel: translateText["Services"]![language],
                    ),
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        'assets/Setting.png',
                        color: Colors.white,
                      ),
                      activeItem: Image.asset(
                        'assets/Setting.png',
                        color: Colors.white,
                      ),
                      itemLabel: translateText["Settings"]![language],
                    ),
                  ],
                  onTap: (index) {
                    if (index != 0 && !isSign) {
                      _controller.jumpTo(0);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    } else {
                      setState(() {
                        currentIndex = index;
                      });
                    }
                  },
                ),
                Container(
                  height: 20,
                  color: maincolor,
                ),
              ],
            ),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: bottomBarPages[currentIndex],
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
