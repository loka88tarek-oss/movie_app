import 'package:movie/model/movie_model.dart';

class TopRatedResponse {
  final int page;
  final List<TmdbMovie> results;
  final int totalPages;
  final int totalResults;

  TopRatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TopRatedResponse.fromJson(Map<String, dynamic> json) {
    return TopRatedResponse(
      page: json['page'],
      results: List<TmdbMovie>.from(
        json['results'].map((x) => TmdbMovie.fromJson(x)),
      ),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
