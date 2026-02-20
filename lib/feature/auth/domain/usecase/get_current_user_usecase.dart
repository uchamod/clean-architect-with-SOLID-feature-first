import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/core/usecase/usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/entity/user.dart';

class GetCurrentUserUsecase implements Usecase<User?, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUserUsecase({required this.authRepository});

  @override
  Future<Either<Faliure, User?>> call(NoParams parms) async {
    return await authRepository.getCurrentUser();
  }
}
