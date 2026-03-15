class MovieReviewsModel {
  final int? id;
  final int? page;
  final List<Review>? results;
  final int? totalPages;
  final int? totalResults;

  MovieReviewsModel({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieReviewsModel.fromJson(Map<String, dynamic> json) {
    return MovieReviewsModel(
      id: json['id'],
      page: json['page'],
      results: json['results'] != null
          ? List<Review>.from(json['results'].map((x) => Review.fromJson(x)))
          : [],
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class Review {
  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final String? createdAt;
  final String? id;
  final String? updatedAt;
  final String? url;

  Review({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      authorDetails: json['author_details'] != null
          ? AuthorDetails.fromJson(json['author_details'])
          : null,
      content: json['content'],
      createdAt: json['created_at'],
      id: json['id'],
      updatedAt: json['updated_at'],
      url: json['url'],
    );
  }
}

class AuthorDetails {
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  AuthorDetails({this.name, this.username, this.avatarPath, this.rating});

  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    return AuthorDetails(
      name: json['name'],
      username: json['username'],
      avatarPath: json['avatar_path'],
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }
}
