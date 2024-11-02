import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/themes/app_themes.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedLanguage = 'French';
    void _onLanguageChanged(String newLanguage) {
    setState(() {
      selectedLanguage = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: context.heightPercent(10),
            width: context.widthPercent(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.white, width: 3)),
            child: IconButton(
              icon: const HeroIcon(
                HeroIcons.bellAlert,
                color: AppTheme.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/NotifScreen');
              },
            ),
          ),
          SizedBox(
            width: context.widthPercent(2),
          ),
          Container(
            height: context.heightPercent(10),
            width: context.widthPercent(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.white, width: 3)),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.question_mark,
                  color: AppTheme.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/AboutScreen');
                },
              ),
            ),
          ),
          SizedBox(
            width: context.widthPercent(2),
          ),
            DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (String? newValue) {
              _onLanguageChanged(newValue!);
            },
            items: <String>['French', 'English', 'Spanish']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/dash.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
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
                          Navigator.pushNamed(context, '/AddMapFormScreen');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add, color: AppTheme.white),
                              Text(
                                'Address',
                                style: AppTheme()
                                    .stylish1(15, AppTheme.white, isBold: true),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.widthPercent(2)),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search.....",
                          hintStyle: AppTheme().stylish1(15, AppTheme.black),
                          suffixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

// Drawer personnalisé
class NavigationDrawer extends StatefulWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;
  const NavigationDrawer({super.key, required this.selectedLanguage,
    required this.onLanguageChanged,});

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
