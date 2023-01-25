import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/background/main_top.png",
    this.bottomImage = "assets/background/login_bottom.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 220,
                color: Colors.redAccent,
              ),
            ),
             Positioned(
               bottom: 0,
               right: 0,
               child: Image.asset(bottomImage, width: 120,color: Colors.redAccent,),
             ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
