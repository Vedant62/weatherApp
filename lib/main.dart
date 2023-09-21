import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}


