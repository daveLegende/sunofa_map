import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      body: Container(
        width: context.width,
        height: context.height,
        color: mwhite,
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.home2,
                (route) => false,
              );
            } else if (state is LoginFailedState) {
              Helpers().mySnackbar(context: context, message: state.message);
            }
          },
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackArrow(),
                const AuthHeader(
                  title: "Login",
                  desc:
                      "Veuillez entrer vos identifiants de connexion pour continuer",
                ),
                SizedBox(height: context.heightPercent(8)),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adresse email',
                          style: AppTheme().stylish1(
                            15,
                            AppTheme.black,
                            // isBold: true,
                          ),
                        ),
                        SimpleTextField(
                          hintText: 'sunofa.map@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          prefixIcon: const HeroIcon(
                            HeroIcons.envelope,
                            color: mgrey,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.heightPercent(3)),
                        Text(
                          'Mot de passe',
                          style: AppTheme().stylish1(
                            16,
                            AppTheme.black,
                            // isBold: true,
                          ),
                        ),
                        SimpleTextField(
                          controller: passwordController,
                          hintText: 'Entrer votre mot de passe',
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
                              isObscure ? HeroIcons.eye : HeroIcons.eyeSlash,
                              color: mgrey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return mPhoneNumberInvalide;
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
                              'Mot de passe oublié ?',
                              style: AppTheme().stylish1(
                                15,
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
                                text: 'Connexion',
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  context.read<LoginCubit>().login(
                                        LoginDTO(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        ),
                                      );
                                  setState(() {
                                    isLoading = true;
                                  });
                                },
                              ),
                        SizedBox(height: context.heightPercent(2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous n'avez pas de compte ? ",
                              style: AppTheme().stylish1(
                                15,
                                AppTheme.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Registerscreen');
                              },
                              child: Text(
                                "Register",
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
                )
              ],
            ),
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Center(
      //     child: SingleChildScrollView(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             'Connexion',
      //             style: AppTheme().stylish1(
      //               20,
      //               AppTheme.black,
      //               isBold: true,
      //             ),
      //           ),
      //           const SizedBox(height: 32),
      //           Text(
      //             'Email',
      //             style: AppTheme().stylish1(
      //               15,
      //               AppTheme.black,
      //               isBold: false,
      //             ),
      //           ),
      //           AppHelpers.buildTextFormField(
      //             hint: 'email',
      //             controller: emailController,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Please enter your e-mail';
      //               }
      //               return null;
      //             },
      //           ),
      //           SizedBox(height: context.heightPercent(5)),
      //           Text(
      //             'Password',
      //             style: AppTheme().stylish1(
      //               15,
      //               AppTheme.black,
      //               isBold: false,
      //             ),
      //           ),
      //           AppHelpers.buildTextFormField(
      //             hint: 'Password',
      //             isPassword: true,
      //             controller: passwordController,
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return 'Please enter your password ';
      //               }
      //               return null;
      //             },
      //           ),
      //           SizedBox(height: context.heightPercent(2)),
      //           TextButton(
      //             onPressed: () {
      //               // Action "Mot de passe oublié"
      //             },
      //             child: const Text('Forgot your password?'),
      //           ),
      //           SizedBox(height: context.heightPercent(3)),
      //           Center(
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(15),
      //                 color: AppTheme.primaryColor,
      //               ),
      //               child: InkWell(
      //                 onTap: () {
      //                   Navigator.pushNamed(context, '/Dashboardscreen');
      //                 },
      //                 child: Padding(
      //                   padding: const EdgeInsets.symmetric(
      //                       horizontal: 50, vertical: 12),
      //                   child: Text(
      //                     'Connexion',
      //                     style: AppTheme().stylish1(15, AppTheme.white),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           SizedBox(height: context.heightPercent(2)),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text("don't have an account? ",
      //                   style: AppTheme().stylish1(15, AppTheme.black)),
      //               TextButton(
      //                 onPressed: () {
      //                   Navigator.pushNamed(context, '/Registerscreen');
      //                 },
      //                 child: Text(
      //                   "Register",
      //                   style: AppTheme()
      //                       .stylish1(15, AppTheme.primaryColor, isBold: true),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
