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

  /// `Olvidaste tu contraseña`
  String get forgot_password {
    return Intl.message(
      'Olvidaste tu contraseña',
      name: 'forgot_password',
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

  /// `Inicio de sesion exitoso`
  String get signin_success {
    return Intl.message(
      'Inicio de sesion exitoso',
      name: 'signin_success',
      desc: '',
      args: [],
    );
  }

  /// `Error al registrarse`
  String get signup_error {
    return Intl.message(
      'Error al registrarse',
      name: 'signup_error',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden`
  String get unmatch_password {
    return Intl.message(
      'Las contraseñas no coinciden',
      name: 'unmatch_password',
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

  /// `Inicio`
  String get home {
    return Intl.message('Inicio', name: 'home', desc: '', args: []);
  }

  /// `Mecánica básica`
  String get basic_mechanics {
    return Intl.message(
      'Mecánica básica',
      name: 'basic_mechanics',
      desc: '',
      args: [],
    );
  }

  /// `Mecanica`
  String get mechanics {
    return Intl.message('Mecanica', name: 'mechanics', desc: '', args: []);
  }

  /// `Reglamento de transito`
  String get traffic_regulations {
    return Intl.message(
      'Reglamento de transito',
      name: 'traffic_regulations',
      desc: '',
      args: [],
    );
  }

  /// `Reglamento`
  String get regulations {
    return Intl.message('Reglamento', name: 'regulations', desc: '', args: []);
  }

  /// `Cultura vial`
  String get road_culture {
    return Intl.message(
      'Cultura vial',
      name: 'road_culture',
      desc: '',
      args: [],
    );
  }

  /// `No hay categorias disponibles`
  String get no_categories_available {
    return Intl.message(
      'No hay categorias disponibles',
      name: 'no_categories_available',
      desc: '',
      args: [],
    );
  }

  /// `No hay módulos disponibles`
  String get no_modules_available {
    return Intl.message(
      'No hay módulos disponibles',
      name: 'no_modules_available',
      desc: '',
      args: [],
    );
  }

  /// `No hay quizes disponibles`
  String get no_quizes_available {
    return Intl.message(
      'No hay quizes disponibles',
      name: 'no_quizes_available',
      desc: '',
      args: [],
    );
  }

  /// `Sin nombre`
  String get unnamed {
    return Intl.message('Sin nombre', name: 'unnamed', desc: '', args: []);
  }

  /// `Bienvenido a Wisdrive`
  String get welcome {
    return Intl.message(
      'Bienvenido a Wisdrive',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Preparate para ser más sabio con wisdrive`
  String get get_ready {
    return Intl.message(
      'Preparate para ser más sabio con wisdrive',
      name: 'get_ready',
      desc: '',
      args: [],
    );
  }

  /// `Dale un vistazo al reglamento de transito de Jalisco`
  String get take_a_look {
    return Intl.message(
      'Dale un vistazo al reglamento de transito de Jalisco',
      name: 'take_a_look',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get profile {
    return Intl.message('Perfil', name: 'profile', desc: '', args: []);
  }

  /// `Editar perfil`
  String get edit_profile {
    return Intl.message(
      'Editar perfil',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Perfil actualizado correctamente`
  String get edit_profile_success {
    return Intl.message(
      'Perfil actualizado correctamente',
      name: 'edit_profile_success',
      desc: '',
      args: [],
    );
  }

  /// `Selecciona un avatar`
  String get pick_avatar {
    return Intl.message(
      'Selecciona un avatar',
      name: 'pick_avatar',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar contraseña`
  String get change_password {
    return Intl.message(
      'Cambiar contraseña',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar cuenta`
  String get delete_account {
    return Intl.message(
      'Eliminar cuenta',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar foto`
  String get change_picture {
    return Intl.message(
      'Cambiar foto',
      name: 'change_picture',
      desc: '',
      args: [],
    );
  }

  /// `Estás seguro`
  String get are_you_sure {
    return Intl.message(
      'Estás seguro',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de usuario`
  String get edit_username {
    return Intl.message(
      'Nombre de usuario',
      name: 'edit_username',
      desc: '',
      args: [],
    );
  }

  /// `Genero`
  String get edit_gender {
    return Intl.message('Genero', name: 'edit_gender', desc: '', args: []);
  }

  /// `Contraseña actual`
  String get current_password {
    return Intl.message(
      'Contraseña actual',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Nueva contraseña`
  String get new_password {
    return Intl.message(
      'Nueva contraseña',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar nueva contraseña`
  String get confirm_new_password {
    return Intl.message(
      'Confirmar nueva contraseña',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message('Cancelar', name: 'cancel', desc: '', args: []);
  }

  /// `Aplicar`
  String get apply {
    return Intl.message('Aplicar', name: 'apply', desc: '', args: []);
  }

  /// `Hombre`
  String get male {
    return Intl.message('Hombre', name: 'male', desc: '', args: []);
  }

  /// `Mujer`
  String get female {
    return Intl.message('Mujer', name: 'female', desc: '', args: []);
  }

  /// `Otro`
  String get other {
    return Intl.message('Otro', name: 'other', desc: '', args: []);
  }

  /// `Lección`
  String get lesson {
    return Intl.message('Lección', name: 'lesson', desc: '', args: []);
  }

  /// `Nivel`
  String get level {
    return Intl.message('Nivel', name: 'level', desc: '', args: []);
  }

  /// `Pregunta`
  String get question_ {
    return Intl.message('Pregunta', name: 'question_', desc: '', args: []);
  }

  /// `de`
  String get of_ {
    return Intl.message('de', name: 'of_', desc: '', args: []);
  }

  /// `Correcto`
  String get correct {
    return Intl.message('Correcto', name: 'correct', desc: '', args: []);
  }

  /// `Incorrecto, intenta de nuevo`
  String get incorrect {
    return Intl.message(
      'Incorrecto, intenta de nuevo',
      name: 'incorrect',
      desc: '',
      args: [],
    );
  }

  /// `CONTESTAR`
  String get answer {
    return Intl.message('CONTESTAR', name: 'answer', desc: '', args: []);
  }

  /// `Felicidades`
  String get congratulations {
    return Intl.message(
      'Felicidades',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Has completado el quiz correctamente`
  String get finished_quiz {
    return Intl.message(
      'Has completado el quiz correctamente',
      name: 'finished_quiz',
      desc: '',
      args: [],
    );
  }

  /// `Continuar`
  String get continue_learning {
    return Intl.message(
      'Continuar',
      name: 'continue_learning',
      desc: '',
      args: [],
    );
  }

  /// `Cuenta eliminada exitosamente`
  String get deleteted_account {
    return Intl.message(
      'Cuenta eliminada exitosamente',
      name: 'deleteted_account',
      desc: '',
      args: [],
    );
  }

  /// `Error al eliminar la cuenta`
  String get deleted_account_error {
    return Intl.message(
      'Error al eliminar la cuenta',
      name: 'deleted_account_error',
      desc: '',
      args: [],
    );
  }

  /// `Completa todos los campos`
  String get fill_all_fields {
    return Intl.message(
      'Completa todos los campos',
      name: 'fill_all_fields',
      desc: '',
      args: [],
    );
  }

  /// `La nueva contraseña no puede ser igual a la acutal`
  String get same_password {
    return Intl.message(
      'La nueva contraseña no puede ser igual a la acutal',
      name: 'same_password',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña actual es incorrecta`
  String get incorrect_current_password {
    return Intl.message(
      'La contraseña actual es incorrecta',
      name: 'incorrect_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña actualizada con exito`
  String get updated_password {
    return Intl.message(
      'Contraseña actualizada con exito',
      name: 'updated_password',
      desc: '',
      args: [],
    );
  }

  /// `Error al actualizar la contraseña`
  String get updated_password_error {
    return Intl.message(
      'Error al actualizar la contraseña',
      name: 'updated_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Cuenta creada con exito`
  String get created_account {
    return Intl.message(
      'Cuenta creada con exito',
      name: 'created_account',
      desc: '',
      args: [],
    );
  }

  /// `Revisa tu correo para activar tu cuenta`
  String get check_email_to_activate_account {
    return Intl.message(
      'Revisa tu correo para activar tu cuenta',
      name: 'check_email_to_activate_account',
      desc: '',
      args: [],
    );
  }

  /// `Ingresa tu correo`
  String get enter_your_email {
    return Intl.message(
      'Ingresa tu correo',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enlace de reestablecimiento enviado`
  String get reset_link_sent {
    return Intl.message(
      'Enlace de reestablecimiento enviado',
      name: 'reset_link_sent',
      desc: '',
      args: [],
    );
  }

  /// `Error al enviar enlace de reestablecimiento`
  String get reset_link_sent_error {
    return Intl.message(
      'Error al enviar enlace de reestablecimiento',
      name: 'reset_link_sent_error',
      desc: '',
      args: [],
    );
  }

  /// `Enviar`
  String get send {
    return Intl.message('Enviar', name: 'send', desc: '', args: []);
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
