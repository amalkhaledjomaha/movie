class MovieDetails {
  final int id;
  final String title;
  final String titleLong;
  final int year;
  final double rating;
  final int likeCount;

  final String mediumCoverImage;
  final String largeCoverImage;
  final String backgroundImage;

  final String description;
  final int runtime;
  final String url;
  final List<String> genres;
  final List<CastMember> cast;

  final List<String> screenshots;
  final String ytTrailerCode;

  const MovieDetails({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.backgroundImage,
    required this.description,
    required this.runtime,
    required this.genres,
    required this.cast,
    required this.likeCount,
    required this.url,
    required this.screenshots,
    required this.ytTrailerCode,
  });

  factory MovieDetails.fromJson(
      Map<String, dynamic> json,
      ) {
    return MovieDetails(
      id: json['id'] ?? 0,

      title: json['title'] ?? '',

      titleLong: json['title_long'] ?? '',

      year: json['year'] ?? 0,

      rating: (json['rating'] ?? 0).toDouble(),
      likeCount: json['like_count'] ?? 0,

      mediumCoverImage:
      json['medium_cover_image'] ?? '',

      largeCoverImage:
      json['large_cover_image'] ?? '',

      backgroundImage:
      json['background_image'] ?? '',

      description:
      json['description_full'] ?? '',

      runtime:
      json['runtime'] ?? 0,

      genres:
      List<String>.from(
        json['genres'] ?? [],
      ),

      cast:
      (json['cast'] as List? ?? [])
          .map(
            (cast) => CastMember.fromJson(
          cast as Map<String, dynamic>,
        ),
      )
          .toList(),



      url: json['url'] ?? '',
      ytTrailerCode: json['yt_trailer_code'] ?? '',
      screenshots: <String>[
        json['medium_screenshot_image1'] ?? '',
        json['medium_screenshot_image2'] ?? '',
        json['medium_screenshot_image3'] ?? '',
      ].where((image) => image.isNotEmpty).toList(),

    );
  }
}


// CAST


class CastMember {
  final String name;
  final String character;
  final String imageUrl;
  final String imdbCode;


  const CastMember({
    required this.name,
    required this.character,
    required this.imageUrl,
    required this.imdbCode,

  });

  factory CastMember.fromJson(
      Map<String, dynamic> json,
      ) {
    return CastMember(
      name: json['name'] ?? '',
      character: json['character_name'] ?? '',
      imageUrl: json['url_small_image'] ?? '',
      imdbCode: json['imdb_code'] ?? '',
    );
  }
}