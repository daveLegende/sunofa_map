import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/viewsmodels/notes/notes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class DetailNoteScreen extends StatefulWidget {
  const DetailNoteScreen({
    super.key,
    this.note,
  });
  final NoteModel? note;

  @override
  State<DetailNoteScreen> createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final title = TextEditingController(text: widget.note!.title);
    final desc = TextEditingController(text: widget.note!.desc);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(),
        title: Text(
          "Note",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
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
