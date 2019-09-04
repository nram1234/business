import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Applocalizations {
  final Locale locale;

  Applocalizations(this.locale);

  static Applocalizations of(BuildContext context) {

    return Localizations.of<Applocalizations>(context, Applocalizations);
  }
static const LocalizationsDelegate<Applocalizations>delegate=_AppLocalizationDelegate();


  Map<String, String> _localizedString;

  Future <bool>load() async {
    String josnString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> josnMap = json.decode(josnString);
    _localizedString = josnMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return _localizedString[key];
  }
}
class _AppLocalizationDelegate
extends LocalizationsDelegate<Applocalizations>{

const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<Applocalizations> load(Locale locale)async {
    Applocalizations  localizations=new Applocalizations(locale);
    await localizations.load();
    return localizations;

  }

  @override
  bool shouldReload(LocalizationsDelegate<Applocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

}

















