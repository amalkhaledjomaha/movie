import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:moviesproject/core/theme/app_colors.dart';

class EgyptFlag  extends StatelessWidget{
  const EgyptFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CustomPaint(
        size: const Size(26.88, 26.88),
        painter:EgyptFlagPainter() ,
      ),
    );
  }

}
class EgyptFlagPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final stripeHeight = size.height / 3;
    paint.color = AppColors.red;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, stripeHeight), paint);

    paint.color = AppColors.white;
    canvas.drawRect(Rect.fromLTWH(0, stripeHeight, size.width, stripeHeight), paint);

    paint.color = AppColors.darkblack;
    canvas.drawRect(Rect.fromLTWH(0,stripeHeight*2, size.width, stripeHeight), paint);

    paint.color = AppColors.gold;

    final centerX = size.width / 2;
    final centerY = stripeHeight * 1.55;

    final eagle = Path();

    // بداية من منتصف الرأس
    eagle.moveTo(centerX, centerY - size.height * 0.10);

    // الرأس
    eagle.cubicTo(
      centerX - size.width * 0.07,
      centerY - size.height * 0.10,
      centerX - size.width * 0.10,
      centerY - size.height * 0.03,
      centerX - size.width * 0.10,
      centerY + size.height * 0.03,
    );

    // الجناح الأيسر العلوي
    eagle.lineTo(centerX - size.width * 0.22, centerY + size.height * 0.03);
    eagle.lineTo(centerX - size.width * 0.40, centerY + size.height * 0.03);

    // طرف الجناح الأيسر
    eagle.lineTo(centerX - size.width * 0.40, centerY + size.height * 0.09);

    // أسفل الجناح الأيسر
    eagle.cubicTo(
      centerX - size.width * 0.35,
      centerY + size.height * 0.09,
      centerX - size.width * 0.30,
      centerY + size.height * 0.10,
      centerX - size.width * 0.25,
      centerY + size.height * 0.11,
    );

    eagle.cubicTo(
      centerX - size.width * 0.24,
      centerY + size.height * 0.20,
      centerX - size.width * 0.16,
      centerY + size.height * 0.25,
      centerX,
      centerY + size.height * 0.25,
    );

    // الجسم السفلي
    eagle.cubicTo(
      centerX + size.width * 0.16,
      centerY + size.height * 0.25,
      centerX + size.width * 0.24,
      centerY + size.height * 0.20,
      centerX + size.width * 0.25,
      centerY + size.height * 0.11,
    );

    // الجناح الأيمن السفلي
    eagle.cubicTo(
      centerX + size.width * 0.30,
      centerY + size.height * 0.10,
      centerX + size.width * 0.35,
      centerY + size.height * 0.09,
      centerX + size.width * 0.40,
      centerY + size.height * 0.09,
    );

    // طرف الجناح الأيمن
    eagle.lineTo(
      centerX + size.width * 0.40,
      centerY + size.height * 0.03,
    );

    // الجناح الأيمن العلوي
    eagle.lineTo(centerX + size.width * 0.22, centerY + size.height * 0.03);
    eagle.lineTo(centerX + size.width * 0.10, centerY + size.height * 0.03);

    // الرجوع للرأس
    eagle.cubicTo(
      centerX + size.width * 0.10,
      centerY - size.height * 0.03,
      centerX + size.width * 0.07,
      centerY - size.height * 0.10,
      centerX,
      centerY - size.height * 0.10,
    );

    eagle.close();
    canvas.translate(centerX, centerY);
    canvas.scale(0.55, 0.55);
    canvas.translate(-centerX, -centerY);

    canvas.drawPath(eagle, paint);

    canvas.restore();

    canvas.drawPath(eagle, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

    return false;
  }

}