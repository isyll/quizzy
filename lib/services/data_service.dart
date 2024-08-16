import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzy/models/quizz/question.dart';

import 'package:quizzy/models/quizz/quizz_theme.dart';

class DataService {
  final Locale locale;
  final QuizzTheme theme;

  final String _path;

  DataService({
    required this.locale,
    required this.theme,
  }) : _path = 'assets/quizz/${locale.countryCode}/${theme.name}.json';

  factory DataService.fromCurrentLocale(BuildContext context,
      {required QuizzTheme theme}) {
    final currentLocale = Localizations.localeOf(context);
    return DataService(locale: currentLocale, theme: theme);
  }

  Future<List<Question>> loadQuizz() async {
    final jsonString = await rootBundle.loadString(_path);
    final jsonData = json.decode(jsonString)['data'] as List<dynamic>;
    return jsonData.map((map) => Question.fromMap(map)).toList();
  }

  static Future<List<Question>> loadQuizzFromTheme(BuildContext context,
      {required QuizzTheme theme}) async {
    final instance = DataService.fromCurrentLocale(context, theme: theme);
    return await instance.loadQuizz();
  }
}
