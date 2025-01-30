import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/profil/bloc/update_user_cubit.dart';
import 'package:sunofa_map/presentation/views/profil/bloc/update_user_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ModifierUserInfoScreen extends StatefulWidget {
  const ModifierUserInfoScreen({
    super.key,
    required this.user,
  });
  final UserEntity user;

  @override
  State<ModifierUserInfoScreen> createState() => _ModifierUserInfoScreenState();
}

class _ModifierUserInfoScreenState extends State<ModifierUserInfoScreen> {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    email = TextEditingController(text: widget.user.email);
    phone = TextEditingController(text: widget.user.phoneNumber);
    username = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(),
        title: Text(
          "Modification des informations",
          style: AppTheme().stylish1(
            20,
            AppTheme.primaryColor,
            isBold: true,
          ),
        ),
      ),
      bottomSheet: isKeyboardVisible || isLoading
          ? const SizedBox()
          : ModiferUserInfoSheet(
              onTap: () {
                print(widget.user.id);
                setState(() {
                  isLoading = true;
                });
                if (formKey.currentState!.validate()) {
                  context
                      .read<UpdateUserCubit>()
                      .updateUser(
                        UserDTO(
                          id: widget.user.id,
                          name: username.text.trim(),
                          email: email.text.trim(),
                          phoneNumber: phone.text.trim(),
                          password: widget.user.password,
                        ),
                      )
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                }
              },
            ),
      body: BlocListener<UpdateUserCubit, UpdateUserState>(
        listener: (context, state) {
          if (state is UpdateUserSuccessState) {
            Helpers().mySnackbar(
              context: context,
              message: state.message,
            );
            context.read<UserCubit>().getCurrentUser();
          } else if (state is UpdateUserFailedState) {
            Helpers().mySnackbar(
              context: context,
              color: AppTheme.red,
              message: state.message,
            );
          }
        },
        child: Container(
          height: context.height,
          color: AppTheme.lightGray,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your new name",
                        style: TextStyle(color: mgrey),
                      ),
                      SimpleTextField(
                        hintText: username.text,
                        controller: username,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your new mail",
                        style: TextStyle(color: mgrey),
                      ),
                      SimpleTextField(
                        hintText: email.text,
                        controller: email,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your new phone number",
                        style: TextStyle(color: mgrey),
                      ),
                      SimpleTextField(
                        hintText: phone.text,
                        controller: phone,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ModiferUserInfoSheet extends StatelessWidget {
  const ModiferUserInfoSheet({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: mwhite,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: SubmitButton(
        text: "Soumettre les modifications",
        onTap: onTap,
      ),
    );
  }
}
