/// Models for:
/// { "id": 550, "cast": [...], "crew": [...] }
class MovieCreditsResponse {
  final int id;
  final List<CastMember> cast;
  final List<CrewMember> crew;

  const MovieCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory MovieCreditsResponse.fromJson(Map<String, dynamic> json) {
    return MovieCreditsResponse(
      id: (json['id'] as num).toInt(),
      cast: (json['cast'] as List<dynamic>? ?? const [])
          .map((e) => CastMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>? ?? const [])
          .map((e) => CrewMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cast': cast.map((e) => e.toJson()).toList(),
    'crew': crew.map((e) => e.toJson()).toList(),
  };
}

class CastMember {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;

  final int castId;
  final String character;
  final String creditId;
  final int order;

  const CastMember({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      adult: (json['adult'] as bool?) ?? false,
      gender: (json['gender'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num).toInt(),
      knownForDepartment: (json['known_for_department'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      originalName: (json['original_name'] as String?) ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      castId: (json['cast_id'] as num?)?.toInt() ?? 0,
      character: (json['character'] as String?) ?? '',
      creditId: (json['credit_id'] as String?) ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'gender': gender,
    'id': id,
    'known_for_department': knownForDepartment,
    'name': name,
    'original_name': originalName,
    'popularity': popularity,
    'profile_path': profilePath,
    'cast_id': castId,
    'character': character,
    'credit_id': creditId,
    'order': order,
  };
}

class CrewMember {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;

  final String creditId;
  final String department;
  final String job;

  const CrewMember({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory CrewMember.fromJson(Map<String, dynamic> json) {
    return CrewMember(
      adult: (json['adult'] as bool?) ?? false,
      gender: (json['gender'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num).toInt(),
      knownForDepartment: (json['known_for_department'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      originalName: (json['original_name'] as String?) ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      creditId: (json['credit_id'] as String?) ?? '',
      department: (json['department'] as String?) ?? '',
      job: (json['job'] as String?) ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'adult': adult,
    'gender': gender,
    'id': id,
    'known_for_department': knownForDepartment,
    'name': name,
    'original_name': originalName,
    'popularity': popularity,
    'profile_path': profilePath,
    'credit_id': creditId,
    'department': department,
    'job': job,
  };
}
