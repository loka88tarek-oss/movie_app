import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie/model/cast_model.dart';

part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  CastCubit() : super(CastInitial());

  Future<void> getCast(int movieId) async {
    // ✅ accept movieId
    emit(CastLoading());
    var dio = Dio();
    try {
      var res = await dio.get(
        "https://api.themoviedb.org/3/movie/$movieId/credits?language=en-US", // ✅ use it
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
            "accept": "application/json",
          },
        ),
      );
      var data = MovieCreditsResponse.fromJson(res.data);
      emit(CastSuccess(data));
    } catch (e) {
      emit(CastFailure(e.toString()));
    }
  }
}
