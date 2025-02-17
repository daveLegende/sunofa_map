import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../widgets/others.dart';
import '../widgets/preference_widget.dart';
import '../widgets/profil_card.dart';

class ParamScreen extends StatelessWidget {
  const ParamScreen({
    super.key,
    this.user,
  });
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
    final user = this.user!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(
          routeNamed: Routes.home2,
        ),
        title: Text(
          "Paramètres",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
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
                const SettingPreference(),
                const SizedBox(height: 15),
                const SettingOthers(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
