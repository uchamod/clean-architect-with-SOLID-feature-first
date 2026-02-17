import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegisterUsecase _userRegisterUsecase;

  AuthBloc({required UserRegisterUsecase userRegisterUsecase})
    : _userRegisterUsecase = userRegisterUsecase,
      super(AuthInitial()) {
    on<AuthSingUp>((event, emit) async {
      final res = await _userRegisterUsecase.call(
        UserRegisterParms(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
        (l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthSuccsuss(uid: r)),
      );
    });
  }
}
