import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie/model/up_coming_model.dart';

part 'up_coming_state.dart';

class UpComingCubit extends Cubit<UpComingState> {
  UpComingCubit() : super(UpComingInitial());
  Future<void> getUpComing() async {
    emit(UpComingLoading());
    var dio = Dio();
    try {
      var res = await dio.get(
        "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1",
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
            "accept": "application/json",
          },
        ),
      );
      var data = UpComingModel.fromJson(res.data);
      emit(UpComingSuccess(data));
    } catch (e) {
      emit(UpComingFailure(e.toString()));
    }
  }
}
