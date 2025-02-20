import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/fields/simple_textfield.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/adressebook/adresse_book.dto.dart';
import 'package:sunofa_map/domain/entities/adressebook/adresse_book.entity.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/edit/edit_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/edit/edit_state.dart';
import 'package:sunofa_map/presentation/views/editAdresse/widgets/edit_adresse_sheet.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({
    super.key,
    required this.book,
  });
  final AdresseBookEntity book;

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController fullName;
  late TextEditingController locality;
  late TextEditingController appart;
  late TextEditingController googleAdress;
  late bool hasGoogleAddress;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialisation des contrôleurs avec les données existantes
    fullName = TextEditingController(text: widget.book.personName);
    locality = TextEditingController(text: widget.book.addressLabel);
    appart = TextEditingController(text: widget.book.apartmentSuiteNote);
    googleAdress = TextEditingController(text: widget.book.googleAddress);
    hasGoogleAddress = widget.book.hasGoogleAddress;
  }

  @override
  void dispose() {
    // Nettoyer les contrôleurs pour éviter les fuites de mémoire
    fullName.dispose();
    locality.dispose();
    appart.dispose();
    googleAdress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mwhite,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: const BackArrow(),
        title: Text(
          "Modifier un carnet",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: SizedBox(
        height: context.height,
        child: BlocListener<EditBookCubit, EditBookState>(
          listener: (context, state) {
            if (state is EditBookSuccessState) {
              Helpers().mySnackbar(
                context: context,
                message: state.message,
              );
              context.read<BookCubit>().getBooks();
            } else if (state is EditBookFailedState) {
              Helpers().mySnackbar(
                context: context,
                color: mred,
                message: state.message,
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full name',
                        style: AppTheme().stylish1(
                          15,
                          AppTheme.black,
                          // isBold: true,
                        ),
                      ),
                      SimpleTextField(
                        hintText: "Full name",
                        controller: fullName,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Locality (In memory)',
                        style: AppTheme().stylish1(
                          15,
                          AppTheme.black,
                          // isBold: true,
                        ),
                      ),
                      SimpleTextField(
                        hintText: "Locality (In memory)",
                        controller: locality,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apartment, suite or notes',
                        style: AppTheme().stylish1(
                          15,
                          AppTheme.black,
                          // isBold: true,
                        ),
                      ),
                      SimpleTextField(
                        hintText: "Apartment, suite or notes",
                        controller: appart,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Add a Google address",
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
                              'Google address',
                              style: AppTheme().stylish1(
                                15,
                                AppTheme.black,
                                // isBold: true,
                              ),
                            ),
                            SimpleTextField(
                              hintText: "Google address",
                              controller: googleAdress,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: isKeyboardVisible
          ? const SizedBox()
          : EditAdresseSheet(
              button: isLoading
                  ? const LoadingCircle()
                  : SubmitButton(
                      text: "Enregistrer la modification",
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        context
                            .read<EditBookCubit>()
                            .editBook(
                              AdresseBookDTO(
                                personName: fullName.text.trim(),
                                addressLabel: locality.text.trim(),
                                apartmentSuiteNote: appart.text.trim(),
                                hasGoogleAddress: hasGoogleAddress,
                                googleAddress: googleAdress.text.trim(),
                                user_id: widget.book.user!.id!,
                              ),
                            )
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                    ),
            ),
    );
  }
}
