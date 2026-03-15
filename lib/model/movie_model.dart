import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class TmdbMovie extends HiveObject {
  @HiveField(0)
  final bool adult;

  @HiveField(1)
  final String? backdropPath;

  @HiveField(2)
  final List<int> genreIds;

  @HiveField(3)
  final int id;

  @HiveField(4)
  final String originalLanguage;

  @HiveField(5)
  final String originalTitle;

  @HiveField(6)
  final String overview;

  @HiveField(7)
  final double popularity;

  @HiveField(8)
  final String? posterPath;

  @HiveField(9)
  final DateTime releaseDate;

  @HiveField(10)
  final String title;

  @HiveField(11)
  final bool video;

  @HiveField(12)
  final double voteAverage;

  @HiveField(13)
  final int voteCount;

  TmdbMovie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TmdbMovie.fromJson(Map<String, dynamic> json) {
    return TmdbMovie(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'] ?? 0,
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'] != null && json['release_date'] != ''
          ? DateTime.parse(json['release_date'])
          : DateTime(1900),
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate.toIso8601String(),
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
