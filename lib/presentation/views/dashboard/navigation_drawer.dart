

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';

import '../../../themes/app_themes.dart';

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
          ),
        ],
      ),
    );
  }
}
