import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../data/model/movie_details.dart';
import '../../data/watchlist/watchlist_service.dart';
import 'package:url_launcher/url_launcher.dart';

// class FilmCover extends StatelessWidget {
//   final MovieDetails movie;
//   const FilmCover({super.key, required this.movie});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: screenWidth,
//       height: screenHeight,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.network(movie.largeCoverImage, fit: BoxFit.cover),
//           ),
//
//           Positioned.fill(
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     AppColors.movieCoverGradientStart,
//                     AppColors.movieCoverGradientEnd,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Back button
//           Positioned(
//             top: 20,
//             left: 16,
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: AppColors.white,
//                 size: 29,
//               ),
//             ),
//           ),
//
//           // Favorite button
//           Positioned(
//             top: 20,
//             right: 16,
//             child: IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.bookmark_outlined,
//                 color: AppColors.white,
//                 size: 29,
//               ),
//             ),
//           ),
//           // play image
//           Positioned(
//             top: 248,
//             left:0,
//             right: 0,
//             child: Center(
//               child: Image.asset(
//                AppAssets.playing,
//                 fit: BoxFit.cover,
//                 height: 97,
//                 width: 97,
//               ),
//             ),
//           ),
//           //title ,year
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 250,
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     movie.title,
//                     style: AppTextStyle.Bold24white,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     movie.year.toString(),
//                     style: AppTextStyle.Bold20gray,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // watch button
//           Positioned(
//             left: 16,
//             right: 16,
//             bottom:150,
//             child: ElevatedButton(
//               onPressed: () {
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.red,
//                 foregroundColor: AppColors.white,
//
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 12,
//                 ),
//               ),
//               child:Text(
//                 AppString.watch,
//                 style:AppTextStyle.bold18white,
//                 ),
//               ),
//             ),
//
//           Positioned(
//             left: 10,
//             right: 10,
//             bottom:70,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height:47,
//                   width: 110,
//                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                   decoration:BoxDecoration(
//                     color:AppColors.black,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child:Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment:MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.favorite,
//                         color: AppColors.yellow,
//                         size: 28,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         '15',
//                         style: AppTextStyle.regular14white,
//                       ),
//                     ],
//                   )
//                 ),
//
//                 Container(
//                     height:47,
//                     width: 110,
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                     decoration:BoxDecoration(
//                       color:AppColors.black,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child:Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment:MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.access_time,
//                           color: AppColors.yellow,
//                           size: 28,
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           movie.runtime.toString(),
//                           style: AppTextStyle.regular14white,
//                         ),
//                       ],
//                     )
//                 ),
//
//                 Container(
//                     height:47,
//                     width: 110,
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                     decoration:BoxDecoration(
//                       color:AppColors.black,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child:Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment:MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.star,
//                           color: AppColors.yellow,
//                           size: 28,
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           movie.rating.toString(),
//                           style: AppTextStyle.regular14white,
//                         ),
//                       ],
//                     )
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class FilmCover extends StatefulWidget {
  final MovieDetails movie;
  const FilmCover({super.key, required this.movie});

  @override
  State<FilmCover> createState() => _FilmCoverState();
}

class _FilmCoverState extends State<FilmCover> {
  final WatchlistService _watchlistService = WatchlistService();

  bool _isInWatchlist = false;
  bool _isLoadingWatchlist = true;

  @override
  void initState() {
    super.initState();
    _checkWatchlist();
  }

  Future<void> _checkWatchlist() async {
    try {
      final isSaved = await _watchlistService.isInWatchlist(widget.movie.id);

      if (!mounted) return;

      setState(() {
        _isInWatchlist = isSaved;
        _isLoadingWatchlist = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoadingWatchlist = false;
      });
    }
  }

  Future<void> _toggleWatchlist() async {
    try {
      if (_isInWatchlist) {
        await _watchlistService.removeFromWatchlist(widget.movie.id);
      } else {
        await _watchlistService.addToWatchlist(widget.movie);
      }

      if (!mounted) return;

      setState(() {
        _isInWatchlist = !_isInWatchlist;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please login first')));
    }
  }

  Future<void> _watchMovie() async {
    final uri = Uri.parse(widget.movie.url);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      print('LAUNCHED: $launched');
    } catch (e) {
      print('ERROR: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              widget.movie.largeCoverImage,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.movieCoverGradientStart,
                    AppColors.movieCoverGradientEnd,
                  ],
                ),
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 20,
            left: 16,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: 29,
              ),
            ),
          ),

          // Favorite button
          Positioned(
            top: 20,
            right: 16,
            child: IconButton(
              onPressed: _isLoadingWatchlist
              ? null
                  : _toggleWatchlist,
              icon: Icon(
              _isInWatchlist
              ? Icons.bookmark
                  : Icons.bookmark_border,
                color: AppColors.white,
                size: 29,
              ),
            ),
          ),
          // play image
          Positioned(
            top: 248,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.playing,
                fit: BoxFit.cover,
                height: 97,
                width: 97,
              ),
            ),
          ),
          //title ,year
          Positioned(
            left: 0,
            right: 0,
            bottom: 250,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.movie.title, style: AppTextStyle.Bold24white),
                  const SizedBox(height: 4),
                  Text(
                    widget.movie.year.toString(),
                    style: AppTextStyle.Bold20gray,
                  ),
                ],
              ),
            ),
          ),

          // watch button
          Positioned(
            left: 16,
            right: 16,
            bottom: 150,
            child: ElevatedButton(
              onPressed: _watchMovie,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(AppString.watch, style: AppTextStyle.bold18white),
            ),
          ),

          Positioned(
            left: 10,
            right: 10,
            bottom: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 47,
                  width: 110,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: AppColors.yellow, size: 28),
                      const SizedBox(width: 10),
                      Text( widget.movie.likeCount.toString(), style: AppTextStyle.regular14white),
                    ],
                  ),
                ),

                Container(
                  height: 47,
                  width: 110,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColors.yellow,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.movie.runtime.toString(),
                        style: AppTextStyle.regular14white,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 47,
                  width: 110,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: AppColors.yellow, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        widget.movie.rating.toString(),
                        style: AppTextStyle.regular14white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
