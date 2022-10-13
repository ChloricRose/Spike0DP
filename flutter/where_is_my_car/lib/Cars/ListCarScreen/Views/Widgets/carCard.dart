import 'package:flutter/material.dart';
import 'package:where_is_my_car/constants.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return myAnimation(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80, maxHeight: 180),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 8,
                  blurRadius: 8,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Flexible(
                            child: Text(
                              "6553APL",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 61, 218, 1),
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "Mercedes",
                              style: TextStyle(
                                color: Color.fromRGBO(67, 67, 67, 1),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "6553APL",
                              style: TextStyle(
                                color: Color.fromRGBO(67, 67, 67, 1),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Flexible(
                        child: Text("Actualizado el 10/9/22"),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: AspectRatio(
                    /* aspectRatio: 16 / 9, */
                    aspectRatio: 5 / 4,
                    /* aspectRatio: 1/1, */
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/mercedes.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
