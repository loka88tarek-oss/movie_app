import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view/screens/movie_details.dart';
import 'package:movie/view_model/search_cubit/cubit/search_cubit.dart';
import 'package:movie/widgets/search_movie_widget.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242A32),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Search", style: TextStyle(color: Colors.white)),

        backgroundColor: Color(0xff242A32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                context.read<SearchCubit>().search(value);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search_outlined),
                fillColor: Color(0xff67686D),
                filled: true,
                hintText: "Search",
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 71, 71, 73),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                print(state);
                if (state is SearchLoading) {
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
                              valueColor: AlwaysStoppedAnimation(
                                Color(0xFF7B8FFF),
                              ),
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
                if (state is SearchSucess) {
                  if (state.searchResponseModel.results.isEmpty) {
                    return Expanded(child: _notFoundResult());
                  }
                  return Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ListView.builder(
                        itemCount: state.searchResponseModel.results.length,
                        itemBuilder: (context, index) {
                          var searchmovie =
                              state.searchResponseModel.results[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetails(movie: searchmovie),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                SearchMovieWidget(movie: searchmovie),
                                SizedBox(height: 12),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return Expanded(child: _notFoundResult());
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _notFoundResult() {
  return Center(
    child: Column(
      children: [
        Image.asset("assests/images/Group (3).png", width: 100, height: 100),
        SizedBox(height: 24),
        Text(
          "We Are Sorry, We Can\nNot Find The Movie :(",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Find your movie by Type title,\ncategories, years, etc",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white38,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
