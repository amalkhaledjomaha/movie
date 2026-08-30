import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
class AvatarBottomSheet  extends StatelessWidget{

  final String selectedAvatar;
  final List<String> avtars ;
  final Function(String) onAvaterSelected;
  const AvatarBottomSheet({
    super.key,
    required this.avtars,
    required this.selectedAvatar,
    required this.onAvaterSelected
});

  @override
  Widget build(BuildContext context) {

          return Container(
            margin: EdgeInsets.all(18),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: AppColors.darkblack,
                borderRadius: BorderRadius.circular(28)
            ),
            child:
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: avtars.length,
              gridDelegate: const
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,crossAxisSpacing: 24,mainAxisSpacing: 24,childAspectRatio: 1),
              itemBuilder: (context,index){
                final avater =avtars[index];
                return GestureDetector(
                  onTap: (){
                   onAvaterSelected(avater);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(

                      color: selectedAvatar ==avater ?
                      AppColors.yellow.withOpacity(0.3):
                      AppColors.darkblack,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.yellow,width: 2,
                      ),

                    ),
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(18),
                      child: Image.asset(avater,fit: BoxFit.cover,),
                    ),
                  ),

                );

              },),
          );
        }


  }

