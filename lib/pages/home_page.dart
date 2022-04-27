import 'package:flutter/material.dart';
import 'package:weather_app/utils/glass_morphism.dart';

class HomePage extends StatelessWidget {
  late bool isDay;
  String desc;
  String temp;
  String place;
  String humidity;
  String feelsLike;
  String visibility;
  HomePage(
      {Key? key,
      required this.isDay,
      required this.desc,
      required this.temp,
      required this.place,
      required this.humidity,
      required this.feelsLike,
      required this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isDay == true
              ? const AssetImage("assets/images/DayImage.jpg")
              : const AssetImage("assets/images/NightImage.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 70,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      place,
                      style: const TextStyle(fontSize: 34),
                    ),
                    Row(
                      children: [
                        Text(
                          temp,
                          style: const TextStyle(
                            fontSize: 115,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 60.0),
                          child: Text(
                            "°",
                            style: TextStyle(
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 4.0,
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        desc,
                        style: const TextStyle(
                            fontSize: 23,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GlassBox(
              height: 80.0,
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$humidity%",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Humidity",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$feelsLike°",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Feels Like",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$visibility km",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "visibility",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
