import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LanguageState {
  final Locale locale;
  LanguageState(this.locale);
}

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(const Locale('en'))); 

  void changeLanguage(String languageCode) {
    emit(LanguageState(Locale(languageCode)));
  }
}
