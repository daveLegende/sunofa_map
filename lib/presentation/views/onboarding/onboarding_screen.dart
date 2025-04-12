import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
// import 'dart:async';

import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/presentation/views/addMap/pages/add_map_form_screen.dart';
import 'package:sunofa_map/presentation/views/auth/pages/auth.dart';
import 'package:sunofa_map/presentation/views/auth/pages/auth_register.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // final PageController _pageController = PageController();
  // int _currentPage = 0;
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _startAutoScroll();
  }

  @override
  void dispose() {
    // _timer?.cancel();
    // _pageController.dispose();
    super.dispose();
  }

  // void _startAutoScroll() {
  //   _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
  //     int nextPage = (_currentPage + 1) % 3; // Boucle entre 0, 1, et 2
  //     _pageController.animateToPage(
  //       nextPage,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 209, 240, 248),
          body: Container(
            width: context.width,
            height: context.height,
            color: AppTheme.primaryColor.withOpacity(0.6),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "onboarding.welcome".tr(),
                        style: AppTheme().stylish1(30, AppTheme.white),
                      ),
                      Text(
                        "onboarding.sunofa".tr(),
                        style: AppTheme().stylish1(
                          50,
                          AppTheme.white,
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: context.heightPercent(10)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     _buildOption(
                  //       onTap: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) {
                  //               return const AddMapFormScreen();
                  //             },
                  //           ),
                  //         );
                  //       },
                  //       text: "onboarding.add_address".tr(),
                  //       icon: HeroIcons.mapPin,
                  //     ),
                  //     _buildOption(
                  //       onTap: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) {
                  //               return const AddMapFormScreen();
                  //             },
                  //           ),
                  //         );
                  //       },
                  //       text: "onboarding.join_address".tr(),
                  //       icon: HeroIcons.map,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: context.heightPercent(20)),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     color: AppTheme.white,
                  //   ),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) {
                  //             return const AuthenticateScreen();
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 50,
                  //         vertical: 12,
                  //       ),
                  //       child: Text(
                  //         "onboarding.connexion".tr(),
                  //         style: AppTheme().stylish1(15, AppTheme.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SubmitButton(
                          text: "onboarding.login".tr(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const AuthenticateScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SubmitButton(
                          text: "onboarding.register".tr(),
                          color: AppTheme.complementaryColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RegisterScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
