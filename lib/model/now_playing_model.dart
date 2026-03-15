import 'package:movie/model/movie_model.dart';

class TmdbNowPlayingResponse {
  final Dates? dates;
  final int page;
  final List<TmdbMovie> results;
  final int totalPages;
  final int totalResults;

  TmdbNowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbNowPlayingResponse.fromJson(Map<String, dynamic> json) {
    return TmdbNowPlayingResponse(
      dates: json['dates'] != null
          ? Dates.fromJson(json['dates'] as Map<String, dynamic>)
          : null,
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => TmdbMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class Dates {
  final String maximum;
  final String minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'] ?? '',
      minimum: json['minimum'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'maximum': maximum, 'minimum': minimum};
  }
}
