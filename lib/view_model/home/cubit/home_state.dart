part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  late String message;
}

final class HomeInitial extends HomeState {}

final class Homeloading extends HomeState {}

final class HomeFailure extends HomeState {
  @override
  final String message;
  HomeFailure(this.message);
}

final class HomeSucess extends HomeState {
  @override
  final MovieResponse movies;
  HomeSucess(this.movies);
}
