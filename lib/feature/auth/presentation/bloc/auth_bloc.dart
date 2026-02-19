import 'package:clen_archetecture_bloc_app/feature/auth/domain/entity/user.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_login_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegisterUsecase _userRegisterUsecase;
  final UserLoginUsecase _userLoginUsecase;
  AuthBloc({
    required UserRegisterUsecase userRegisterUsecase,
    required UserLoginUsecase userLoginUsecase,
  }) : _userRegisterUsecase = userRegisterUsecase,
       _userLoginUsecase = userLoginUsecase,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSingUp);
    on<AuthSingIn>(_onAuthSingIn);
  }
  //register user
  void _onAuthSingUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userRegisterUsecase.call(
      UserRegisterParms(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (fail) => emit(AuthFailure(message: fail.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  //login user
  void _onAuthSingIn(AuthSingIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLoginUsecase.call(
      UserLoginParms(email: event.email, password: event.password),
    );
    res.fold(
      (fail) => emit(AuthFailure(message: fail.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
