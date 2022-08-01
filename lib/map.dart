import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
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
  // ignore: prefer_final_fields
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  late Position currentPosition;
  Set<Marker> _markers = {};
  // ignore: prefer_final_fields
  Set<Circle> _circles = {};
  List<dynamic> workersAvailableLocation = [];
  // ignore: prefer_final_fields
  List<Polyline> _polylines = [];
  //var workersAvailableLocation = <double, double>{};
  double distanceinKM = 0;
  BitmapDescriptor? currentWorkersServingIcon;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

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
          createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/images/icons/workerIcon1.png")
          .then((icon) {
        currentWorkersServingIcon = icon;
      });
    }
  }

  Future<void> getWorkerLocations() async {
    DatabaseReference workers = FirebaseDatabase.instance.ref('workers');
    // ignore: prefer_collection_literals
    Set<Marker> tempMarkers = Set<Marker>();
    PolylinePoints polylinePoints = PolylinePoints();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng currentPos = LatLng(position.latitude, position.longitude);

    workers.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map;
      // ignore: avoid_print
      print('WORKERS: $data');
      data.forEach((key, value) async {
        /*ADDING MARKERS ACCORDING TO THE ONES SERVING YOU */
        if (value["serving"] == user.email) {
          String workerName = value["fullname"];
          LatLng workerLocation =
              LatLng(value["location"]["lat"], value["location"]["long"]);
          Marker thisMarker = Marker(
              markerId: MarkerId(workerName),
              position: workerLocation,
              icon: currentWorkersServingIcon!,
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                  Container(
                    // height: 100,
                    // width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Worker name : $workerName',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xff020435),
                                fontSize: 14,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              'Phone No : ${value["phone"]}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xff020435),
                                fontSize: 14,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Center(
                            child: Text(
                              'Serving status : In progress',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff020435),
                                fontSize: 14,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  workerLocation,
                );
              });
          tempMarkers.removeWhere(
              (element) => element.markerId == thisMarker.markerId);
          tempMarkers.add(thisMarker);
          /*polyline drawing */
          var thisDetails = await HelperMethods.getDirectionDetails(
              currentPos, workerLocation);
          // ignore: avoid_print
          print(thisDetails?.encodedPoints);

          List<PointLatLng> results =
              polylinePoints.decodePolyline(thisDetails!.encodedPoints ?? '');

          List<LatLng> polylineCoordinates = [];

          if (results.isNotEmpty) {
            // ignore: avoid_function_literals_in_foreach_calls
            results.forEach((PointLatLng points) {
              polylineCoordinates
                  .add(LatLng(points.latitude, points.longitude));
            });
          }
          //_polylines.clear();
          setState(() {
            Polyline polyline = Polyline(
              polylineId: PolylineId(workerName),
              color: Colors.green,
              points: polylineCoordinates,
              jointType: JointType.round,
              width: 4,
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
              geodesic: true,
            );
            _polylines.removeWhere(
                (element) => element.polylineId == polyline.polylineId);
            _polylines.add(polyline);
          });
        } else if (value["serving"] == "none") {
          String workerName = value["fullname"];

          tempMarkers.removeWhere(
              (element) => element.markerId == MarkerId(workerName));

          _polylines.removeWhere(
              (element) => element.polylineId == PolylineId(workerName));
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
    // ignore: unused_local_variable
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
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              //pass instance of controller when map is created -> enables to make changes in gmap
              _controller.complete(controller);
              _customInfoWindowController.googleMapController = controller;
              mapController = controller;
              setupPositionLocation();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 100,
            width: 200,
            offset: 100,
          )
        ],
      ),
    );
  }
}
