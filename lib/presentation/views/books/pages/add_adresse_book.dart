import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/adressebook/adresse_book.dto.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/create/create_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/create/create_state.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AddAdresseBook extends StatefulWidget {
  const AddAdresseBook({super.key});

  @override
  State<AddAdresseBook> createState() => _AddAdresseBookState();
}

class _AddAdresseBookState extends State<AddAdresseBook> {
  final formKey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final locality = TextEditingController();
  final appart = TextEditingController();
  final googleAdress = TextEditingController();
  bool hasGoogleAddress = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
        listener: (context, state) {},
        builder: (context, state) {
        return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mwhite,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: const BackArrow(),
              title: Text(
                "add_book.appbar".tr(),
                style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 20,
              ),
              child: BlocListener<CreateBookCubit, CreateBookState>(
                listener: (context, state) {
                  if (state is CreateBookSuccessState) {
                    Helpers().mySnackbar(
                      context: context,
                      message: state.message,
                    );
                    context.read<BookCubit>().getBooks();
                    setState(() {
                      isLoading = false;
                      // Réinitialisation des champs
                      fullName.clear();
                      locality.clear();
                      appart.clear();
                      googleAdress.clear();
                      hasGoogleAddress = false;
                    });
                  } else if (state is CreateBookFailedState) {
                    Helpers().mySnackbar(
                      context: context,
                      message: state.message,
                      color: mred,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "add_book.full_name".tr(),
                            style: AppTheme().stylish1(
                              15,
                              AppTheme.black,
                              // isBold: true,
                            ),
                          ),
                          SimpleTextField(
                            hintText: "add_book.full_name".tr(),
                            controller: fullName,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "add_book.locality".tr(),
                            style: AppTheme().stylish1(
                              15,
                              AppTheme.black,
                              // isBold: true,
                            ),
                          ),
                          SimpleTextField(
                            hintText: "add_book.locality".tr(),
                            controller: locality,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "add_book.appart".tr(),
                            style: AppTheme().stylish1(
                              15,
                              AppTheme.black,
                              // isBold: true,
                            ),
                          ),
                          SimpleTextField(
                            hintText: "add_book.appart".tr(),
                            controller: appart,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "add_book.add_ga".tr(),
                          ),
                          const SizedBox(width: 10),
                          Checkbox(
                            value: hasGoogleAddress,
                            onChanged: (val) {
                              setState(() {
                                hasGoogleAddress = val!;
                              });
                            },
                          ),
                        ],
                      ),
                      hasGoogleAddress
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "add_book.ga".tr(),
                                  style: AppTheme().stylish1(
                                    15,
                                    AppTheme.black,
                                    // isBold: true,
                                  ),
                                ),
                                SimpleTextField(
                                  hintText: "add_book.ga".tr(),
                                  controller: googleAdress,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 40),
                      isLoading
                          ? const LoadingCircle()
                          : SubmitButton(
                              text: "add_book.save".tr(),
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                print(fullName.text);
                                if (formKey.currentState!.validate()) {
                                  if (state is UserSuccessState) {
                                    context.read<CreateBookCubit>().createBooks(
                                          AdresseBookDTO(
                                            personName: fullName.text.trim(),
                                            addressLabel: locality.text.trim(),
                                            apartmentSuiteNote: appart.text.trim(),
                                            hasGoogleAddress: hasGoogleAddress,
                                            googleAddress: hasGoogleAddress
                                                ? googleAdress.text.trim()
                                                : "",
                                            user_id: state.user.id!.toString(),
                                          ),
                                        );
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      }
    );
  }
}
