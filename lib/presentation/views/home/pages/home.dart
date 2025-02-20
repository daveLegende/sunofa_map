import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/views/addresses/pages/addresses.dart';
import 'package:sunofa_map/presentation/views/books/pages/books.dart';
import 'package:sunofa_map/presentation/views/notes/pages/notes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../../dashboard/pages/dashboard_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? currentIndex;
  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final now = DateTime.now();
        final isExitWarning = lastPressed == null ||
            now.difference(lastPressed!) > const Duration(seconds: 2);

        if (isExitWarning) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppTheme.primaryColor,
              content: Text("Appuyez encore pour quitter"),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: context.width,
              height: context.height,
              child: IndexedStack(
                index: currentIndex,
                children: const [
                  DashboardScreen(),
                  NoteScreen(),
                  BooksScreen(),
                  AddresseScreen(),
                ],
              ),
            ),
            isKeyboardVisible
                ? const SizedBox()
                : Positioned(
                    bottom: 20,
                    right: 40,
                    left: 40,
                    child: Container(
                      // width: context.width / 2,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          BottomNavItem(
                            currentIndex: currentIndex!,
                            index: 0,
                            text: "Home",
                            icon: HeroIcons.home,
                            onTap: () {
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                          ),
                          BottomNavItem(
                            currentIndex: currentIndex!,
                            index: 1,
                            text: "Notes",
                            icon: HeroIcons.document,
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                          ),
                          BottomNavItem(
                            currentIndex: currentIndex!,
                            index: 2,
                            text: "Address Book",
                            icon: HeroIcons.bookOpen,
                            onTap: () {
                              setState(() {
                                currentIndex = 2;
                              });
                            },
                          ),
                          BottomNavItem(
                            currentIndex: currentIndex!,
                            index: 3,
                            text: "Address",
                            icon: HeroIcons.bookmark,
                            onTap: () {
                              setState(() {
                                currentIndex = 3;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.currentIndex,
    required this.index,
    this.onTap,
    required this.icon,
    this.text,
  });
  final int currentIndex, index;
  final HeroIcons icon;
  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: currentIndex == index ? 3 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: context.width * .35,
          padding: const EdgeInsets.all(10),
          decoration: currentIndex == index
              ? BoxDecoration(
                  color: currentIndex == index ? mwhite : null,
                  borderRadius: BorderRadius.circular(30),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HeroIcon(
                icon,
                color: currentIndex == index ? AppTheme.primaryColor : mwhite,
                size: 25,
              ),
              currentIndex == index
                  ? Text(
                      text!,
                      maxLines: 2,
                      style: TextStyle(
                        color: currentIndex == index
                            ? AppTheme.primaryColor
                            : mwhite,
                        fontSize: 14,
                        // fontWeight: currentIndex == index
                        //     ? FontWeight.bold
                        //     : FontWeight.normal,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
