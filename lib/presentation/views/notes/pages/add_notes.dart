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
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/create/create_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/create/create_note_state.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/note_cubit.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
    this.onAddNote,
    this.user,
  });
  final UserEntity? user;
  final Function(NoteEntity)? onAddNote;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = widget.user!;
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocListener<CreateNoteCubit, CreateNoteState>(
          listener: (context, state) {
            if (state is CreateNoteSuccessState) {
              Helpers().mySnackbar(
                context: context,
                message: state.message,
              );
              Navigator.pop(context);
              context.read<NoteCubit>().getNotes();
            } else if (state is CreateNoteFailedState) {
              Helpers().mySnackbar(
                context: context,
                color: mred,
                message: state.message,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: mwhite,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: const BackArrow(),
              title: Text(
                "add_note.appbar".tr(),
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              actions: [
                IconButton(
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
                        context.read<CreateNoteCubit>().createNote(
                              NoteDTO(
                                title: title.text.trim(),
                                contenu: desc.text.trim(),
                                user_id: user.id!.toString(),
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
                ),
              ],
            ),
            body: Container(
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
                          hintText: "add_note.title".tr(),
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
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: desc,
                        cursorColor: mblack,
                        maxLines: 50000,
                        minLines: 1,
                        style: AppTheme().stylish1(16, mblack),
                        decoration: InputDecoration(
                          hintText: "add_note.desc".tr(),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
