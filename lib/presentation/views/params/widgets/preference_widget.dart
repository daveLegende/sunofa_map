import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/services/preferences.dart';

import 'langue_select.dart';
import 'setting_listile.dart';

class SettingPreference extends StatefulWidget {
  const SettingPreference({
    super.key,
    this.onDisableNotify,
    required this.trailing,
  });
  final String trailing;
  final VoidCallback? onDisableNotify;

  @override
  State<SettingPreference> createState() => _SettingPreferenceState();
}

class _SettingPreferenceState extends State<SettingPreference> {
  bool isNotifEnable = true;
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  getPermission() async {
    final permission = await PreferenceServices().getNotificationPermission();
    setState(() {
      isNotifEnable = permission ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "param.pref_label".tr(),
              style: const TextStyle(
                fontSize: 14,
                color: mgrey,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: mwhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  SettingListTileItem(
                    title: "param.langues".tr(),
                    trailing: context.locale == const Locale('en')
                        ? "langues.english".tr()
                        : "langues.french".tr(),
                    leading: HeroIcons.language,
                    onTap: () async {
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (_) {
                      //     return BlocProvider(
                      //       create: (context) => LangueChooseBloc(),
                      //       child: const SelectLangueSheet(),
                      //     );
                      //   },
                      // );
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<
                                LangueChooseBloc>(), // Utilisez l'instance existante du Bloc
                            child: const SelectLangueSheet(),
                          );
                        },
                      );
                      // if (context.locale == const Locale('en')) {
                      //   await context.setLocale(const Locale('fr'));
                      //   context.read<LangueChooseBloc>().add(
                      //         const ChangeLanguage(Locale('fr')),
                      //       );
                      // } else {
                      //   await context.setLocale(const Locale('en'));
                      //   context.read<LangueChooseBloc>().add(
                      //         const ChangeLanguage(Locale('en')),
                      //       );
                      // }
                    },
                  ),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Center(
                      child: CustomDivider(),
                    ),
                  ),
                  SettingListTileItem(
                    title: "param.notification".tr(),
                    trailing: widget.trailing,
                    leading: HeroIcons.bell,
                    onTap: widget.onDisableNotify,
                  ),
                  // Container(
                  //   height: 20,
                  //   padding: const EdgeInsets.symmetric(horizontal: 5),
                  //   child: const Center(
                  //     child: CustomDivider(),
                  //   ),
                  // ),
                  // const SettingListTileItem(
                  //   title: "Thèmes",
                  //   trailing: "Clair",
                  //   leading: HeroIcons.paintBrush,
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
