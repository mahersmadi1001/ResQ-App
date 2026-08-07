import 'package:flutter/material.dart';
import 'package:projct/core/theme/colors_app.dart';

class CircularPro extends StatelessWidget {
  const CircularPro({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: AppColors.yellowPro);
  }
}

