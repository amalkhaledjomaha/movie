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

      height: 43,

      margin:
      const EdgeInsets.only(
        bottom: 5,
      ),

      padding:
      const EdgeInsets.all(5),

      decoration:
      BoxDecoration(
        color:
        AppColors.gray27,

        borderRadius:
        BorderRadius.circular(
          7,
        ),
      ),

      child: Row(
        children: [


          ClipRRect(
            borderRadius:
            BorderRadius.circular(
              5,
            ),

            child:
            actor.imageUrl.isNotEmpty
                ? Image.network(
              actor.imageUrl,

              width: 34,
              height: 34,

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
            width: 7,
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
                  AppTextStyle.regular11white
                      .copyWith(
                    fontSize: 8,
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(
                  '${AppString.character} : ${actor.character}',

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  AppTextStyle.regular11white
                      .copyWith(
                    fontSize: 7.5,
                  ),
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
      width: 34,
      height: 34,

      color:
      AppColors.blackgray,

      child:  Icon(
        Icons.person,
        color:
        AppColors.white24,
        size: 18,
      ),
    );
  }
}
