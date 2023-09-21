import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //main card
              SizedBox(

                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  elevation: 10.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('300.69K',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(height: 16,),
                            Icon(Icons.cloud, size: 64.0,),
                            const SizedBox(height: 16,),
                            Text('Rain', style: TextStyle(fontSize: 20, ))

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Weather Forecast', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Padding
                (
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 120,
                        child: HourlyForecastItem(),
                      ),
                      SizedBox(
                        width: 100,
                        height: 120,
                        child: HourlyForecastItem(),
                      ),

                      SizedBox(
                        width: 100,
                        height: 120,
                        child: HourlyForecastItem(),
                      ),
                      SizedBox(
                        width: 100,
                        height: 120,
                        child: HourlyForecastItem(),
                      ),
                      SizedBox(
                        width: 100,
                        height: 120,
                        child: HourlyForecastItem(),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Additional Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround , // very useful
                children: [
                  Column(
                    children: [
                      Icon(Icons.water_drop, size: 32,),
                      const SizedBox(height: 10),
                      Text('Humidity'),
                        const SizedBox(height: 10),
                      Text('91', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.air_rounded, size: 32,),
                      const SizedBox(height: 10),
                      Text('Wind Speed'),
                      const SizedBox(height: 10),
                      Text('8.34', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.beach_access_rounded, size: 32,),
                      const SizedBox(height: 10),
                      Text('Pressure'),
                      const SizedBox(height: 10),
                      Text('1006', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              )


              // weather forecast cards


            ]
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Weather App 你好"),
        titleTextStyle: const TextStyle(textBaseline: TextBaseline.ideographic),
        centerTitle: true,
        actions:  [
          // Inkwell and GestureDetector can also be used for this purpose
          IconButton(onPressed: (){print("refresh");}, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
    );

  }
}
class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text('9:00'),
          SizedBox(height: 10,),
          Icon(Icons.cloud, size: 30,),
          SizedBox(height: 10,),
          Text('300.01K'),
        ],
      ),
    );
  }
}


