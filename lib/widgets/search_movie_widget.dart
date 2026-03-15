import 'package:flutter/material.dart';
import 'package:movie/model/movie_model.dart';

class SearchMovieWidget extends StatelessWidget {
  final TmdbMovie movie;

  const SearchMovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star_border, color: Colors.orange, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(color: Colors.orange, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.local_attraction_outlined,
                    color: Colors.white54,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      movie.genreIds.join(' • '),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white54,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${movie.releaseDate.year}-${movie.releaseDate.month.toString().padLeft(2, '0')}-${movie.releaseDate.day.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.how_to_vote_rounded,
                    color: Colors.white54,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    movie.voteCount.toString(),
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
