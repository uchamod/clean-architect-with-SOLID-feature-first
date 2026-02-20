import 'package:clen_archetecture_bloc_app/core/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        
      },
    );
    // BlocSelector<AppUserCubit, AppUserState, bool>(
    //   selector: (state) {
    //     print("current state $state");
    //     return state is AppUserLoggedIn;
    //   },
    //   builder: (context, state) {
    //     if (state) {
    //       // context.goNamed(RouterNames.home);
    //       return HomePage();
    //     }
    //       return SingInPage();
    //       // context.goNamed(RouterNames.login);

    //     //return Center(child: CircularProgressIndicator());
    //   },
    // );
  }
}
