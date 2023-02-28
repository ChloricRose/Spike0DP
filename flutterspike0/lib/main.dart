import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewModel/weather_viewModel.dart';
import 'view/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherViewModel(),
      child: MaterialApp(
        title: 'MVVM Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}