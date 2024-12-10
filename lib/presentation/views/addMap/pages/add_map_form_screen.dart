import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/Image_form.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/first_form.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/third_form.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AddMapFormScreen extends StatefulWidget {
  const AddMapFormScreen({super.key});

  @override
  State<AddMapFormScreen> createState() => _AddMapFormScreenState();
}

class _AddMapFormScreenState extends State<AddMapFormScreen> {
  int current = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(),
        title: Text(
          "Ajouter une adresse",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: Container(
        width: context.width,
        height: context.height,
        color: AppTheme.lightGray,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StepItem(
                    icon: Icons.arrow_back_ios_new,
                    iColor: current == 1 ? mblack : mwhite,
                    cColor: current == 1
                        ? AppTheme.lightPrimary
                        : AppTheme.primaryColor,
                    onTap: () {
                      if (current == 3) {
                        setState(() {
                          current = 2;
                        });
                      } else if (current == 2) {
                        setState(() {
                          current = 1;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  StepItem(
                    icon: Icons.arrow_forward_ios,
                    iColor: current == 3 ? mblack : mwhite,
                    cColor: current == 3
                        ? AppTheme.lightPrimary
                        : AppTheme.primaryColor,
                    onTap: () {
                      if (current == 1) {
                        setState(() {
                          current = 2;
                        });
                      } else if (current == 2) {
                        setState(() {
                          current = 3;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: current == 1
                    ? const FirstForm()
                    : current == 2
                        ? ImageForm(
                          onContinue: () {
                            setState(() {
                              current = 3;
                            });
                          },
                        )
                        : const ThirdForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.icon,
    required this.iColor,
    required this.cColor,
    this.onTap,
  });
  final IconData icon;
  final Color iColor, cColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: cColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Icon(
            icon,
            color: iColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}
