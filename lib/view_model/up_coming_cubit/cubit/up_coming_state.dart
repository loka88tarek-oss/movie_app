part of 'up_coming_cubit.dart';

@immutable
sealed class UpComingState {}

final class UpComingInitial extends UpComingState {}

final class UpComingLoading extends UpComingState {}

final class UpComingFailure extends UpComingState {
  final String message;
  UpComingFailure(this.message);
}

final class UpComingSuccess extends UpComingState {
  final UpComingModel upcomingResponse;
  UpComingSuccess(this.upcomingResponse);
}
