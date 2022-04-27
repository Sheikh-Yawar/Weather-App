import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/forcast_data.dart';

class WeatherForcastUI extends StatelessWidget {
  bool isDay;
  List<ForcastData<String>> list;
  WeatherForcastUI({Key? key, required this.isDay, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: ((context, index) => Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 5,
            ),
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: isDay == true ? Colors.white : const Color(0xff544F63),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                            height: 60,
                            width: 60,
                            color: isDay == true
                                ? const Color(0xffc76947)
                                : Colors.white,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    list[index].day!,
                                    style: GoogleFonts.montserrat(
                                      color: isDay == true
                                          ? const Color(0xff0c1736)
                                          : Colors.black,
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    list[index].dayName!,
                                    style: TextStyle(
                                      color: isDay == true
                                          ? const Color(0xff0c1736)
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Max Temp: ${list[index].maxTemp!}",
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Min Temp: ${list[index].minTemp!}",
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            list[index].desc!,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        getImage(list[index].icon),
                        fit: BoxFit.contain,
                        scale: 0.5,
                        height: 60,
                        width: 60,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  String getImage(String? icon) {
    if (icon == "Rain" ||
        icon == "Snow" ||
        icon == 'Clouds' ||
        icon == 'Clear') {
      return "assets/icons/$icon.png";
    }
    return "assets/images/app_icon.png";
  }
}
