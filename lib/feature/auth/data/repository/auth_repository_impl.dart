import 'package:clen_archetecture_bloc_app/core/error/exception.dart';
import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/datasource/remote_data_source_impl.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/models/user_model.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Faliure, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userModel);
    } on ServerException catch (e) {
      return left(Faliure(statusCode: 404, message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, UserModel>> registerUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.registerWithEmailAndPassword(
        name: userName,
        email: email,
        password: password,
      );
      return right(userModel);
    } on ServerException catch (e) {
      return left(Faliure(statusCode: 404, message: e.message));
    }
  }
}
