import 'package:flutter/material.dart';
import 'package:movie/utlies/hive_box.dart';
import 'package:movie/widgets/search_movie_widget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    var movies = moviesBox.values.toList();
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Watch list',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: movies.isEmpty ? _buildEmptyState() : _buildList(movies),
    );
  }

  Widget _buildList(List movies) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: movies.length,
      itemBuilder: (context, index) => SearchMovieWidget(movie: movies[index]),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A45),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.inbox_outlined,
              color: Color(0xFF7B8FFF),
              size: 44,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'There Is No Movie Yet!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Find your movie by Type title,\ncategories, years, etc',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}
