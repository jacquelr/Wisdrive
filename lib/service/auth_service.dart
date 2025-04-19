import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';
import 'package:get/get.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //Sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //Sign up with email and password
  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {
      await createUserProfile();
    }
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

  //Delete account
  Future<void> deleteUserDataAndSignOut() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;
    await _supabase.from('users').delete().eq('id', user.id);
    await _supabase.auth.signOut();
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

  //Get current user
  User? get currentUsser => _supabase.auth.currentUser;

  Future<bool> checkIfProfileIsCompleted() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return false;

    final response = await Supabase.instance.client
        .from('users')
        .select('username')
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return false;

    final username = response['username'];
    return username != null && username.toString().trim().isNotEmpty;
  }

  Future<void> createUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    await Supabase.instance.client.from('users').insert({
      'id': user.id,
      'email': user.email,
      'username': '',
      'url_path': '',
      'strike': 0,
      'gender': null,
      'total_points': 0,
    });
  }
}
