import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/app_helpers.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/presentation/views/dashboard/widgets/audio_player_widget.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:file_picker/file_picker.dart';

class AddMapFormScreen extends StatefulWidget {
  const AddMapFormScreen({super.key});

  @override
  State<AddMapFormScreen> createState() => _AddMapFormScreenState();
}

class _AddMapFormScreenState extends State<AddMapFormScreen> {
  int? _selectedLocationOption;
  int? _selectedPrivacyOption;

  Future<void> selectFile(String type) async {
    FileType fileType;
    switch (type) {
      case 'image':
        fileType = FileType.image;
        break;
      case 'audio':
        fileType = FileType.audio;
        break;
      case 'video':
        fileType = FileType.video;
        break;
      default:
        fileType = FileType.any;
    }

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      // Gérer le fichier sélectionné
      print('Fichier sélectionné : ${result.files.single.name}');
    } else {
      // L'utilisateur a annulé la sélection
      print('Aucun fichier sélectionné.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const HeroIcon(
            HeroIcons.arrowLeftCircle,
            color: AppTheme.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Map',
          style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabelWithAsterisk('Create an identifier'),
              const SizedBox(height: 8),
              AppHelpers.buildTextFormField(
                hint: 'ex: KGB2',
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              buildLabelWithAsterisk('Address name / APT/suit'),
              const SizedBox(height: 8),
              AppHelpers.buildTextFormField(
                hint: 'Maison IDAH',
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              buildLabelWithAsterisk('Country, city, district or street'),
              const SizedBox(height: 8),
              AppHelpers.buildTextFormField(
                hint: 'Country, Town, City',
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Use my current location/Your Google address',
                style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  RadioListTile<int>(
                    value: 1,
                    groupValue: _selectedLocationOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedLocationOption = value;
                      });
                    },
                    title: Text(
                      'Your Google address',
                      style: AppTheme().stylish1(15, AppTheme.black),
                    ),
                  ),
                  RadioListTile<int>(
                    value: 2,
                    groupValue: _selectedLocationOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedLocationOption = value;
                      });
                    },
                    title: Text(
                      'Use my current location',
                      style: AppTheme().stylish1(15, AppTheme.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Make your address private by using a Pin',
                style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
              ),
              RadioListTile<int>(
                value: 1,
                groupValue: _selectedPrivacyOption,
                onChanged: (value) {
                  setState(() {
                    _selectedPrivacyOption = value;
                  });
                },
                title: Text(
                  'I want to protect my address',
                  style: AppTheme().stylish1(15, AppTheme.black),
                ),
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              buildLabelWithAsterisk('Address info'),
              const SizedBox(height: 8),
              AppHelpers.buildTextFormField(
                hint: 'Longez tout droit vers ...',
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Add images of the locality',
                style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, left: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: context.widthPercent(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppTheme.primaryColor,
                        ),
                        child: InkWell(
                          onTap: () => selectFile('image'),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Select an image',
                                  style: AppTheme().stylish1(15, AppTheme.white,
                                      isBold: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.widthPercent(5),
                    ),
                    Expanded(
                      child: Container(
                        width: context.widthPercent(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppTheme.primaryColor,
                        ),
                        child: InkWell(
                          onTap: () => selectFile('image'),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Select an image',
                                  style: AppTheme().stylish1(15, AppTheme.white,
                                      isBold: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Reference audio',
                style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppTheme.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const AudioPlayerWidget(
                        label: 'official language',
                      ),
                      SizedBox(
                        height: context.heightPercent(2),
                      ),
                      const AudioPlayerWidget(
                        label: 'standard language',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Reference video',
                style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2, left: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => selectFile('video'),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.red.withOpacity(0.3),
                                child: Text(
                                  'Rec •',
                                  style: AppTheme()
                                      .stylish1(15, Colors.red, isBold: true),
                                ),
                              ),
                              SizedBox(
                                height: context.heightPercent(1),
                              ),
                              Text(
                                'Select a video',
                                style: AppTheme()
                                    .stylish1(15, AppTheme.black, isBold: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.widthPercent(5),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => selectFile('video'),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.red.withOpacity(0.3),
                                child: Text(
                                  'Rec •',
                                  style: AppTheme()
                                      .stylish1(15, Colors.red, isBold: true),
                                ),
                              ),
                              SizedBox(
                                height: context.heightPercent(1),
                              ),
                              Text(
                                'Select a video',
                                style: AppTheme()
                                    .stylish1(15, AppTheme.black, isBold: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: false,
                    onChanged: (value) {},
                  ),
                  Text(
                    'I accept',
                    style:
                        AppTheme().stylish1(15, AppTheme.black),
                  ),
                ],
              ),
                RichText(
              text: TextSpan(
                 style: AppTheme().stylish1(15, AppTheme.black),
                children: [
                   TextSpan(text: 'By clicking "I accept", you agree to the ', style:   AppTheme().stylish1(15, AppTheme.black),),
                  TextSpan(
                    text: 'Privacy Policies',
                   style:   AppTheme().stylish1(15, AppTheme.primaryColor),
                  ),
                   TextSpan(text: ' and the ', style:   AppTheme().stylish1(15, AppTheme.black),),
                  TextSpan(
                    text: 'Terms of Use',
                    style:   AppTheme().stylish1(15, AppTheme.primaryColor),
                  ),
                  const TextSpan(text: ' de SunofaMap.'),
                ],
              ),
            ),
            SizedBox(
                height: context.heightPercent(5),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                            width: context.widthPercent(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cancel',
                                    style: AppTheme().stylish1(15, AppTheme.white,
                                        isBold: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(width: context.widthPercent(3),),
                   Expanded(
                     child: InkWell(
                      onTap: () {},
                      child: Container(
                            width: context.widthPercent(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppTheme.primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Submit',
                                    style: AppTheme().stylish1(15, AppTheme.white,
                                        isBold: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                                       ),
                   ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabelWithAsterisk(String label) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
          ),
          const TextSpan(
            text: '*',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
