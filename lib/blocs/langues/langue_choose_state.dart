part of 'langue_choose_bloc.dart';


class LangueChooseState extends Equatable {
  final Locale selectedLocale;

  const LangueChooseState({
    this.selectedLocale = const Locale('en'),
  });

  LangueChooseState copyWith({
    Locale? selectedLocale,
  }) {
    return LangueChooseState(
      selectedLocale: selectedLocale ?? this.selectedLocale,
    );
  }

  @override
  List<Object?> get props => [selectedLocale];
}
