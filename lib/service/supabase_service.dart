import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/service/auth_service.dart';

class SupabaseService {
  final authService = AuthService();
  final supabase = Supabase.instance.client;
  final box = GetStorage();

  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('uuid', user.id)
          .maybeSingle();
      return response;
    } catch (e) {
      throw Exception("Error al obtener usuario: $e");
    }
  }

  Future<Map<String, dynamic>> getUserProfileOrThrow() async {
    final user = await getUserProfile();
    if (user == null) {
      throw Exception("No se encontró el perfil del usuario.");
    }
    return user;
  }

  // supabase -> INSERT INTO users (<user properties>)
  Future<void> createUserProfile(
      String username, int? avatar, String? gender) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final existing = await Supabase.instance.client
        .from('users')
        .select('id')
        .eq('uuid', user.id)
        .maybeSingle();

    try {
      if (existing == null) {
        await Supabase.instance.client.from('users').insert({
          'username': username,
          'email': user.email,
          'strike': 0,
          'gender': gender,
          'total_points': 0,
          'deleted_at': null,
          'avatar': avatar,
          'uuid': user.id
        });
      }
      box.write("isFirstTimeLogged", false);
    } catch (e) {
      throw Exception("error al crear usuario en la bd: $e");
    }
  }

  Future<void> updateUserProfile(
      {String? username, int? avatar, String? gender}) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception("Usuario no autenticado.");

    final updates = <String, dynamic>{};

    if (username != null && username.isNotEmpty) {
      updates['username'] = username;
    }

    if (avatar != null) {
      updates['avatar'] = avatar;
    }

    if (gender != null && gender.isNotEmpty) {
      updates['gender'] = gender;
    }

    if (updates.isEmpty) return; // Nada que actualizar

    try {
      await supabase
          .from('users')
          .update(updates)
          .eq('uuid', userId)
          .select()
          .maybeSingle();
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> deleteUserProfile(String uuid) async {
    try {
      await supabase
          .from('users')
          .delete()
          .eq('uuid', uuid)
          .maybeSingle();
          print("usuario eliminado en la tabla users");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setUserAvatar(int avatarKey) async {
    await Supabase.instance.client // Save avatar in supabase
        .from('users')
        .update({'avatar': avatarKey}).eq(
            'uuid', Supabase.instance.client.auth.currentUser!.id);
  }

  Future<int?> getUserAvatar() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await Supabase.instance.client
        .from('users')
        .select('avatar')
        .eq('uuid', userId)
        .single();

    return response['avatar'];
  }

  Future<String> getAvatarImagePath(int? avatarIndex) async {
    if (avatarIndex == null || !RAvatars.avatarMap.containsKey(avatarIndex)) {
      return RImages.profilePickImage;
    }
    return RAvatars.avatarMap[avatarIndex]!;
  }
}
