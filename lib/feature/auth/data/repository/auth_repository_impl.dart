import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/error/exception.dart';
import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/core/network/connection_checker.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/datasource/remote_data_source_impl.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/data/models/user_model.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Faliure, UserModel?>> getCurrentUser() async {
    try {
      if (!await (connectionChecker.isConnectionHas)) {
        final session = remoteDataSource.getCurrentUserSession;
        if (session == null) {
          return left(
            Faliure(statusCode: 503, message: AppConstants.connectionError),
          );
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? "",
            name: "",
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUser();
      return right(user);
    } catch (e) {
      return left(Faliure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnectionHas)) {
        return left(
          Faliure(statusCode: 503, message:  AppConstants.connectionError),
        );
      }
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
      if (!await (connectionChecker.isConnectionHas)) {
        return left(
          Faliure(statusCode: 503, message:  AppConstants.connectionError),
        );
      }
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
