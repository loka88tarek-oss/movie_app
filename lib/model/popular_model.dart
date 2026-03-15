import 'package:movie/model/movie_model.dart';

class PopularResponse {
  final int page;
  final List<TmdbMovie> results;
  final int totalPages;
  final int totalResults;

  PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularResponse.fromJson(Map<String, dynamic> json) {
    return PopularResponse(
      page: json['page'] ?? 0,
      results:
          (json['results'] as List?)
              ?.map((e) => TmdbMovie.fromJson(e))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}
