// @dart=2.9
import 'package:geolocator/geolocator.dart';

class GeoLocatorService{

  final geolocator = Geolocator();

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        //locationPermissionLevel: GeolocationPermission.location
    );
  }

  Future<double> getDistance(
      double startLatitude,
      double startLongitude,
      double endLatitude,
      double endLongitude) async {
    return await Geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude );
  }

  // Stream<Position> getCurrentLocation() {
  //   var locationOptions = LocationOptions(
  //       accuracy: LocationAccuracy.high, distanceFilter: 10
  //   );
  //   return Geolocator.getPositionStream(locationOptions);
  // }

  Future<Position> getInitialLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }
}