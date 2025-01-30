import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ImportOrDoingWidget extends StatelessWidget {
  const ImportOrDoingWidget({
    super.key,
    this.onRecord,
    this.onImport,
    required this.isRecording,
    required this.duration,
  });
  final bool isRecording;
  final Duration duration;
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
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints.expand(
                                    height: size.width / 2,
                                  ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Commencez Enrégistrement d'audio",
                                            style: AppTheme().stylish1(
                                              16,
                                              mblack,
                                              isBold: true,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  onRecord!.call();
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: mred,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      30,
                                                    ),
                                                  ),
                                                  child: const HeroIcon(
                                                    HeroIcons.microphone,
                                                    color: mwhite,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  HeroIcon(
                                                    HeroIcons.play,
                                                    color: mgrey[200],
                                                  ),
                                                  Container(
                                                    width: size.width * .35,
                                                    height: 2,
                                                    decoration: BoxDecoration(
                                                      color: mgrey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        30,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${duration.inSeconds}",
                                                    style: TextStyle(
                                                      color: mgrey[200],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              HeroIcon(
                                                HeroIcons.trash,
                                                color: mgrey[200],
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 50,
                                              width: size.width * .35,
                                              decoration: BoxDecoration(
                                                color: mred,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Enrégistrer",
                                                  style: AppTheme().stylish1(
                                                    16,
                                                    mwhite,
                                                    isBold: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      title: Text(
                        "Enrégistrer un audio",
                        style: AppTheme().stylish1(16, mblack, isBold: true),
                      ),
                    ),
                    const CustomDivider(),
                    ListTile(
                      onTap: onImport,
                      title: Text(
                        "importer un fichier audio",
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
