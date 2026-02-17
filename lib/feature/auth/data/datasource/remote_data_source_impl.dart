import 'package:clen_archetecture_bloc_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RemoteDataSource {
  Future<String> loginWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<String> loginWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async{
     return "";
  }

  @override
  Future<String> registerWithEmailAndPassword({
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
        throw ServerException(message: "user is null");
      }
      return authResponse.user!.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
