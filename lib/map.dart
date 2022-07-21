import 'dart:async';
import 'package:depan_nu/helper/helpermethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final user = FirebaseAuth.instance.currentUser!;
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  late Position currentPosition;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  List<dynamic> workersAvailableLocation = [];

  List<Polyline> _polylines = [];
  //var workersAvailableLocation = <double, double>{};
  double distanceinKM = 0;
  BitmapDescriptor? currentWorkersServingIcon;

  // ignore: prefer_const_declarations
  static final CameraPosition _kCapital = const CameraPosition(
    target: LatLng(
      -20.160701448903378,
      57.501004185581,
    ),
    zoom: 14.4746,
  );

  void createMarker() {
    // ignore: unnecessary_null_comparison
    if (currentWorkersServingIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(5, 5));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/images/icons/workerIcon.png")
          .then((icon) {
        currentWorkersServingIcon = icon;
      });
    }
  }

  Future<void> getWorkerLocations() async {
    DatabaseReference workers = FirebaseDatabase.instance.ref('workers');
    Set<Marker> tempMarkers = Set<Marker>();
    PolylinePoints polylinePoints = PolylinePoints();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng currentPos = LatLng(position.latitude, position.longitude);

    workers.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map;
      print('WORKERS: $data');
      var polycounter = 0;
      data.forEach((key, value) async {
        /*ADDING MARKERS ACCORDING TO THE ONES SERVING YOU */
        if (value["serving"] == user.email) {
          polycounter++;
          String workerName = value["fullname"];
          LatLng workerLocation =
              LatLng(value["location"]["lat"], value["location"]["long"]);
          Marker thisMarker = Marker(
            markerId: MarkerId(workerName),
            position: workerLocation,
            icon: currentWorkersServingIcon!,
          );
          tempMarkers.removeWhere(
              (element) => element.markerId == thisMarker.markerId);
          tempMarkers.add(thisMarker);

          var thisDetails = await HelperMethods.getDirectionDetails(
              currentPos, workerLocation);
          print(thisDetails?.encodedPoints);

          List<PointLatLng> results =
              polylinePoints.decodePolyline(thisDetails!.encodedPoints ?? '');

          List<LatLng> polylineCoordinates = [];

          if (results.isNotEmpty) {
            results.forEach((PointLatLng points) {
              polylineCoordinates
                  .add(LatLng(points.latitude, points.longitude));
            });

            // for (var points in results) {
            //   polylineCoordinates
            //       .add(LatLng(points.latitude, points.longitude));
            // }
          }
          //_polylines.clear();
          setState(() {
            Polyline polyline = Polyline(
              polylineId: PolylineId('polyid$polycounter'),
              color: Colors.green,
              points: polylineCoordinates,
              jointType: JointType.round,
              width: 4,
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
              geodesic: true,
            );

            _polylines.add(polyline);
            polycounter++;
          });
        } else if (value["serving"] == "none") {
          String workerName = value["fullname"];
          LatLng workerLocation =
              LatLng(value["location"]["lat"], value["location"]["long"]);
          Marker thisMarker = Marker(
            markerId: MarkerId(workerName),
            position: workerLocation,
            icon: currentWorkersServingIcon!,
          );
          tempMarkers.removeWhere(
              (element) => element.markerId == thisMarker.markerId);
        }

        /*ADDING MARKERS ACCORDING TO NEARBY WORKERS */
        // if (value["serving"] == "none") {
        //   print(value["location"]);
        //   //workersAvailableLocation.addAll(value["location"]);
        //   double distanceInM = Geolocator.distanceBetween(
        // value["location"]["lat"],
        // value["location"]["long"],
        // currentPosition.latitude,
        // currentPosition.longitude,
        //   );
        //   distanceinKM = distanceInM / 1000;
        //   print('Distance: $distanceinKM');
        //   if (distanceinKM <= 6) {
        //     LatLng workerLocation =
        //         LatLng(value["location"]["lat"], value["location"]["long"]);
        //     Marker thisMarker = Marker(
        //       markerId: MarkerId('worker$counter'),
        //       position: workerLocation,
        //       icon: BitmapDescriptor.defaultMarkerWithHue(
        //           BitmapDescriptor.hueGreen),
        //     );
        //     tempMarkers.add(thisMarker);
        //     counter++;
        //     //workersAvailableLocation.add(value["location"]);
        //   }
        // }
      });

      setState(() {
        _markers = tempMarkers;
      });
      //data.forEach((k, v) => print(v["location"]["lat"]));
    });
  }

  void setupPositionLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = CameraPosition(target: pos, zoom: 12);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    createMarker();
    getWorkerLocations();
  }

  @override
  Widget build(BuildContext context) {
    //createMarker();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            //padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kCapital,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: _markers,
            circles: _circles,
            polylines: _polylines.toSet(),
            onMapCreated: (GoogleMapController controller) {
              //pass instance of controller when map is created -> enables to make changes in gmap
              _controller.complete(controller);
              mapController = controller;
              setupPositionLocation();
            },
          ),
        ],
      ),
    );
  }
}
