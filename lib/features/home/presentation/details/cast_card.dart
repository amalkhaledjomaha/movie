import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/home/data/model/movie_details.dart';

class CastCard extends StatelessWidget {

  final CastMember actor;

  const CastCard({
    required this.actor,
  });

  @override
  Widget build(
      BuildContext context,
      ) {

    return Container(
      width: double.infinity,

      height: 120,

      margin:
      const EdgeInsets.only(
        bottom: 8,
      ),

      padding:
      const EdgeInsets.all(12),

      decoration:
      BoxDecoration(
        color:
        AppColors.gray27,

        borderRadius:
        BorderRadius.circular(
          18,
        ),
      ),

      child: Row(
        children: [


          ClipRRect(
            borderRadius:
            BorderRadius.circular(
              10,
            ),

            child:
            actor.imageUrl.isNotEmpty
                ? Image.network(
              actor.imageUrl,

              width: 82,
              height: 82,

              fit: BoxFit.cover,

              errorBuilder:
                  (_, __, ___) {

                return
                  _personPlaceholder();
              },
            )
                : _personPlaceholder(),
          ),


          const SizedBox(
            width: 12,
          ),



          Expanded(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  '${AppString.name} : ${actor.name}',

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  AppTextStyle.regular18white

                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  '${AppString.character} : ${actor.character}',

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  AppTextStyle.regular18white

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _personPlaceholder() {

    return Container(
      width: 82,
      height: 82,

      color:
      AppColors.blackgray,

      child:  Icon(
        Icons.person,
        color:
        AppColors.white24,
        size: 35,
      ),
    );
  }
}
