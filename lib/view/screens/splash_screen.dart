import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie/view/screens/nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => NavScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242A32),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 3),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value,
                child: Image.asset(
                  "assests/images/popcorn 1.png",
                  width: 150,
                  height: 150,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
