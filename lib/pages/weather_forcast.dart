import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:weather_app/utils/weather_forcast_ui.dart';

import '../Model/forcast_data.dart';

class WeatherForcast extends StatelessWidget {
  bool isDay;
  List<ForcastData<String>> list;
  WeatherForcast({
    Key? key,
    required this.isDay,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "6-Day Forecast",
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "But God knows best",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            WeatherForcastUI(
              isDay: isDay,
              list: list,
            )
          ],
        ),
      ),
    );
  }
}
