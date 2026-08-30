import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/theme/app_colors.dart';


class LiberiaFlag extends StatelessWidget {
  const LiberiaFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CustomPaint(
        size: const Size(26.88, 26.88),
        painter: LiberiaFlagPainter(),
      ),
    );
  }


}
class LiberiaFlagPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint =Paint();
    final double stripeHeight =size.height/11;
    for(int i =0;i<11;i++){
      paint.color =i.isEven ?
       AppColors.redlight:
      AppColors.white;
      canvas.drawRect(Rect.fromLTWH(0, i*stripeHeight, size.width, stripeHeight),
          paint);
    }
    paint.color = AppColors.darkblue;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width*0.45, stripeHeight*5), paint);
    final center =Offset(size.width *0.225, stripeHeight *2.5);
    final path=Path();

    const int points=5;
    final double outerRadius =size.width *0.14;
    final double innerRadius =outerRadius *0.4;

    for(int i=0; i<points *2;i++)
    {
      final radius =i.isEven ?outerRadius :innerRadius;
      final angle= -3.14159 /2+(3.14159 *i/points);

      final x=center.dx +radius *cos(angle);
      final y=center.dy +radius *sin(angle);

      if(i==0) {
        path.moveTo(x, y);
      }else {
        path.lineTo(x, y);
      }
    }
    path.close();
    paint.color =AppColors.white;
    canvas.drawPath(path, paint);

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

    return false;
  }

}