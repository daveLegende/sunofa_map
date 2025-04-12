import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/common/widgets/text/notfound_text.dart';
// import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/entities/notes/notes.entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/delete/delete_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/note_state.dart';
import 'package:sunofa_map/presentation/views/notes/pages/detail_note.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import 'add_notes.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    super.key,
    this.user,
  });
  final UserEntity? user;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<NoteEntity> notes = [];
  bool isSelectionMode = false;
  Set<int> selectedIndexes = {};
  void _addNote(NoteEntity note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
        listener: (context, state) {
      // print("Langue choisie: ${state.selectedLocale.languageCode}");
      // setState(() {});
    }, builder: (context, state) {
      return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: mwhite,
            appBar: AppBar(
              backgroundColor: AppTheme.primaryColor,
              automaticallyImplyLeading: false,
              title: Text(
                "note.appbar".tr(),
                style: AppTheme().stylish1(20, mwhite, isBold: true),
              ),
              actions: isSelectionMode
                  ? [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            selectedIndexes.toList().reversed.forEach((index) {
                              context.read<DeleteNoteCubit>().deleteNote(
                                    IdParms(
                                      id: notes[index].id!,
                                    ),
                                  );
                              notes.removeAt(index);
                            });
                            selectedIndexes.clear();
                            isSelectionMode = false;
                            context
                                .read<NoteCubit>()
                                .getNotes()
                                .then((value) => setState(() {}));
                          });
                        },
                      ),
                    ]
                  : [],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: state is UserSuccessState
                ? Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: FloatingActionButton(
                    clipBehavior: Clip.hardEdge,
                    backgroundColor: AppTheme.primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNoteScreen(
                            onAddNote: _addNote,
                            user: state.user,
                          ),
                        ),
                      );
                    },
                    child: const HeroIcon(
                      HeroIcons.plus,
                      color: mwhite,
                      size: 30,
                      style: HeroIconStyle.micro,
                    ),
                  ),
                )
                : const Center(),
            body: Container(
              height: context.height,
              color: mwhite,
              child:
                  BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
                if (state is NoteSuccessState) {
                  notes = state.notes;

                  if (state.notes.isEmpty) {
                    return NotFoundText(
                      text: "note.note_empty".tr(),
                    );
                  }
                  return GridView.builder(
                    itemCount: state.notes.length,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, i) {
                      final note = state.notes[i];
                      final isSelected = selectedIndexes.contains(i);
                      return GestureDetector(
                        onTap: isSelectionMode
                            ? () {
                                setState(() {
                                  if (isSelected) {
                                    selectedIndexes.remove(i);
                                  } else {
                                    selectedIndexes.add(i);
                                  }
                                  // Sortir du mode sélection si aucune note n'est sélectionnée
                                  if (selectedIndexes.isEmpty) {
                                    isSelectionMode = false;
                                  }
                                });
                              }
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) {
                                    return DetailNoteScreen(
                                      note: note,
                                    );
                                  }),
                                );
                              },
                        onLongPress: () {
                          // Activer le mode sélection
                          setState(() {
                            isSelectionMode = true;
                            selectedIndexes.add(i);
                          });
                        },
                        child: Container(
                          width: context.width / 2,
                          height: context.width / 2,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected
                                ? AppTheme.primaryColor.withOpacity(0.2)
                                : AppTheme.lightGray,
                            border: isSelected
                                ? Border.all(
                                    color: AppTheme.primaryColor, width: 2)
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  note.title,
                                  style: AppTheme().stylish1(
                                    15,
                                    mblack,
                                    isBold: true,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                note.contenu,
                                textAlign: TextAlign.start,
                                style: AppTheme().stylish1(
                                  14,
                                  mgrey,
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const LoadingCircle();
                }
              }),
            ),
          );
        },
      );
    });
  }
}
