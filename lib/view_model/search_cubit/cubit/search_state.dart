part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchFailure extends SearchState {
  final String message;
  SearchFailure(this.message);
}

final class SearchSucess extends SearchState {
  final SearchMovieResponse searchResponseModel;
  SearchSucess(this.searchResponseModel);
}
