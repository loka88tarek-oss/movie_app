part of 'about_movie_cubit.dart';

@immutable
sealed class AboutMovieState {}

final class AboutMovieInitial extends AboutMovieState {}

final class AboutMovieLoading extends AboutMovieState {}

final class AboutMovieFailure extends AboutMovieState {
  final String message;
  AboutMovieFailure(this.message);
}

final class AboutMovieSuccess extends AboutMovieState {
  final AboutMovieModel aboutMovieModel;
  AboutMovieSuccess(this.aboutMovieModel);
}
