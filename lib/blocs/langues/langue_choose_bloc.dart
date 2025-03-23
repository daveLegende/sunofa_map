import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'langue_choose_event.dart';
part 'langue_choose_state.dart';

class LangueChooseBloc extends Bloc<LangueChooseEvent, LangueChooseState> {
  LangueChooseBloc() : super(const LangueChooseState()) {
    on<ChangeLanguage>(_onLanguageChanged);
  }

  FutureOr<void> _onLanguageChanged(
      ChangeLanguage event, Emitter<LangueChooseState> emit) {
    emit(state.copyWith(selectedLocale: event.locale));
  }
}
