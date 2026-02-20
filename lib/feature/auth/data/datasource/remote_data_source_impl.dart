import 'package:clen_archetecture_bloc_app/core/error/exception.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RemoteDataSource {
  //get current session of user
  Session? get getCurrentUserSession;

  //get current user data if login
  Future<UserModel?> getCurrentUser();

  //login user
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  //register user
  Future<UserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get getCurrentUserSession => supabaseClient.auth.currentSession;
  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (authResponse.user == null) {
        //print("user is null");
        throw ServerException(message: "user is null");
      }
      // print("user id is ${authResponse.user!.id}");
      return UserModel.fromJson(authResponse.user!.toJson());
    } catch (e) {
      // print("user stored issue is ${e.toString()}");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
      if (authResponse.user == null) {
        // print("user is null");
        throw ServerException(message: "user is null");
      }
      // print("user id is ${authResponse.user!.id}");
      return UserModel.fromJson(authResponse.user!.toJson());
    } catch (e) {
      //  print("user stored issue is ${e.toString()}");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (getCurrentUserSession != null) {
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq('id', getCurrentUserSession!.user.id);
       // print("user avalible $userData");
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: getCurrentUserSession!.user.email);
      }
     // print("user not avalible");
      return null;
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
