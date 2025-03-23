import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/clipper/clipper.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_state.dart';
import 'package:sunofa_map/presentation/views/auth/pages/auth_register.dart';
import 'package:sunofa_map/presentation/views/home/pages/home.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mwhite,
          body: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                setState(() {
                  isLoading = false;
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Home();
                    },
                  ),
                  (route) => false,
                );
              } else if (state is LoginFailedState) {
                Helpers().mySnackbar(context: context, message: state.message);
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: context.width / 2,
                      child: CustomPaint(
                        size: Size(context.width, context.width / 2),
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: -5,
                      child: CustomPaint(
                        size: Size(context.width, context.width / 2),
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    const Positioned(
                      // top: 50,
                      // left: 10,
                      child: SafeArea(
                        child: BackArrow(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: context.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 150),
                          AuthHeader(
                            title: "login.title".tr(),
                            desc: "login.desc".tr(),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                DecoratedField(
                                  hintText: 'sunofa.map@gmail.com',
                                  labelText: "login.email_label".tr(),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  prefixIcon: const HeroIcon(
                                    HeroIcons.envelope,
                                    color: mgrey,
                                    // size: 50,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "login.email_empty".tr();
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                DecoratedField(
                                  controller: passwordController,
                                  hintText: '********',
                                  labelText: "login.pass_label".tr(),
                                  obscureText: isObscure,
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon: const HeroIcon(
                                    HeroIcons.lockClosed,
                                    color: mgrey,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    child: HeroIcon(
                                      isObscure
                                          ? HeroIcons.eye
                                          : HeroIcons.eyeSlash,
                                      color: mgrey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "login.pass_empty".tr();
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.heightPercent(2)),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Action "Mot de passe oublié"
                                    },
                                    child: Text(
                                      "login.pass_forget".tr(),
                                      style: AppTheme().stylish1(
                                        13,
                                        AppTheme.complementaryColor,
                                        isBold: true,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.heightPercent(3)),
                                isLoading
                                    ? const LoadingCircle()
                                    : SubmitButton(
                                        text: "login.connexion".tr(),
                                        onTap: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          context.read<LoginCubit>().login(
                                                LoginDTO(
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                ),
                                              );
                                        },
                                      ),
                                SizedBox(height: context.heightPercent(2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "login.not_have_account".tr(),
                                      style: AppTheme().stylish1(
                                        15,
                                        AppTheme.black,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const RegisterScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "login.create_account".tr(),
                                        style: AppTheme().stylish1(
                                          15,
                                          AppTheme.primaryColor,
                                          isBold: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
