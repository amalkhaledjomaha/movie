import 'package:flutter/material.dart';

class AvatarCarousel extends StatefulWidget {
  final List<String> images;

  const AvatarCarousel({
    super.key,
    required this.images,
  });

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel>{
 late PageController _pageController;

 void initState()
 {
   super.initState();
   _pageController =PageController(
     initialPage: 1,
     viewportFraction: 0.34,
   );
 }
 @override
 void dispose(){
   _pageController.dispose();
   super.dispose();
}
  @override
  Widget build(BuildContext context) {
   return SizedBox(
     height: 180,
     child: PageView.builder(
       controller: _pageController,
         itemCount: widget.images.length,
         physics: const BouncingScrollPhysics(),
         
         itemBuilder: (context,index)
     {
       return AnimatedBuilder(animation: _pageController,
           builder: (context,child){
         double scale =0.85;
         if(_pageController.position.haveDimensions){
           final page =_pageController.page ??0;
           final difference =(page -index).abs();
           scale =(1-difference *0.3).clamp(0.7, 1.0);
         }
         return Center(
           child:  AnimatedScale(
               scale: scale,
               duration: const Duration(
                 microseconds: 200,
               ),
           child: ClipOval(
             child:Image.asset(
               widget.images[index],
               width: 158.0,
               height: 161.0,
               fit: BoxFit.cover,
             ) ,
           ),
           ),
         );
           },);
     },),
   );
  }

}