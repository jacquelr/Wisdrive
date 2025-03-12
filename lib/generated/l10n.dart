// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `SALTAR`
  String get SKIP {
    return Intl.message('SALTAR', name: 'SKIP', desc: '', args: []);
  }

  /// `¡Bienvenido a wisdrive! Aprende todo lo necesario sobre mecanica y el reglamento vial de Jalisco sin complicaciones.`
  String get onboarding_1 {
    return Intl.message(
      '¡Bienvenido a wisdrive! Aprende todo lo necesario sobre mecanica y el reglamento vial de Jalisco sin complicaciones.',
      name: 'onboarding_1',
      desc: '',
      args: [],
    );
  }

  /// `Mejora tu seguridad vial con lecciones de tráfico y mecánica para ser un conductor responsable.`
  String get onboarding_2 {
    return Intl.message(
      'Mejora tu seguridad vial con lecciones de tráfico y mecánica para ser un conductor responsable.',
      name: 'onboarding_2',
      desc: '',
      args: [],
    );
  }

  /// `Prueba tus conocimientoson con lecciones interactivas y prepárate para cualquier situación.`
  String get onboarding_3 {
    return Intl.message(
      'Prueba tus conocimientoson con lecciones interactivas y prepárate para cualquier situación.',
      name: 'onboarding_3',
      desc: '',
      args: [],
    );
  }

  /// `¡comencemos a aprender!`
  String get lets_start_learning {
    return Intl.message(
      '¡comencemos a aprender!',
      name: 'lets_start_learning',
      desc: '',
      args: [],
    );
  }

  /// `iniciar sesión`
  String get sign_in {
    return Intl.message('iniciar sesión', name: 'sign_in', desc: '', args: []);
  }

  /// `registrarse`
  String get sign_up {
    return Intl.message('registrarse', name: 'sign_up', desc: '', args: []);
  }

  /// `Iniciar Sesión`
  String get Sign_In {
    return Intl.message('Iniciar Sesión', name: 'Sign_In', desc: '', args: []);
  }

  /// `Registrarse`
  String get Sign_Up {
    return Intl.message('Registrarse', name: 'Sign_Up', desc: '', args: []);
  }

  /// `Correo electronico`
  String get email {
    return Intl.message(
      'Correo electronico',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get password {
    return Intl.message('Contraseña', name: 'password', desc: '', args: []);
  }

  /// `Confirmar contraseña`
  String get confirm_password {
    return Intl.message(
      'Confirmar contraseña',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `ó`
  String get or {
    return Intl.message('ó', name: 'or', desc: '', args: []);
  }

  /// `inicia sesión con`
  String get sign_in_with {
    return Intl.message(
      'inicia sesión con',
      name: 'sign_in_with',
      desc: '',
      args: [],
    );
  }

  /// `crea una cuenta con`
  String get create_account_with {
    return Intl.message(
      'crea una cuenta con',
      name: 'create_account_with',
      desc: '',
      args: [],
    );
  }

  /// `Error al iniciar sesión`
  String get signin_error {
    return Intl.message(
      'Error al iniciar sesión',
      name: 'signin_error',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar`
  String get close {
    return Intl.message('Cerrar', name: 'close', desc: '', args: []);
  }

  /// `Tema`
  String get theme {
    return Intl.message('Tema', name: 'theme', desc: '', args: []);
  }

  /// `Perfil de usuario`
  String get user_profile {
    return Intl.message(
      'Perfil de usuario',
      name: 'user_profile',
      desc: '',
      args: [],
    );
  }

  /// `Idioma`
  String get language {
    return Intl.message('Idioma', name: 'language', desc: '', args: []);
  }

  /// `Notificaciones`
  String get notifications {
    return Intl.message(
      'Notificaciones',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Recordatorios`
  String get reminders {
    return Intl.message('Recordatorios', name: 'reminders', desc: '', args: []);
  }

  /// `Accesibilidad`
  String get accesibility {
    return Intl.message(
      'Accesibilidad',
      name: 'accesibility',
      desc: '',
      args: [],
    );
  }

  /// `Centro de ayuda`
  String get help {
    return Intl.message('Centro de ayuda', name: 'help', desc: '', args: []);
  }

  /// `Politicas de privacidad`
  String get privacy_politics {
    return Intl.message(
      'Politicas de privacidad',
      name: 'privacy_politics',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar Sesión`
  String get logout {
    return Intl.message('Cerrar Sesión', name: 'logout', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
