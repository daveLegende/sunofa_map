import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/addMap/pages/add_map_form_screen.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/presentation/views/params/pages/params.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../widgets/addresse_find.dart';
import '../widgets/search_field.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    this.user,
  });
  final UserEntity? user;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = TextEditingController(text: "Maison IDAH");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedLanguage = 'French';
  void _onLanguageChanged(String newLanguage) {
    setState(() {
      selectedLanguage = newLanguage;
    });
  }

  @override
  void initState() {
    super.initState();
    // getPermissions();
    controller.addListener(() {
      setState(() {});
    });
  }

  // getPermissions() async {
  //   await Geolocator.openAppSettings();
  //   await Geolocator.openLocationSettings();
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {},
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Sunofa Map',
                style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu, color: AppTheme.white),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if (state is UserSuccessState) {
                      Navigator.pushNamed(
                        context,
                        Routes.notifScreen,
                      );
                    } else {
                      Helpers().toast(
                        color: mblack,
                        message: "problème de connection internet!!",
                      );
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.white,
                        width: 1,
                      ),
                    ),
                    child: const HeroIcon(
                      HeroIcons.bellAlert,
                      color: AppTheme.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.widthPercent(2),
                ),
                GestureDetector(
                  onTap: () {
                    if (state is UserSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ParamScreen(user: state.user),
                        ),
                      );
                    } else {
                      Helpers().toast(
                        color: mblack,
                        message: "problème de connection internet!!",
                      );
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.white,
                      ),
                    ),
                    child: const HeroIcon(
                      HeroIcons.cog,
                      color: AppTheme.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.widthPercent(3),
                ),
              ],
              backgroundColor: AppTheme.primaryColor,
            ),
            drawer: NavigationDrawer(
              selectedLanguage: selectedLanguage,
              onLanguageChanged: _onLanguageChanged,
            ),
            body: Stack(
              children: [
                SizedBox(
                  width: context.width,
                  height: context.height,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/dash.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: context.widthPercent(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppTheme.primaryColor,
                            ),
                            child: InkWell(
                              onTap: () {
                                if (state is UserSuccessState) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddMapFormScreen(
                                        user: state.user,
                                      ),
                                    ),
                                  );
                                } else {
                                  Helpers().toast(
                                    color: mblack,
                                    message: "problème de connection internet!!",
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add,
                                        color: AppTheme.white),
                                    Text(
                                      'Address',
                                      style: AppTheme().stylish1(
                                        15,
                                        AppTheme.white,
                                        isBold: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: context.widthPercent(2)),
                          Expanded(
                            child: SearchField(
                              controller: controller,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                if (controller.text == "Maison IDAH")
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: context.height / 1.5,
                    child: const AddresseSearch(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Drawer personnalisé
class NavigationDrawer extends StatefulWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;
  const NavigationDrawer({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: context.heightPercent(3),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sunofa Map',
                  style: AppTheme().stylish1(24, AppTheme.black, isBold: true),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const HeroIcon(
                    HeroIcons.xMark,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: context.heightPercent(3),
          ),
          const Divider(),
          SizedBox(
            height: context.heightPercent(3),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 90),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.primaryColor,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/AddMapFormScreen');
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add',
                        style: AppTheme()
                            .stylish1(15, AppTheme.white, isBold: true),
                      ),
                      const Icon(Icons.add, color: AppTheme.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.heightPercent(3),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: Text(
              'Search',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: Text(
              'Notes',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/NotesScreen');
            },
          ),
          ListTile(
            leading: const HeroIcon(HeroIcons.bookOpen),
            title: Text(
              'Address book',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/AddressBookScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text(
              'Favorites',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/FavScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text(
              'My addresses',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/MyAddressesScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: DropdownButton<String>(
              value: widget.selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  widget.onLanguageChanged(newValue);
                }
              },
              items: <String>['French', 'English', 'Spanish']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              'About',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/AboutScreen');
            },
          ),
          SizedBox(
            height: context.heightPercent(15),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Se connecter',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Loginscreen');
            },
          )
        ],
      ),
    );
  }
}
