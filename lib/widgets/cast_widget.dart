import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/view_model/cast/cubit/cast_cubit.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastCubit, CastState>(
      builder: (context, state) {
        if (state is CastLoading) {
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
        if (state is CastFailure) {
          return Text(
            state.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        if (state is CastSuccess) {
          var cast = state.castResponse.cast;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 3,
            ),

            itemCount: cast.length,
            itemBuilder: (context, index) {
              var member = cast[index];
              return Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: member.profilePath != null
                          ? Image.network(
                              "https://image.tmdb.org/t/p/w500/${member.profilePath}",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Color(0xFF3A3A5C),
                              alignment: Alignment.center,
                              child: Text(
                                member.name.isNotEmpty
                                    ? member.name[0].toUpperCase()
                                    : "?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    member.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    member.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ],
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
