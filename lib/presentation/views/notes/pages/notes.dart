import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
// import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/viewsmodels/notes/notes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import 'add_notes.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<NoteModel> notes = noteList;

  void _addNote(NoteModel note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Mes Notes",
          style: AppTheme().stylish1(20, mwhite, isBold: true),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
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
      ),
      body: Container(
        height: context.height,
        color: AppTheme.lightGray,
        child: GridView.builder(
          itemCount: notes.length,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, i) {
            final note = notes[i];
            return Container(
              width: context.width / 2,
              height: context.width / 2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: mwhite,
              ),
              child: Column(
                children: [
                  Text(
                    note.title,
                    style: AppTheme().stylish1(
                      15,
                      mblack,
                      isBold: true,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    note.desc,
                    style: AppTheme().stylish1(
                      14,
                      mgrey,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
