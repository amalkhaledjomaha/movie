import 'package:flutter/cupertino.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/home/data/model/movie_details.dart';
import 'package:moviesproject/features/home/presentation/details/cast_card.dart';

class CastSection extends StatelessWidget{
  final List<CastMember> cast;

  const CastSection({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return Text(
        AppString.nocastinformationavailable,
        style: AppTextStyle.regular11white,
      );
    }

    return Column(
      children: cast.map(
            (actor) {
          return CastCard(
            actor: actor,
          );
        },
      ).toList(),
    );
  }
  
}