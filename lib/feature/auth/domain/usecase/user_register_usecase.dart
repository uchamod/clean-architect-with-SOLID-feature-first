import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/core/usecase/usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/repository/auth_repository.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class UserRegisterUsecase implements Usecase<String, UserRegisterParms> {
  final AuthRepository authRepository;

  UserRegisterUsecase({required this.authRepository});

  @override
  Future<Either<Faliure, String>> call(UserRegisterParms parms) async {
    return await authRepository.registerUser(
      userName: parms.name,
      email: parms.email,
      password: parms.password,
    );
  }
}

class UserRegisterParms {
  final String name;
  final String email;
  final String password;

  UserRegisterParms({
    required this.name,
    required this.email,
    required this.password,
  });
}
