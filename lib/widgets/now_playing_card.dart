import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view/screens/movie_details.dart';
import 'package:movie/view_model/now_playing_cubit/cubit/now_playing_cubit.dart';

class NowPlayingTab extends StatelessWidget {
  const NowPlayingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        if (state is NowPlayingLoading) {
          return TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: value,
                      backgroundColor: Color(0xFF2A2A45),
                      valueColor: AlwaysStoppedAnimation(Color(0xFF7B8FFF)),
                      strokeWidth: 8,
                    ),
                    Text(
                      '${(value * 100).toInt()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        if (state is NowPlayingFailure) {
          return Text(
            state.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          );
        }
        if (state is NowPlayingSuccess) {
          var nowplaying = state.nowPlayingResponse.results;
          return GridView.builder(
            itemCount: nowplaying.length,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetails(movie: nowplaying[index]),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/${nowplaying[index].posterPath}",
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
