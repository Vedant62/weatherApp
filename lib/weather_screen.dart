import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';



class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String,dynamic>> weather;
  @override



  Future<Map<String,dynamic>> getCurrentWeather() async {

    String cityName = 'Chennai';
    try {
      final res = await http.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'
          )
      ); //this api call from the internet is gonna take time
      final data = jsonDecode(res.body);

      if (data['cod']!='200'){
        throw data['message']; // terminates the function at this point
      }
      return data;
      // print(res.body);
    } catch (e) {
      // TODO
      throw e.toString();
    }

  }
  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }
  @override
  Widget build(BuildContext context) { //build function should be kept away from async stuff
    return  Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            print(snapshot);
            print(snapshot.runtimeType);
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: const CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            final data = snapshot.data!;
            final currentWeatherData = data['list'][0];
            final currentTemp = currentWeatherData['main']['temp'];
            final currentSky = currentWeatherData['weather'][0]['main'];
            final currentPressure = currentWeatherData['main']['pressure'];
            final currentWindSpeed = currentWeatherData['wind']['speed'];
            final currentHumidity = currentWeatherData['main']['humidity'];
            return Padding(
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
                              Text('$currentTemp K',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),),
                              const SizedBox(height: 16,),
                              // Icon(currentSky == 'Clouds'|| currentSky == 'Rain'?Icons.cloud: Icons.sunny, size: 64.0,),
                              Icon(currentSky == 'Clouds'? Icons.cloud: currentSky == 'Rain'?Icons.cloudy_snowing: Icons.sunny, size: 64.0,),
                              const SizedBox(height: 16,),
                              Text('$currentSky', style: TextStyle(fontSize: 20, ))

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text('Hourly Forecast', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Padding
                  (
                  padding: const EdgeInsets.all(8.0),
                  child:
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i<=5; i++)
                  //         HourlyForecastItem(
                  //           time: data['list'][i + 1]['dt'].toString(),
                  //           icon: data['list'][i + 1]['weather'][0]['main'] == 'Clouds' || data['list'][i + 1]['weather'][0]['main'] == 'Rain'? Icons.cloud: Icons.sunny,
                  //           temperature: data['list'][i + 1]['main']['temp'].toString(),
                  //         )
                  //
                  //     ],
                  //   ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final time = DateTime.parse(hourlyForecast['dt_txt'].toString());
                          return HourlyForecastItem(
                              time: DateFormat.j().format(time),
                              temperature: hourlyForecast['main']['temp'].toString(),
                              icon: hourlyForecast['weather'][0]['main'] == 'Clouds'? Icons.cloud: hourlyForecast['weather'][0]['main'] == 'Rain'? Icons.cloudy_snowing :Icons.sunny,
                          );

                        }
                    ),
                  )
                  ),
                // ),
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
                        Text('$currentHumidity', style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.air_rounded, size: 32,),
                        const SizedBox(height: 10),
                        Text('Wind Speed'),
                        const SizedBox(height: 10),
                        Text('$currentWindSpeed', style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.beach_access_rounded, size: 32,),
                        const SizedBox(height: 10),
                        Text('Pressure'),
                        const SizedBox(height: 10),
                        Text('$currentPressure', style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                )


                // weather forecast cards


              ]
            ),
          );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text("Weather App 你好"),
        titleTextStyle: const TextStyle(textBaseline: TextBaseline.ideographic),
        centerTitle: true,
        actions:  [
          // Inkwell and GestureDetector can also be used for this purpose
          IconButton(onPressed: (){setState(() {weather = getCurrentWeather();});}, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
    );

  }
}
class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem({super.key, required this.time, required this.temperature, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 100,
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text(time, maxLines: 1,overflow: TextOverflow.ellipsis),
            SizedBox(height: 10,),
            Icon(icon),
            SizedBox(height: 10,),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}


