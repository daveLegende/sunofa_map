import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/presentation/views/params/widgets/langue_select.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../widgets/others.dart';
import '../widgets/preference_widget.dart';
import '../widgets/profil_card.dart';

class ParamScreen extends StatefulWidget {
  const ParamScreen({
    super.key,
    this.user,
  });
  final UserEntity? user;

  @override
  State<ParamScreen> createState() => _ParamScreenState();
}

class _ParamScreenState extends State<ParamScreen> {
  bool isNotifEnable = true;
  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
    final user = widget.user!;

    return BlocListener<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {
        context.setLocale(state.selectedLocale);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mwhite,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: const BackArrow(
            routeNamed: Routes.home2,
          ),
          title: Text(
            "param.appbar".tr(),
            style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
          ),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Container(
              width: context.width,
              height: context.height,
              color: AppTheme.lightGray,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingProfilCard(
                      user: state is UserSuccessState ? state.user : user,
                    ),
                    const SizedBox(height: 15),
                    SettingPreference(
                      trailing: isNotifEnable
                        ? "param.active_notif".tr()
                        : "param.disable".tr(),
                      onDisableNotify: () {
                        showNotificationSettings(context, isNotifEnable,
                            (newValue) {
                          setState(() {
                            isNotifEnable = newValue;
                          });
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    const SettingOthers(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showNotificationSettings(
      BuildContext context, bool isNotifEnable, Function(bool) onChanged) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.width * .4),
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
                            text: "param.enable".tr(),
                            icon: Icons.check_circle,
                            isSelect: isNotifEnable,
                            onTap: () async {
                              setState(() {
                                isNotifEnable = true;
                              });
                              onChanged(true); // Appeler la fonction de rappel
                            },
                          ),
                          const CustomDivider(),
                          LangueTile(
                            text: "param.disable".tr(),
                            icon: Icons.check_circle,
                            isSelect: !isNotifEnable,
                            onTap: () async {
                              setState(() {
                                isNotifEnable = false;
                              });
                              onChanged(false); // Appeler la fonction de rappel
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
