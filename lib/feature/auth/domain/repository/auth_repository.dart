import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Faliure, String>> registerUser({
    required String userName,
    required String email,
    required String password,
  });
  Future<Either<Faliure, String>> loginUser({
    required String email,
    required String password,
  });
}
