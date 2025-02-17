import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/clipper/clipper.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_state.dart';
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
    return Scaffold(
      backgroundColor: mwhite,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home2,
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
                      const AuthHeader(
                        title: "Login",
                        desc:
                            "Please enter your login credentials to continue.",
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
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              prefixIcon: const HeroIcon(
                                HeroIcons.envelope,
                                color: mgrey,
                                // size: 50,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your e-mail';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            DecoratedField(
                              controller: passwordController,
                              hintText: '********',
                              labelText: 'Password',
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
                                    text: 'Connexion',
                                    onTap: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      context.read<LoginCubit>().login(
                                            LoginDTO(
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text
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
                                  "Vous n'avez pas de compte ? ",
                                  style: AppTheme().stylish1(
                                    15,
                                    AppTheme.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/Registerscreen',
                                    );
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
