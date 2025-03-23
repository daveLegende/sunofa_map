import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/views/about/about.dart';
import 'package:sunofa_map/presentation/views/addresses/widgets/show_delete.dart';
import 'package:sunofa_map/presentation/views/onboarding/onboarding_screen.dart';
import 'package:sunofa_map/presentation/views/politic/politic.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import 'setting_listile.dart';

class SettingOthers extends StatelessWidget {
  const SettingOthers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {
        // print("Langue choisie: ${state.selectedLocale.languageCode}");
        // setState(() {});
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "param.other".tr(),
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
                      title: "param.condition".tr(),
                      trailing: "",
                      leading: HeroIcons.documentText,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const PoliticScreen();
                            },
                          ),
                        );
                      }),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Center(
                      child: CustomDivider(),
                    ),
                  ),
                  SettingListTileItem(
                    title: "param.politic".tr(),
                    trailing: "",
                    leading: HeroIcons.shieldCheck,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const PoliticScreen();
                          },
                        ),
                      );
                    },
                  ),
                  // Container(
                  //   height: 20,
                  //   padding: const EdgeInsets.symmetric(horizontal: 5),
                  //   child: const Center(
                  //     child: CustomDivider(),
                  //   ),
                  // ),
                  // SettingListTileItem(
                  //   title: "param.directive".tr(),
                  //   trailing: "",
                  //   leading: HeroIcons.userGroup,
                  // ),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Center(
                      child: CustomDivider(),
                    ),
                  ),
                  SettingListTileItem(
                    title: "param.support".tr(),
                    trailing: "",
                    leading: HeroIcons.bookOpen,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AboutScreen();
                          },
                        ),
                      );
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
                    title: "param.logout".tr(),
                    trailing: "",
                    leading: HeroIcons.power,
                    titleColor: AppTheme.complementaryColor,
                    trailingColor: AppTheme.complementaryColor,
                    leadingColor: AppTheme.complementaryColor,
                    isBold: true,
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) {
                          return DeleteAdresseWidget(
                            size: MediaQuery.of(context).size,
                            delOrLogoutText: "param.logout_profil".tr(),
                            text: "param.modal_label".tr(),
                            onDel: () async {
                              await PreferenceServices()
                                  .removeToken()
                                  .then((_) async {
                                await PreferenceServices()
                                    .removeUser()
                                    .then((_) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) {
                                      return const OnboardingScreen();
                                    }),
                                    (route) => false,
                                  );
                                });
                              });
                            },
                            onCancel: () {
                              Navigator.pop(_);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
