import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ImportOrDoingWidget extends StatelessWidget {
  const ImportOrDoingWidget({
    super.key,
    this.onRecord,
    this.onImport,
    required this.importText,
    required this.doingText,
  });
  final String importText, doingText;
  final VoidCallback? onRecord, onImport;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StatefulBuilder(builder: (context, setState) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints.expand(height: size.width / 2),
            child: Container(
              decoration: const BoxDecoration(
                color: mwhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        onRecord!();
                      },
                      title: Text(
                        doingText,
                        style: AppTheme().stylish1(16, mblack, isBold: true),
                      ),
                    ),
                    const CustomDivider(),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        onImport!();
                      },
                      title: Text(
                        importText,
                        style: AppTheme().stylish1(16, mblack, isBold: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
