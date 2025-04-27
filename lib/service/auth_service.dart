import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/generated/l10n.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
import 'package:get/get.dart';

class AuthService {
  final _supabase = Supabase.instance.client;
  final box = GetStorage();

  bool isFirstTime() {
    return box.read("isFirstTime") ?? true; //Check if user is new;
  }

  bool isFirstTimeLogged() {
    return box.read("isFirstTimeLogged") ?? true; //Check user's first time logged
  }

  Future<bool> loadIsFirstTimeLogged() async {
    Future.delayed(const Duration(seconds: 3)); 
    return box.read("isFirstTimeLogged") ?? true;
  }

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  //Sign up with email and password
  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    return response;
  }

  //Google authentication
  Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.wisdrive://login-callback',
    );
  }

  //Facebook authentication
  Future<void> signInWithFacebook() async {
    await _supabase.auth.signInWithOAuth(OAuthProvider.facebook);
  }

  //Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  //Send reset password link
  Future<void> sendResetPassowrdLink(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  //Delete account
  Future<void> deleteUserDataAndSignOut(BuildContext context) async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      try {
        await _supabase.auth.admin
            .deleteUser(user.id); // Delete user from OAuth
        //await _supabase.from('users').delete().eq('id', user.id); // Delete user data from Supabase table users
        await _supabase.auth.signOut(); // Sign Out from account

        ResponseSnackbar.show(context, false, S.of(context).delete_account);
      } catch (e) {
        ResponseSnackbar.show(
            context, true, '${S.of(Get.context!).deleted_account_error}: $e');
        rethrow;
      }
    }
  }

  //Update user password
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception("No hay sesión activa.");
      }
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      ResponseSnackbar.show(Get.context!, true, e.toString());
    }
  }

  Future<bool> reauthenticate(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.session != null;
    } catch (_) {
      return false;
    }
  }

  //Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  //Reset password
  

  //Get current user
  User? get currentUsser => _supabase.auth.currentUser;

  // Get current user id
  String? get currentUserId => _supabase.auth.currentUser?.id;
}
