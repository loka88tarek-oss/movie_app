import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie/model/about_movie_model.dart';

part 'about_movie_state.dart';

class AboutMovieCubit extends Cubit<AboutMovieState> {
  AboutMovieCubit() : super(AboutMovieInitial());

  Future<void> getAboutMovie(int movieId) async {
    emit(AboutMovieLoading());
    var dio = Dio();
    try {
      var res = await dio.get(
        "https://api.themoviedb.org/3/movie/$movieId?language=en-US",
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
            "accept": "application/json",
          },
        ),
      );
      var data = AboutMovieModel.fromJson(res.data);
      emit(AboutMovieSuccess(data));
    } catch (e) {
      emit(AboutMovieFailure(e.toString()));
    }
  }
}
