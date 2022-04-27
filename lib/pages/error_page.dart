import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatefulWidget {
  bool isDay;
  ErrorPage({Key? key, required this.isDay}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lottieController;
  @override
  void initState() {
    _lottieController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/images/sleeping.json",
            controller: _lottieController,
            onLoaded: (composition) {
              _lottieController
                ..duration = composition.duration
                ..forward()
                ..repeat();
            },
          ),
          FittedBox(
            child: Text(
              "Something Went Wrong!",
              style: TextStyle(
                fontSize: 26,
                color: widget.isDay == true
                    ? const Color(0xff0c1736)
                    : Colors.white,
              ),
            ),
          ),
          FittedBox(
            child: Text(
              "Please try again",
              style: TextStyle(
                fontSize: 22,
                color: widget.isDay == true
                    ? const Color(0xff0c1736)
                    : Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
