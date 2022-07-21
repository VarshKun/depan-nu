import 'package:depan_nu/datamodels/address.dart';
import 'package:depan_nu/datamodels/directiondetails.dart';
import 'package:depan_nu/dataprovider/appdata.dart';
import 'package:depan_nu/helper/requesthelper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

class HelperMethods {
  static Future<String> findCoordinateAddress(
      Position position, context) async {
    String placeAddress = '';
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyD6BeUaj-_8YHSAricj7CrEi1xXh3m6nlg#';

    var response = await RequestHelper.getRequest(url);

    if (response != "failed") {
      placeAddress = response['results'][0]['formatted_address'];

      Address userBookingAddress = Address();
      userBookingAddress.longitude = position.longitude;
      userBookingAddress.latitude = position.latitude;
      userBookingAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updateUserBookingAddress(userBookingAddress);
    }

    return placeAddress;
  }

  static Future<String> findCoordinateAddressViaCoordinates(
      LatLng latLng, context) async {
    String placeAddress = '';
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=AIzaSyD6BeUaj-_8YHSAricj7CrEi1xXh3m6nlg#';

    var response = await RequestHelper.getRequest(url);

    if (response != "failed") {
      placeAddress = response['results'][0]['formatted_address'];

      Address closestWorkerAddress = Address();
      closestWorkerAddress.longitude = latLng.longitude;
      closestWorkerAddress.latitude = latLng.latitude;
      closestWorkerAddress.placeName = placeAddress;

      if (closestWorkerAddress.placeId!.isNotEmpty) {
        Provider.of<AppData>(context, listen: false)
            .updateClosestWorkerAddress(closestWorkerAddress);
      }
    }

    return placeAddress;
  }

  static Future<DirectionDetails?> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&alternatives=false&key=AIzaSyD6BeUaj-_8YHSAricj7CrEi1xXh3m6nlg";

    var response = await RequestHelper.getRequest(url);

    if (response == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }
}
