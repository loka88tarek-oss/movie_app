import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view/screens/movie_details.dart';
import 'package:movie/view/screens/search.dart';
import 'package:movie/view_model/home/cubit/home_cubit.dart';
import 'package:movie/view_model/now_playing_cubit/cubit/now_playing_cubit.dart';
import 'package:movie/view_model/popular_cubit/cubit/popular_cubit.dart';
import 'package:movie/view_model/search_cubit/cubit/search_cubit.dart';
import 'package:movie/view_model/top_rated_cubit/cubit/top_rated_cubit.dart';
import 'package:movie/view_model/up_coming_cubit/cubit/up_coming_cubit.dart';
import 'package:movie/widgets/now_playing_card.dart';
import 'package:movie/widgets/popular_widget.dart';
import 'package:movie/widgets/top_rated_widget.dart';
import 'package:movie/widgets/up_coming_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().getHomeCarousel();
    super.initState();
  }

  double rating = 0;

  TextEditingController? get controller => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242A32),
      appBar: AppBar(
        backgroundColor: Color(0xff242A32),
        title: Center(
          child: Text(
            "What do you want to watch?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TextFormField(
                controller: controller,

                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SearchCubit(),
                        child: Search(),
                      ),
                    ),
                  );
                },

                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search_outlined),
                  fillColor: Color(0xff67686D),
                  filled: true,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 83, 83, 83),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 24),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is Homeloading) {
                    return CircularProgressIndicator();
                  }
                  if (state is HomeFailure) {
                    return Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                  if (state is HomeSucess) {
                    var movies = state.movies.results;
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 0.4,
                        enlargeCenterPage: true,
                      ),
                      itemCount: movies.length,
                      itemBuilder:
                          (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetails(movie: movies[itemIndex]),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(16),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/${movies[itemIndex].posterPath}",
                                height: 200,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    );
                  }
                  return SizedBox(height: 10);
                },
              ),
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                tabs: [
                  Tab(text: "Now playing"),
                  Tab(text: "Upcoming"),
                  Tab(text: "Top rated"),
                  Tab(text: "Popular"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    BlocProvider(
                      create: (context) =>
                          NowPlayingCubit()..getNowPlayingMovies(),
                      child: NowPlayingTab(),
                    ),
                    BlocProvider(
                      create: (context) => UpComingCubit()..getUpComing(),
                      child: UpComingWidget(),
                    ),
                    BlocProvider(
                      create: (context) => TopRatedCubit()..getTopRated(),
                      child: TopRatedWidget(),
                    ),

                    BlocProvider(
                      create: (context) => PopularCubit()..getPopular(),
                      child: PopularWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
