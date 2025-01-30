import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/delete/delete_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/login_cubit.dart';
import 'package:sunofa_map/presentation/views/auth/bloc/register/register_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/create/create_cubit.dart';
import 'package:sunofa_map/presentation/views/editAdresse/bloc/edit_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/create/create_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/delete/delete_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/edit/edit_note_cubit.dart';
import 'package:sunofa_map/presentation/views/notes/bloc/note_cubit.dart';
import 'package:sunofa_map/presentation/views/profil/bloc/update_user_cubit.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:get/get.dart';

// 

import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

// import 'chargement.dart';

void main() async {
  await initializeDateFormatting('fr_FR', null);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDependencies();
  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit()..getCurrentUser(),
        ),
        BlocProvider<UpdateUserCubit>(
          create: (context) => UpdateUserCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<AdresseCubit>(
          create: (context) => AdresseCubit()..getAdresses(),
        ),
        BlocProvider<CreateAdresseCubit>(
          create: (context) => CreateAdresseCubit(),
        ),
        BlocProvider<EditAdresseCubit>(
          create: (context) => EditAdresseCubit(),
        ),
        BlocProvider<DeleteAdresseCubit>(
          create: (context) => DeleteAdresseCubit(),
        ),
        BlocProvider<BookCubit>(
          create: (context) => BookCubit()..getBooks(),
        ),
        BlocProvider<CreateBookCubit>(
          create: (context) => CreateBookCubit(),
        ),
        BlocProvider<NoteCubit>(
          create: (context) => NoteCubit()..getNotes(),
        ),
        BlocProvider<CreateNoteCubit>(
          create: (context) => CreateNoteCubit(),
        ),
        BlocProvider<EditNoteCubit>(
          create: (context) => EditNoteCubit(),
        ),
        BlocProvider<DeleteNoteCubit>(
          create: (context) => DeleteNoteCubit(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Sunofa Map',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.chargement,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        // home: AudioRecorderScreen(),
      ),
    );
  }
}



class AudioRecorderScreen extends StatefulWidget {
  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String _recordedFilePath = '';
  Duration _recordedDuration = Duration.zero;
  Timer? _recordingTimer;
  DateTime? _recordingStartTime;

  @override
  void initState() {
    super.initState();
    requestMicrophonePermission();
  }

  Future<void> requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      print('Microphone permission denied');
    }
  }

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/recording.m4a';
  }

  Future<void> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        String path = await _getFilePath();
        await _audioRecorder.start(
          const RecordConfig(),
          path: path,
        );
        setState(() {
          _isRecording = true;
          _recordedFilePath = path;
          _recordingStartTime = DateTime.now();
          _recordedDuration = Duration.zero;
        });

        // Démarrer un timer pour mettre à jour la durée
        _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (_recordingStartTime != null) {
            setState(() {
              _recordedDuration = DateTime.now().difference(_recordingStartTime!);
            });
          }
        });
      } else {
        print("Permission refusée");
      }
    } catch (e) {
      print('Erreur lors du démarrage de l\'enregistrement : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _recordedFilePath = path ?? _recordedFilePath;
        _recordingTimer?.cancel();
      });
    } catch (e) {
      print('Erreur lors de l\'arrêt de l\'enregistrement : $e');
    }
  }

  Future<void> playRecording() async {
    if (_recordedFilePath.isNotEmpty && File(_recordedFilePath).existsSync()) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath));
    } else {
      print("Fichier audio introuvable.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isRecording ? 'Recording...' : 'Press to Record',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Duration: ${_recordedDuration.inSeconds} seconds',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              onPressed: _isRecording ? stopRecording : startRecording,
              iconSize: 50,
            ),
            SizedBox(height: 20),
            if (_recordedFilePath.isNotEmpty)
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: playRecording,
                iconSize: 50,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }
}