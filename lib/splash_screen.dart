import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(15),
                width: size.width,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.asset(
                        "assets/splash.gif",
                        // filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                        height: 200,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
