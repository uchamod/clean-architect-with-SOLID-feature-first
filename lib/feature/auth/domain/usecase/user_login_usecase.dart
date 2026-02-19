import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/core/usecase/usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/entity/user.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUsecase implements Usecase<User, UserLoginParms> {
  final AuthRepository authRepository;

  UserLoginUsecase({required this.authRepository});

  @override
  Future<Either<Faliure, User>> call(UserLoginParms parms) async {
    return await authRepository.loginUser(
      email: parms.email,
      password: parms.password,
    );
  }
}

class UserLoginParms {
  final String email;
  final String password;

  UserLoginParms({required this.email, required this.password});
}
