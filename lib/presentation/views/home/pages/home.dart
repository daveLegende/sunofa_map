import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/views/addresses/pages/addresses.dart';
import 'package:sunofa_map/presentation/views/books/pages/books.dart';
import 'package:sunofa_map/presentation/views/notes/pages/notes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../../dashboard/pages/dashboard_screen.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int? currentIndex;
//   DateTime? lastPressed;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = 0;
//     _requestPermissions(); // Demander les permissions au démarrage
//   }

//   Future<void> _requestPermissions() async {
//     final permissions = [
//       Permission.camera,
//       Permission.microphone,
//       Permission.photos,
//       Permission.videos,
//       Permission.location,
//     ];

//     for (var permission in permissions) {
//       var status = await permission.status;
//       if (status.isPermanentlyDenied) {
//         await openAppSettings();
//       } else if (!status.isGranted) {
//         await permission.request();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         if (didPop) return;

//         final now = DateTime.now();
//         final isExitWarning = lastPressed == null ||
//             now.difference(lastPressed!) > const Duration(seconds: 2);

//         if (isExitWarning) {
//           lastPressed = now;
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: AppTheme.primaryColor,
//               content: Text("navigation.snack".tr()),
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         } else {
//           if (Platform.isAndroid) {
//             SystemNavigator.pop();
//           } else if (Platform.isIOS) {
//             exit(0);
//           }
//         }
//       },
//       child: Scaffold(
//         body: BlocConsumer<LangueChooseBloc, LangueChooseState>(
//           listener: (context, state) {
//             // print("Langue choisie: ${state.selectedLocale.languageCode}");
//             // setState(() {});
//           },
//           builder: (context, state) {
//             return Stack(
//               children: [
//                 SizedBox(
//                   width: context.width,
//                   height: context.height,
//                   child: IndexedStack(
//                     index: currentIndex,
//                     children: const [
//                       DashboardScreen(),
//                       AddresseScreen(),
//                       BooksScreen(),
//                       NoteScreen(),
//                     ],
//                   ),
//                 ),
//                 isKeyboardVisible
//                     ? const SizedBox()
//                     : Positioned(
//                         bottom: 20,
//                         right: 40,
//                         left: 40,
//                         child: Container(
//                           // width: context.width / 2,
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: AppTheme.primaryColor,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Row(
//                             children: [
//                               BottomNavItem(
//                                 currentIndex: currentIndex!,
//                                 index: 0,
//                                 text: "navigation.home".tr(),
//                                 icon: HeroIcons.home,
//                                 onTap: () {
//                                   setState(() {
//                                     currentIndex = 0;
//                                   });
//                                 },
//                               ),
//                               BottomNavItem(
//                                 currentIndex: currentIndex!,
//                                 index: 1,
//                                 text: "navigation.address".tr(),
//                                 icon: HeroIcons.bookmark,
//                                 onTap: () {
//                                   setState(() {
//                                     currentIndex = 1;
//                                   });
//                                 },
//                               ),
//                               BottomNavItem(
//                                 currentIndex: currentIndex!,
//                                 index: 2,
//                                 text: "navigation.books".tr(),
//                                 icon: HeroIcons.bookOpen,
//                                 onTap: () {
//                                   setState(() {
//                                     currentIndex = 2;
//                                   });
//                                 },
//                               ),
//                               BottomNavItem(
//                                 currentIndex: currentIndex!,
//                                 index: 3,
//                                 text: "navigation.notes".tr(),
//                                 icon: HeroIcons.document,
//                                 onTap: () {
//                                   setState(() {
//                                     currentIndex = 3;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final permissions = [
      Permission.camera,
      Permission.microphone,
      Permission.photos,
      Permission.videos,
      Permission.location,
    ];

    for (var permission in permissions) {
      var status = await permission.status;
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      } else if (!status.isGranted) {
        await permission.request();
      }
    }
  }

  void _onNavItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final now = DateTime.now();
        final isExitWarning = lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2);

        if (isExitWarning) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppTheme.primaryColor,
              content: Text("navigation.snack".tr()),
              duration: const Duration(seconds: 2),
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
        body: BlocConsumer<LangueChooseBloc, LangueChooseState>(
          listener: (context, state) {
            // Gestion des changements de langue
          },
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  width: context.width,
                  height: context.height,
                  child: IndexedStack(
                    index: currentIndex,
                    children: [
                      DashboardScreen(onTabSelected: _onNavItemTapped),
                      AddresseScreen(onTabSelected: _onNavItemTapped),
                      const BooksScreen(),
                      const NoteScreen(),
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
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: [
                              BottomNavItem(
                                currentIndex: currentIndex,
                                index: 0,
                                text: "navigation.home".tr(),
                                icon: HeroIcons.home,
                                onTap: () {
                                  _onNavItemTapped(0);
                                },
                              ),
                              BottomNavItem(
                                currentIndex: currentIndex,
                                index: 1,
                                text: "navigation.address".tr(),
                                icon: HeroIcons.bookmark,
                                onTap: () {
                                  _onNavItemTapped(1);
                                },
                              ),
                              BottomNavItem(
                                currentIndex: currentIndex,
                                index: 2,
                                text: "navigation.books".tr(),
                                icon: HeroIcons.bookOpen,
                                onTap: () {
                                  _onNavItemTapped(2);
                                },
                              ),
                              BottomNavItem(
                                currentIndex: currentIndex,
                                index: 3,
                                text: "navigation.notes".tr(),
                                icon: HeroIcons.document,
                                onTap: () {
                                  _onNavItemTapped(3);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            );
          },
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
        behavior: HitTestBehavior.opaque,
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

// class BottomNavItem extends StatelessWidget {
//   const BottomNavItem({
//     super.key,
//     required this.currentIndex,
//     required this.index,
//     required this.icon,
//     required this.text,
//     this.onTap,
//   });

//   final int currentIndex, index;
//   final HeroIcons icon;
//   final String text;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     bool isSelected = currentIndex == index;

//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque, // ✅ Augmente la zone cliquable
//       child: AnimatedContainer(
//         height: 50,
//         duration: const Duration(milliseconds: 250),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10,), // ✅ Augmente la surface
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.white : null,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min, // ✅ Évite l'expansion inutile
//           children: [
//             HeroIcon(
//               icon,
//               color: isSelected ? AppTheme.primaryColor : Colors.white,
//               size: 25,
//             ),
//             if (isSelected) // ✅ Affiche le texte seulement si l'élément est actif
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     color: AppTheme.primaryColor,
//                     fontSize: 14,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
