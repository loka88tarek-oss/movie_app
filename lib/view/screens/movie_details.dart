import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/model/movie_model.dart';
import 'package:movie/utlies/hive_box.dart';
import 'package:movie/view_model/about_movie/cubit/about_movie_cubit.dart';
import 'package:movie/view_model/cast/cubit/cast_cubit.dart';
import 'package:movie/view_model/reviews_/cubit/reviews_cubit.dart';
import 'package:movie/widgets/about_movie_widget.dart';
import 'package:movie/widgets/cast_widget.dart';
import 'package:movie/widgets/review_widget.dart';

class MovieDetails extends StatefulWidget {
  final TmdbMovie movie;

  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    // to make responsive UI
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff242A32),
      appBar: AppBar(
        backgroundColor: Color(0xff242A32),
        title: Text(
          "Dtails",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              moviesBox.containsKey(widget.movie.id)
                  ? moviesBox.delete(widget.movie.id)
                  : moviesBox.put(widget.movie.id, widget.movie);
              setState(() {});
            },
            child: Icon(
              moviesBox.containsKey(widget.movie.id)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              size: 32,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.38,
              child: Stack(
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500/${widget.movie.backdropPath}",
                  ),
                  Positioned(
                    bottom: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(16),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}",
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 18),
                          Column(
                            children: [
                              SizedBox(height: screenHeight * 0.125),
                              Text(
                                widget.movie.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today_rounded, color: Color(0xff92929D)),
                SizedBox(width: 10),
                Text(
                  widget.movie.releaseDate.year.toString(),
                  style: TextStyle(color: Color(0xff92929D)),
                ),
                SizedBox(
                  height: 24,
                  child: VerticalDivider(color: Color(0xff92929D)),
                ),
                /////////////////////
                Icon(Icons.watch_later_outlined, color: Color(0xff92929D)),
                SizedBox(width: 10),
                Text(
                  widget.movie.voteCount.toString(),
                  style: TextStyle(color: Color(0xff92929D)),
                ),
                SizedBox(
                  height: 24,
                  child: VerticalDivider(color: Color(0xff92929D)),
                ),
                /////////////
                Icon(Icons.language_outlined, color: Color(0xff92929D)),
                SizedBox(width: 10),
                Text(
                  widget.movie.originalLanguage,
                  style: TextStyle(color: Color(0xff92929D)),
                ),
              ],
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 18.0),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorColor: Color(0xff92929D),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,

                tabs: [
                  Tab(text: "About Movie"),
                  Tab(text: "Reviews"),
                  Tab(text: "Cast"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BlocProvider(
                    create: (context) =>
                        AboutMovieCubit()..getAboutMovie(widget.movie.id),
                    child: AboutMovieWidget(),
                  ),
                  ////////////
                  BlocProvider(
                    create: (context) =>
                        ReviewsCubit()..getReview(widget.movie.id),
                    child: ReviewWidget(),
                  ),

                  ///////////
                  BlocProvider(
                    create: (context) => CastCubit()..getCast(widget.movie.id),
                    child: CastWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
