import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class SelectLangueSheet extends StatefulWidget {
  const SelectLangueSheet({super.key});

  @override
  State<SelectLangueSheet> createState() => _SelectLangueSheetState();
}

class _SelectLangueSheetState extends State<SelectLangueSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {
        print("Langue choisie: ${state.selectedLocale.languageCode}");
        setState(() {});
        Navigator.pop(context);
      },
      builder: (context, state) {
        final isFrench = state.selectedLocale.languageCode == 'fr';

        return StatefulBuilder(builder: (context, setState) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints.expand(height: size.width * .4),
                child: Container(
                  decoration: const BoxDecoration(
                    color: mwhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LangueTile(
                          text: "langues.french".tr(),
                          icon: Icons.check_circle,
                          isSelect: context.locale == const Locale('fr')
                              ? true
                              : false,
                          onTap: () async {
                            await context.setLocale(const Locale('fr'));
                            context.read<LangueChooseBloc>().add(
                                  const ChangeLanguage(Locale('fr')),
                                );
                          },
                        ),
                        const CustomDivider(),
                        LangueTile(
                          text: "langues.english".tr(),
                          icon: Icons.check_circle,
                          isSelect: context.locale == const Locale('en')
                              ? true
                              : false,
                          onTap: () async {
                            await context.setLocale(const Locale('en'));
                            context.read<LangueChooseBloc>().add(
                                  const ChangeLanguage(Locale('en')),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}

class LangueTile extends StatelessWidget {
  const LangueTile({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelect,
    this.onTap,
  });
  final bool isSelect;
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTheme().stylish1(
                15,
                isSelect ? AppTheme.complementaryColor : mblack,
                isBold: true,
              ),
            ),
            isSelect
                ? Icon(
                    icon,
                    color: AppTheme.complementaryColor,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
