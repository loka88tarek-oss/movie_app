import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie/model/popular_model.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());
  Future<void> getPopular() async {
    emit(PopularLoading());
    var dio = Dio();
    try {
      var res = await dio.get(
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1",
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",

            "accept": "application/json",
          },
        ),
      );
      var data = PopularResponse.fromJson(res.data);
      emit(PopularSuccess(data));
    } catch (e) {
      emit(PopularFailure(e.toString()));
    }
  }
}
