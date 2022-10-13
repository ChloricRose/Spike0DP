import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:latlong2/latlong.dart';

@JsonSerializable()
class Car {
  String license = "";
  String brand = "";
  String model = "";
  String lastUpdate = "";
  dynamic image;
  LatLng? position = LatLng(0, 0);
  /* Create the constructor with optional parameters */
  Car({
    this.license = "",
    this.brand = "",
    this.model = "",
    this.lastUpdate = "",
    this.image = "",
    this.position,
  });

  /* Constructor from JSON object */
  Car.fromJson(Map<String, dynamic> json) {
    license = json['license'];
    brand = json['brand'];
    model = json['model'];
    lastUpdate = json['lastUpdate'];
    image = json['image'];
    position =
        LatLng(json['position']['latitude'], json['position']['longitude']);
  }

  /* Convert the object to a JSON object */
  Map<String, dynamic> toJson() {
    return {
      "license": license,
      "brand": brand,
      "model": model,
      "lastUpdate": lastUpdate,
      "image": image,
      "position": {
        "latitude": position!.latitude,
        "longitude": position!.longitude,
      }
    };
  }
}
