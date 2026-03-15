part of 'cast_cubit.dart';

@immutable
sealed class CastState {}

final class CastInitial extends CastState {}

final class CastLoading extends CastState {}

final class CastFailure extends CastState {
  final String message;
  CastFailure(this.message);
}

final class CastSuccess extends CastState {
  final MovieCreditsResponse castResponse;
  CastSuccess(this.castResponse);
}
