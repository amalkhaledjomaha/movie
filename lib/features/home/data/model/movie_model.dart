class Movie {
  final int id;
  final String title;
  final String titleLong;
  final int year;
  final double rating;
  final String mediumCoverImage;
  final String backgroundImage;
  final String description;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.mediumCoverImage,
    required this.backgroundImage,
    required this.description,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleLong: json['title_long'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      mediumCoverImage: json['medium_cover_image'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      description: json['description_full'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}