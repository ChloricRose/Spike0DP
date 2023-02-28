import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../model/weather_model.dart';
import '../viewModel/weather_viewModel.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MVVM Weather App'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final viewModel =
                            Provider.of<WeatherViewModel>(context,
                                listen: false);
                        final location = _controller.text;

                        try {
                          await viewModel.getWeather(location);
                          final weather = viewModel.weather!;

                          _showWeatherDialog(context, weather);
                        } catch (e) {
                          _showErrorDialog(context, e.toString());
                        }
                      }
                    },
                    child: const Text('Get weather'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showWeatherDialog(BuildContext context, WeatherModel weather) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Weather for ${_controller.text}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Temperature: ${weather.temperature}°C'),
            const SizedBox(height: 8.0),
            Text('Precipitation: ${weather.precipitation}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}