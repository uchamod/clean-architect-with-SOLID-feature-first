import 'package:clen_archetecture_bloc_app/core/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:clen_archetecture_bloc_app/core/entity/user.dart';
import 'package:clen_archetecture_bloc_app/core/usecase/auth/usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_login_usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/domain/usecase/user_register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegisterUsecase _userRegisterUsecase;
  final UserLoginUsecase _userLoginUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserRegisterUsecase userRegisterUsecase,
    required UserLoginUsecase userLoginUsecase,
    required GetCurrentUserUsecase getCurrentUserUsecase,
    required AppUserCubit appUserCubit,
  }) : _userRegisterUsecase = userRegisterUsecase,
       _userLoginUsecase = userLoginUsecase,
       _getCurrentUserUsecase = getCurrentUserUsecase,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSingUp);
    on<AuthSingIn>(_onAuthSingIn);
    on<AuthuserLoggedIn>(_getCurrentUser);
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
      (user) => _emitAuthSuccsuss(user, emit),
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
      (user) => _emitAuthSuccsuss(user, emit),
    );
  }

  //if have one method no need to mention exact method name can call it using object itself
  void _getCurrentUser(AuthuserLoggedIn event, Emitter<AuthState> emit) async {
   // emit(AuthLoading());
    final user = await _getCurrentUserUsecase(NoParams());
    user.fold(
      (fail) => emit(AuthFailure(message: fail.message)),
      (user) => _emitAuthSuccsuss(user, emit),
    );
  }

  void _emitAuthSuccsuss(User? user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
