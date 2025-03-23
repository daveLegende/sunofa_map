import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/clipper/clipper.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/register/register_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/register/register_state.dart';
import 'package:sunofa_map/presentation/views/home/pages/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Controller pour le champ de téléphone
  final TextEditingController phoneController = TextEditingController();
  String initialCountry = 'US';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');

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
          body: BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                // Helpers().mySnackbar(
                //   context: context,
                //   message: "Register Successful",
                // );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Home();
                    },
                  ),
                  (route) => false,
                );
              } else if (state is RegisterFailedState) {
                Helpers().mySnackbar(context: context, message: state.message);
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
                            title: "register.title".tr(),
                            desc: "register.desc".tr(),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  DecoratedField(
                                    hintText: 'ex: Jean Marck',
                                    labelText: "register.name_label".tr(),
                                    keyboardType: TextInputType.name,
                                    controller: nameController,
                                    prefixIcon: const HeroIcon(
                                      HeroIcons.user,
                                      color: mgrey,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "register.username_empty".tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
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
                                  PhoneFieldDecorated(
                                    hintText: "201-555-0123",
                                    labelText: "register.phone_label".tr(),
                                    keyboardType: TextInputType.emailAddress,
                                    controller: phoneController,
                                    prefixIcon: const HeroIcon(
                                      HeroIcons.envelope,
                                      color: mgrey,
                                      // size: 50,
                                    ),
                                    onCodeChanged: (code) async {
                                      // setState(() {
                                      // });
                                      PhoneNumber updatedNumber =
                                          await PhoneNumber
                                              .getRegionInfoFromPhoneNumber(
                                        phoneController.text,
                                        code.code!,
                                      );
                                      setState(() {
                                        initialCountry = code.dialCode!;
                                        phoneNumber = updatedNumber;
                                      });
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
                                        return mPassNullError;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  DecoratedField(
                                    hintText: '********',
                                    labelText: "register.confirm_pass".tr(),
                                    controller: confirmPasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon: const HeroIcon(
                                      HeroIcons.lockClosed,
                                      color: mgrey,
                                    ),
                                    obscureText: isObscure,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "register.confirm_empty".tr();
                                      } else if (value !=
                                          passwordController.text) {
                                        return "register.pass_dont_match".tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: context.heightPercent(5)),
                                  isLoading
                                      ? const LoadingCircle()
                                      : SubmitButton(
                                          text: "register.create_account".tr(),
                                          onTap: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              context
                                                  .read<RegisterCubit>()
                                                  .register(
                                                    UserDTO(
                                                      name: nameController.text
                                                          .trim(),
                                                      email: emailController
                                                          .text
                                                          .trim(),
                                                      phoneNumber:
                                                          phoneController.text
                                                              .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim(),
                                                    ),
                                                  )
                                                  .then(
                                                    (value) => setState(() {
                                                      isLoading = false;
                                                    }),
                                                  );
                                            }
                                          },
                                        ),
                                  // isLoading
                                  //     ? const LoadingCircle()
                                  //     : SubmitButton(
                                  //         text: 'Create Account',
                                  //         onTap: () {
                                  //           print(passwordController.text.trim());
                                  //           setState(() {
                                  //             isLoading = true;
                                  //           });
                                  //           if (formKey.currentState!.validate()) {
                                  //             context
                                  //                 .read<RegisterCubit>()
                                  //                 .register(
                                  //                   UserDTO(
                                  //                     name: nameController.text.trim(),
                                  //                     email:
                                  //                         emailController.text.trim(),
                                  //                     phoneNumber:
                                  //                         phoneController.text.trim(),
                                  //                     password: passwordController.text
                                  //                         .trim(),
                                  //                   ),
                                  //                 )
                                  //                 .then(
                                  //                   (value) => setState(() {
                                  //                     isLoading = false;
                                  //                   }),
                                  //                 );
                                  //           }
                                  //         },
                                  //       ),
                                ],
                              ),
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
