import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/notes/notes.dto.dart';
import 'package:sunofa_map/domain/entities/notes/notes.entity.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/edit/edit_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/edit/edit_note_state.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/note_cubit.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class DetailNoteScreen extends StatefulWidget {
  const DetailNoteScreen({
    super.key,
    this.note,
  });
  final NoteEntity? note;

  @override
  State<DetailNoteScreen> createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;
  bool showSubmitButton = false;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.note!.title);
    desc = TextEditingController(text: widget.note!.contenu);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mwhite,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: const BackArrow(),
              title: Text(
                "details_note.appbar".tr(),
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              actions: [
                showSubmitButton
                    ? IconButton(
                        color: AppTheme.primaryColor,
                        onPressed: () async {
                          if (desc.text.trim().isEmpty) {
                            Navigator.pop(context);
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const LoadingCircle(),
                            );

                            try {
                              context.read<EditNoteCubit>().editNote(
                                    NoteDTO(
                                      id: widget.note!.id,
                                      title: title.text.trim(),
                                      contenu: desc.text.trim(),
                                      user_id:
                                          widget.note!.user!.id!.toString(),
                                    ),
                                  );
                            } finally {
                              Navigator.pop(context);
                            }
                          }
                        },
                        icon: const HeroIcon(
                          HeroIcons.check,
                          size: 30,
                          color: AppTheme.primaryColor,
                          style: HeroIconStyle.micro,
                        ),
                      )
                    : const Center(),
              ],
            ),
            body: BlocListener<EditNoteCubit, EditNoteState>(
              listener: (context, state) {
                if (state is EditNoteSuccessState) {
                  Helpers().mySnackbar(
                    context: context,
                    message: state.message,
                  );
                  context.read<NoteCubit>().getNotes();
                  Navigator.pop(context);
                } else if (state is EditNoteFailedState) {
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
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: title,
                          cursorColor: mblack,
                          maxLines: 3,
                          minLines: 1,
                          style: AppTheme().stylish1(18, mblack, isBold: true),
                          decoration: InputDecoration(
                            // hintText: "Titre",
                            hintStyle: AppTheme().stylish1(18, mgrey),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              showSubmitButton = isValidName(value) &&
                                  value != widget.note!.title;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: desc,
                          cursorColor: mblack,
                          maxLines: 50000,
                          minLines: 1,
                          style: AppTheme().stylish1(16, mblack),
                          decoration: InputDecoration(
                            hintText: "details_note.note_hint".tr(),
                            hintStyle: AppTheme().stylish1(16, mgrey),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              showSubmitButton = isValidName(value) &&
                                  value != widget.note!.contenu;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  // Fonction de validation du nom
  bool isValidName(String name) {
    return name.isNotEmpty && name.length > 2;
  }
}
