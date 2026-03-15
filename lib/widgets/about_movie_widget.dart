import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view_model/about_movie/cubit/about_movie_cubit.dart';

class AboutMovieWidget extends StatelessWidget {
  const AboutMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMovieCubit, AboutMovieState>(
      builder: (context, state) {
        if (state is AboutMovieLoading) {
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
        if (state is AboutMovieFailure) {
          return Text(
            state.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        if (state is AboutMovieSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              state.aboutMovieModel.overview.toString(),

              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
