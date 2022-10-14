import 'package:flutter/material.dart';

List places = ["Artana", "Castellón", "Vila-real", "Valencia", "Alicante"];

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WeatherApp"),
        /* remove back button */
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
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
              /* Sliver generator */
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: Text(
                        "${places[index]}: 20º",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  childCount: places.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
