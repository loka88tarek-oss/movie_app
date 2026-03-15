import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view_model/reviews_/cubit/reviews_cubit.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoading) {
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
        if (state is ReviewsFailure) {
          return Text(
            state.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          );
        }
        if (state is ReviewsSuccess) {
          var review = state.movieReviewsModel.results;
          return ListView.separated(
            itemBuilder: (context, index) {
              var reviews = review[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF3A3A5C),
                    backgroundImage: reviews.authorDetails?.avatarPath != null
                        ? NetworkImage(
                            "https://image.tmdb.org/t/p/w500/${reviews.authorDetails?.avatarPath}",
                          )
                        : null,
                    child: reviews.authorDetails?.avatarPath == null
                        ? Text(
                            reviews.author!.isNotEmpty
                                ? reviews.author![0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reviews.author.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (reviews.authorDetails!.rating != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2A2A45),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  reviews.authorDetails!.rating.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF7B8FFF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          reviews.content.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemCount: review!.length,
          );
        }
        return SizedBox();
      },
    );
  }
}

// widget tree
/*
ReviewsWidget
│
└── BlocBuilder<ReviewsCubit, ReviewsState>
    │
    ├── ReviewsLoading
    │   └── Center
    │       └── CircularProgressIndicator
    │
    ├── ReviewsFailure
    │   └── Text (error message)
    │
    ├── ReviewsSuccess
    │   └── ListView.separated
    │       │
    │       ├── separatorBuilder
    │       │   └── SizedBox (height: 16)  👈 gap between reviews
    │       │
    │       └── itemBuilder  (repeated for each review)
    │           └── Row (crossAxisAlignment: start)
    │               │
    │               ├── CircleAvatar
    │               │   ├── backgroundImage: NetworkImage  👈 if avatar exists
    │               │   └── child: Text (first letter)     👈 if no avatar
    │               │
    │               ├── SizedBox (width: 12)
    │               │
    │               └── Expanded
    │                   └── Column (crossAxisAlignment: start)
    │                       │
    │                       ├── Row (spaceBetween)
    │                       │   ├── Text (author name)
    │                       │   └── Container  👈 rating badge (only if rating != null)
    │                       │       └── Text (rating number)
    │                       │
    │                       ├── SizedBox (height: 4)
    │                       │
    │                       └── Text (review content, maxLines: 3)
    │
    └── SizedBox()  👈 fallback if no state matched
    */
