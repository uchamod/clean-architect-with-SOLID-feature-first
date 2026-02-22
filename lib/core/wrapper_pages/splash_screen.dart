import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPallete.gradient2,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rocket_launch,
            size: 48,
            color: AppColorPallete.whiteColor,
          ),
          SizedBox(height: 16),
          SpinKitWave(
            color: AppColorPallete.whiteColor,
            size: 36,
            type: SpinKitWaveType.center,
          ),
        ],
      ),
    );
  }
}
