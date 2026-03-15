import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view/screens/fav_screen.dart';
import 'package:movie/view/screens/home.dart';
import 'package:movie/view/screens/search.dart';
import 'package:movie/view_model/home/cubit/home_cubit.dart';
import 'package:movie/view_model/search_cubit/cubit/search_cubit.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit(),
      child: MyHomePage(title: "movie_app"),
    ),
    BlocProvider(create: (context) => SearchCubit(), child: Search()),
    FavScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          print(value);
          currentIndex = value;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: " "),
        ],

        backgroundColor: Color(0xff242A32),
      ),
    );
  }
}
