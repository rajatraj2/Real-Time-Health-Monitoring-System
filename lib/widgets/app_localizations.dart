import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'login': 'Login',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'login_button': 'Login Now',
      'signup_prompt': "Don't have an account? Sign Up",
      'enter_email': 'Please enter your email',
      'valid_email': 'Please enter a valid email address',
      'enter_password': 'Please enter your password',
      'password_length': 'Password must be at least 6 characters',
      'logging_in': 'Logging in',
      'welcome': 'Welcome to DIH',
    },
    'hi': {
      'login': 'लॉगिन',
      'email': 'ईमेल',
      'password': 'पासवर्ड',
      'forgot_password': 'पासवर्ड भूल गए?',
      'login_button': 'लॉगिन करें',
      'signup_prompt': 'खाता नहीं है? साइन-अप करें',
      'enter_email': 'कृपया अपना ईमेल दर्ज करें',
      'valid_email': 'कृपया एक वैध ईमेल पता दर्ज करें',
      'enter_password': 'कृपया अपना पासवर्ड दर्ज करें',
      'password_length': 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए',
      'logging_in': 'लॉगिन कर रहा है',
      'welcome': 'DIH में आपका स्वागत है',
    },
  };

  String translate(String key) {
    return _localizedStrings[locale.languageCode]?[key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
