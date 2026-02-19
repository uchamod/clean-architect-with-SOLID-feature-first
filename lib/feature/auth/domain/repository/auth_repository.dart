import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/entity/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Faliure, User>> registerUser({
    required String userName,
    required String email,
    required String password,
  });
  Future<Either<Faliure, User>> loginUser({
    required String email,
    required String password,
  });
}
