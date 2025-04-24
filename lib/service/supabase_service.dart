import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdrive/constraints/images_routes.dart';
import 'package:wisdrive/service/auth_service.dart';
import 'package:wisdrive/widgets/general/response_snackbar.dart';

class SupabaseService {
  final authService = AuthService();
  final supabase = Supabase.instance.client;
  final box = GetStorage();

  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final response =
          await supabase.from('users').select().eq('uuid', user.id).maybeSingle();

      return response; // ya es un Map<String, dynamic>
    } catch (e) {
      ResponseSnackbar.show(Get.context!, true, "Error al obtener usuario: $e");
      return null;
    }
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

    if (existing != null) return;

    try {
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
      box.write("isFirstTimeLogged", false);
    } catch (e) {
      ResponseSnackbar.show(
          Get.context!, true, "error al crear usuario en la bd: $e");
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
      print("|${userId}|");
      print(updates);
      await supabase
          .from('users')
          .update(updates)
          .eq('uuid', userId as dynamic)
          .single();
    } catch (e) {
      print(e);
      throw Exception("Error actualizando perfil: $e");
    }
  }

  Future<void> setUserAvatar(int avatarKey) async {
    await Supabase.instance.client // Save avatar in supabase
        .from('users')
        .update({'avatar': avatarKey}).eq(
            'id', Supabase.instance.client.auth.currentUser!.id);
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
