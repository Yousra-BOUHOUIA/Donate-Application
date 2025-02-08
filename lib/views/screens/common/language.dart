import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donate_application/bloc/language_cubit.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});
  static const String pageRoute = '/language';

  @override
  Widget build(BuildContext context) {
    var currentLocale = context.watch<LanguageCubit>().state.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Language"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLanguageTile(context, "English", "en", currentLocale == "en"),
          _buildLanguageTile(context, "French", "fr", currentLocale == "fr"),
          _buildLanguageTile(context, "Arabic", "ar", currentLocale == "ar"),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, String language, String code, bool isSelected) {
    return ListTile(
      title: Text(language, style: const TextStyle(fontSize: 16)),
      trailing: Radio(
        value: code,
        groupValue: context.watch<LanguageCubit>().state.locale.languageCode,
        onChanged: (value) {
          if (value != null) {
            context.read<LanguageCubit>().changeLanguage(value);
          }
        },
      ),
      onTap: () {
        context.read<LanguageCubit>().changeLanguage(code);
      },
    );
  }
}
