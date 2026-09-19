import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviesproject/features/home/data/model/movie_details.dart';

class WatchlistService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WatchlistService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _userId {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _watchlist {
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('watchList');
  }

  Future<void> addToWatchlist(MovieDetails movie) async {
    await _watchlist.doc(movie.id.toString()).set({
      'id': movie.id,
      'title': movie.title,
      'year': movie.year,
      'rating': movie.rating,
      'mediumCoverImage': movie.mediumCoverImage,
      'largeCoverImage': movie.largeCoverImage,
      'backgroundImage': movie.backgroundImage,
    });
  }

  Future<void> removeFromWatchlist(int movieId) async {
    await _watchlist
        .doc(movieId.toString())
        .delete();
  }

  Future<bool> isInWatchlist(int movieId) async {
    final document = await _watchlist
        .doc(movieId.toString())
        .get();

    return document.exists;
  }

  Stream<List<MovieDetails>> watchlistStream() {
    return _watchlist.snapshots().map((snapshot) {
      final movies = snapshot.docs.map((doc) {
        final data = doc.data();

        return MovieDetails(
          id: data['id'] ?? 0,
          title: data['title'] ?? '',
          titleLong: data['title'] ?? '',
          year: data['year'] ?? 0,
          rating: (data['rating'] as num?)?.toDouble() ?? 0.0,

          mediumCoverImage: data['mediumCoverImage'] ?? '',
          largeCoverImage: data['largeCoverImage'] ?? '',
          backgroundImage: data['backgroundImage'] ?? '',

          description: '',
          runtime: 0,
          genres: [],
          cast: [],
          likeCount: 0,
          url: '',
          screenshots: [],
          ytTrailerCode: '',
        );
      }).toList();

      movies.sort(
            (a, b) => b.rating.compareTo(a.rating),
      );

      return movies;
    });
  }
}