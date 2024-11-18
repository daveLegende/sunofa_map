import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/viewsmodels/notes/notes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
    this.onAddNote,
  });
  // final List<NoteModel> notes;
  final Function(NoteModel)? onAddNote;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(),
        title: Text(
          "Ajout de note",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
        actions: [
          IconButton(
            color: AppTheme.primaryColor,
            onPressed: () {
              if (desc.text.trim().isEmpty) {
                Navigator.pop(context);
              } else {
                widget.onAddNote!(
                  NoteModel(
                    title: title.text.trim(),
                    desc: desc.text.trim(),
                  ),
                );
                Navigator.pop(context);
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
                    hintText: "Titre",
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
                    hintText: "Note...",
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
    );
  }
}
