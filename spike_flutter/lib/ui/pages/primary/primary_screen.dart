import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:spike_test/constants.dart';

/* List places = ["Artana", "Castellón", "Vila-real", "Valencia", "Alicante"]; */

/* 
  {
    "name":"name",
    "temp":"temp"
  }
 */

/* A list of objects of cities that contains a parameter with the name and the temperature */
/* List places = [
  {"name": "Artana", "temp": "12"},
  {"name": "Castellón", "temp": "12"},
  {"name": "Vila-real", "temp": "12"},
  {"name": "Valencia", "temp": "12"},
  {"name": "Alicante", "temp": "12"},
]; */

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  Map<String, dynamic> tempCs = {"name": "Castellón", "temp": ""};

  Future<void> getTemp() async {
    http.get(Uri.parse("$API/getTemp?lat=39.98567&lon=-0.04935")).then((r) {
      dynamic data = jsonDecode(r.body);
      setState(() {
        tempCs["temp"] = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTemp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WeatherApp"),
        /* remove back button */
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  title: Text(tempCs["name"]),
                  trailing: Text(
                    "Temp: ${tempCs["temp"]}º",
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
              /* SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: Text(
                        "${place["name"]}",
                        textAlign: TextAlign.center,
                      ),
                      trailing: Text(
                        "Temp: ${place["temp"]}º",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    );
                  },
                  /* childCount: places.length, */
                  childCount: 1,
                ),
              ) */
            ],
          ),
        ),
      ),
    );
  }
}
