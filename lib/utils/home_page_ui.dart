import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/pages/error_page.dart';

import '../Model/forcast_data.dart';
import '../pages/home_page.dart';
import '../pages/weather_forcast.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class HomePageUi extends StatefulWidget {
  bool isDay = true;
  HomePageUi({Key? key, required this.isDay}) : super(key: key);

  @override
  State<HomePageUi> createState() => _HomePageUiState();
}

class _HomePageUiState extends State<HomePageUi> {
  late List<ForcastData<String>> list = [];
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  bool serviceEnabled = true;
  late Position? position;
  double latitude = 0.0;
  double longitude = 0.0;
  String desc = "____";
  String temp = "__";
  String place = "___";
  String humidity = "_";
  String feelsLike = "_";
  String visibility = "_";

  String day = "__";
  String dayName = "__";
  String maxTemp = "__";
  String minTemp = "__";
  String mainWeather = "__";
  String icons = "__";

  Future<void> _determinePosition() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.

        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      position = await Geolocator.getCurrentPosition();
      latitude = position!.latitude;
      longitude = position!.longitude;
    } on Exception catch (e) {
      setState(() {
        serviceEnabled = false;
      });
    }
  }

  void _fetchData() async {
    final _url1 =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=d38921106918a34cfac898c8945e5c55&units";
    final _url2 =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=current,hourly,minutely,alerts&appid=d38921106918a34cfac898c8945e5c55";
    final response1 = await get(Uri.parse(_url1));
    final response2 = await get(Uri.parse(_url2));
    final data1 = jsonDecode(response1.body);
    final data2 = jsonDecode(response2.body);

    print(data1);
    setState(() {
      serviceEnabled = true;
      place = data1["name"];
      temp = (data1["main"]["temp"] - 273).toInt().toString();
      desc = data1["weather"][0]["description"];
      humidity = data1["main"]["humidity"].toString();
      feelsLike = (data1["main"]["feels_like"] - 273).toInt().toString();
      visibility = (data1["visibility"] ~/ 1000).toString();
      for (int i = 1; i <= 7; i++) {
        day =
            (DateTime.fromMillisecondsSinceEpoch(data2["daily"][i]["dt"] * 1000)
                    .day)
                .toString();
        dayName = months[
            DateTime.fromMillisecondsSinceEpoch(data2["daily"][i]["dt"] * 1000)
                    .month -
                1];

        maxTemp = ((data2["daily"][i]["temp"]["max"] - 273).toInt()).toString();
        minTemp = ((data2["daily"][i]["temp"]["min"] - 273).toInt()).toString();

        mainWeather = (data2["daily"][i]["weather"][0]["description"]);
        mainWeather = mainWeather.toTitleCase();
        icons = data2["daily"][i]["weather"][0]["main"];
        list.add(ForcastData<String>(
            day, dayName, maxTemp, minTemp, mainWeather, icons));
      }
    });
  }

  @override
  void didChangeDependencies() async {
    await _determinePosition();
    if (serviceEnabled == true) {
      _fetchData();
    }
    super.didChangeDependencies();
  }

  Future<void> _onRefresh() async {
    await _determinePosition();
    _fetchData();
    setState(() {
      latitude = position!.latitude;
      longitude = position!.longitude;
    });
  }

  final PageController _controller = PageController(viewportFraction: 1);
  bool isHomePage = true;
  get chooseColor {
    if (isHomePage == true && widget.isDay == true) {
      return const Color(0xff0c1736);
    } else if (isHomePage == false && widget.isDay == true) {
      return const Color(0xffF4E3C5);
    }
    if (isHomePage == true && widget.isDay == false) {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      backgroundColor:
          widget.isDay == true ? const Color(0xffc76947) : Colors.black,
      color: widget.isDay == true ? const Color(0xffF4E3C5) : Colors.white,
      animSpeedFactor: 2,
      height: 200,
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: serviceEnabled == true
              ? Scaffold(
                  backgroundColor: chooseColor,
                  body: Column(
                    children: [
                      Flexible(
                        child: PageView(
                          onPageChanged: (index) {
                            setState(() {
                              isHomePage = !isHomePage;
                            });
                          },
                          controller: _controller,
                          children: [
                            HomePage(
                                isDay: widget.isDay,
                                desc: desc,
                                temp: temp,
                                place: place,
                                humidity: humidity,
                                feelsLike: feelsLike,
                                visibility: visibility),
                            WeatherForcast(
                              isDay: widget.isDay,
                              list: list,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: 2,
                          effect: ExpandingDotsEffect(
                            activeDotColor: widget.isDay == true
                                ? const Color(0xffc76947)
                                : Colors.white,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ErrorPage(
                  isDay: widget.isDay,
                ),
        ),
      ),
    );
  }
}
