import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'dart:async';

import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      int nextPage = (_currentPage + 1) % 3; // Boucle entre 0, 1, et 2
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 240, 248),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              Image.asset('assets/back1.jpeg', fit: BoxFit.cover),
              Image.asset('assets/back2.jpeg', fit: BoxFit.cover),
              Image.asset('assets/back3.jpeg', fit: BoxFit.cover),
            ],
          ),
          Container(
            color: AppTheme.primaryColor
                .withOpacity(0.6), // Couche bleue transparente
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to",
                    style: AppTheme().stylish1(30, AppTheme.white),
                  ),
                  Text(
                    "Sunofa Map",
                    style:
                        AppTheme().stylish1(50, AppTheme.white, isBold: true),
                  ),
                  SizedBox(height: context.heightPercent(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOption(
                        onTap: () {
                          Navigator.pushNamed(context, '/AddMapFormScreen');
                        },
                        text: 'Add\n address',
                        icon: HeroIcons.mapPin,
                      ),
                      _buildOption(
                        onTap: () {
                          Navigator.pushNamed(context, '/AddMapFormScreen');
                        },
                        text: 'Join\n address',
                        icon: HeroIcons.map,
                      ),
                    ],
                  ),
                  SizedBox(height: context.heightPercent(5)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/Loginscreen');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 12,
                        ),
                        child: Text(
                          'Connexion',
                          style: AppTheme().stylish1(15, AppTheme.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.white : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
      {required String text,
      required HeroIcons icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 140,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: AppTheme().stylish1(15, AppTheme.white),
            ),
            const SizedBox(height: 8),
            HeroIcon(icon, color: Colors.white, size: 30),
          ],
        ),
      ),
    );
  }
}
