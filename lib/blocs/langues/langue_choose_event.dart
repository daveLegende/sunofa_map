part of 'langue_choose_bloc.dart';

sealed class LangueChooseEvent extends Equatable {
  const LangueChooseEvent();
}

final class ChangeLanguage extends LangueChooseEvent {
  final Locale locale;

  const ChangeLanguage(this.locale);

  @override
  List<Object?> get props => [locale];
}
