import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:where_is_my_car/Cars/ListCarScreen/Views/Widgets/carCard.dart';
import 'package:where_is_my_car/Cars/NewCar/Views/Screens/newCarScreen.dart';
import 'package:where_is_my_car/constants.dart';

class ListCarsScreen extends StatelessWidget {
  const ListCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* Create a body with slivers */
      backgroundColor: bgColor,
      /* Insert a floating action button with different actions */
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* Navigate to the add car screen */
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewCarScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        right: false,
        left: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Mis coches",
                    textAlign: TextAlign.center,
                    style: primaryTitleStyle,
                  ),
                ),
              ),
              /* Create a sliver list */
              SliverList(
                /* Set the delegate */
                delegate: SliverChildBuilderDelegate(
                  /* Set the builder */
                  (context, index) {
                    /* Return a list tile */
                    return CarCard();
                  },
                  /* Set the child count */
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
