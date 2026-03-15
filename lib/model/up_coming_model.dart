import 'package:movie/model/movie_model.dart';

class UpComingModel {
  final Dates? dates;
  final int? page;
  final List<TmdbMovie>? results;
  final int? totalPages;
  final int? totalResults;

  UpComingModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory UpComingModel.fromJson(Map<String, dynamic> json) {
    return UpComingModel(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'],
      results: json['results'] != null
          ? List<TmdbMovie>.from(
              json['results'].map((e) => TmdbMovie.fromJson(e)),
            )
          : null,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results?.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class Dates {
  final String? maximum;
  final String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(maximum: json['maximum'], minimum: json['minimum']);
  }

  Map<String, dynamic> toJson() {
    return {'maximum': maximum, 'minimum': minimum};
  }
}
