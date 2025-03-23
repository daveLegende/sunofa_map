// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:heroicons/heroicons.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:sunofa_map/common/helpers/helper.dart';
// import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
// import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
// import 'package:sunofa_map/common/widgets/index.dart';
// import 'package:sunofa_map/common/widgets/loading_circle.dart';
// import 'package:sunofa_map/core/utils/index.dart';
// import 'package:sunofa_map/data/models/user/user.dto.dart';
// import 'package:sunofa_map/presentation/routes/app_routes.dart';
// import 'package:sunofa_map/presentation/views/auth/bloc/register/register_cubit.dart';
// import 'package:sunofa_map/presentation/views/auth/bloc/register/register_state.dart';
// import 'package:sunofa_map/themes/app_themes.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   // Controller pour le champ de téléphone
//   final TextEditingController phoneController = TextEditingController();
//   String initialCountry = 'US';
//   PhoneNumber phoneNumber = PhoneNumber(isoCode: 'US');

//   final formKey = GlobalKey<FormState>();

//   bool isObscure = true;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mgrey[100],
//       body: Container(
//         width: context.width,
//         height: context.height,
//         color: mwhite,
//         child: BlocListener<RegisterCubit, RegisterState>(
//           listener: (context, state) {
//             if (state is RegisterSuccessState) {
//               Helpers().mySnackbar(
//                 context: context,
//                 message: "Register Successful",
//               );
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 Routes.home2,
//                 (route) => false,
//               );
//             } else if (state is RegisterFailedState) {
//               Helpers().mySnackbar(context: context, message: state.message);
//             }
//           },
//           child: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const BackArrow(
//                   routeNamed: Routes.registerScreen,
//                 ),
//                 const AuthHeader(
//                   title: "Register",
//                   desc: "Veuillez remplir ces champs pour créer votre compte",
//                 ),
//                 SizedBox(height: context.heightPercent(3)),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     child: Form(
//                       key: formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Nom d\'utilisateur',
//                             style: AppTheme().stylish1(15, AppTheme.black),
//                           ),
//                           SimpleTextField(
//                             hintText: 'ex: Jean Marck',
//                             keyboardType: TextInputType.name,
//                             controller: nameController,
//                             suffixIcon: const HeroIcon(
//                               HeroIcons.user,
//                               color: mgrey,
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Veuillez entrer votre nom complet";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: context.heightPercent(3)),
//                           // Champ E-mail
//                           Text(
//                             'Adresse email',
//                             style: AppTheme().stylish1(15, AppTheme.black),
//                           ),
//                           SimpleTextField(
//                             hintText: 'sunofa.map@gmail.com',
//                             keyboardType: TextInputType.emailAddress,
//                             controller: emailController,
//                             prefixIcon: const HeroIcon(
//                               HeroIcons.envelope,
//                               color: mgrey,
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your e-mail';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: context.heightPercent(3)),
//                           Text(
//                             'Numéro de téléphone',
//                             style: AppTheme().stylish1(15, AppTheme.black),
//                           ),
//                           SizedBox(
//                             // height: 55,
//                             child: InternationalPhoneNumberInput(
//                               textStyle: AppTheme().stylish1(16, mblack),
//                               onInputChanged: (PhoneNumber number) {
//                                 // print(number.phoneNumber);
//                               },
//                               onInputValidated: (bool isValid) {
//                                 // print('Valid number: $isValid');
//                               },
//                               selectorConfig: const SelectorConfig(
//                                 selectorType: PhoneInputSelectorType.DIALOG,
//                               ),
//                               ignoreBlank: false,
//                               autoValidateMode: AutovalidateMode.disabled,
//                               selectorTextStyle:
//                                   const TextStyle(color: Colors.black),
//                               initialValue: phoneNumber,
//                               textFieldController: phoneController,
//                               formatInput: true,
//                               keyboardType:
//                                   const TextInputType.numberWithOptions(
//                                 signed: true,
//                                 decimal: true,
//                               ),
//                               inputDecoration: InputDecoration(
//                                 filled: true,
//                                 fillColor:
//                                     AppTheme.primaryColor.withOpacity(.09),
//                                 hintText: '201-555-0123',
//                                 hintStyle: AppTheme().stylish1(15, mgrey),
//                                 prefixIcon: const HeroIcon(
//                                   HeroIcons.phone,
//                                   color: mgrey,
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                               onSaved: (PhoneNumber number) {
//                                 // print('Saved number: $number');
//                               },
//                             ),
//                           ),
//                           SizedBox(height: context.heightPercent(3)),
//                           // Champ Mot de passe
//                           Text(
//                             'Mot de passe',
//                             style: AppTheme().stylish1(15, AppTheme.black),
//                           ),

//                           SimpleTextField(
//                             controller: passwordController,
//                             hintText: 'Entrer votre mot de passe',
//                             obscureText: isObscure,
//                             keyboardType: TextInputType.visiblePassword,
//                             prefixIcon: const HeroIcon(
//                               HeroIcons.lockClosed,
//                               color: mgrey,
//                             ),
//                             suffixIcon: InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   isObscure = !isObscure;
//                                 });
//                               },
//                               child: HeroIcon(
//                                 isObscure ? HeroIcons.eye : HeroIcons.eyeSlash,
//                                 color: mgrey,
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return mPhoneNumberInvalide;
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: context.heightPercent(3)),
//                           // Champ Confirmation du mot de passe
//                           Text(
//                             'Confirmez mot de passe',
//                             style: AppTheme().stylish1(15, AppTheme.black),
//                           ),
//                           SimpleTextField(
//                             hintText: 'confirm password',
//                             controller: confirmPasswordController,
//                             keyboardType: TextInputType.visiblePassword,
//                             prefixIcon: const HeroIcon(
//                               HeroIcons.lockClosed,
//                               color: mgrey,
//                             ),
//                             obscureText: isObscure,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Veuillez confirmer votre mot de passe';
//                               } else if (value != passwordController.text) {
//                                 return 'Les mots de passe ne correspondent pas';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: context.heightPercent(5)),
//                           isLoading
//                               ? const LoadingCircle()
//                               : SubmitButton(
//                                   text: 'Register',
//                                   onTap: () {
//                                     print(passwordController.text.trim());
//                                     setState(() {
//                                       isLoading = true;
//                                     });
//                                     if (formKey.currentState!.validate()) {
//                                       context
//                                           .read<RegisterCubit>()
//                                           .register(
//                                             UserDTO(
//                                               name: nameController.text.trim(),
//                                               email:
//                                                   emailController.text.trim(),
//                                               phoneNumber:
//                                                   phoneController.text.trim(),
//                                               password: passwordController.text
//                                                   .trim(),
//                                             ),
//                                           )
//                                           .then(
//                                             (value) => setState(() {
//                                               isLoading = false;
//                                             }),
//                                           );
//                                     }
//                                   },
//                                 ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
