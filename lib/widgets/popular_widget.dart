import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view/screens/movie_details.dart';
import 'package:movie/view_model/popular_cubit/cubit/popular_cubit.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        if (state is PopularLoading) {
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
        if (state is PopularFailure) {
          return Text(
            state.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          );
        }
        if (state is PopularSuccess) {
          var popular = state.popularResponse.results;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3,
              crossAxisCount: 3,
            ),
            itemCount: popular.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetails(movie: popular[index]),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/${popular[index].posterPath}",
                    width: 150,
                    height: 200,
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
