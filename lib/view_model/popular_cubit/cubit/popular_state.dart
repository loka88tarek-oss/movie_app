part of 'popular_cubit.dart';

@immutable
sealed class PopularState {}

final class PopularInitial extends PopularState {}

final class PopularLoading extends PopularState {}

final class PopularFailure extends PopularState {
  final String message;
  PopularFailure(this.message);
}

final class PopularSuccess extends PopularState {
  final PopularResponse popularResponse;
  PopularSuccess(this.popularResponse);
}
