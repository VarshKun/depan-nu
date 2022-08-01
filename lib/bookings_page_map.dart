import 'dart:async';
import 'dart:collection';
import 'package:alan_voice/alan_voice.dart';
import 'package:depan_nu/datamodels/address.dart';
import 'package:depan_nu/dataprovider/appdata.dart';
import 'package:depan_nu/helper/helpermethods.dart';
import 'package:depan_nu/payment.dart';
import 'package:depan_nu/searchpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:line_awesome_icons/line_awesome_icons.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:brand_colors/brand_colors.dart';
import 'package:provider/provider.dart';
import 'globalvariables.dart' as globals;

class BookingsMapPage extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static _BookingsMapPageState? instance;
  const BookingsMapPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookingsMapPageState createState() => _BookingsMapPageState();
}

class _BookingsMapPageState extends State<BookingsMapPage> {
  _BookingsMapPageState() {
    BookingsMapPage.instance = this;
  }

  final user = FirebaseAuth.instance.currentUser!;
  double mapPaddingBottom = 0;
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
  BitmapDescriptor? workersAvailableIcon;
  Map<LatLng, double> closestWorkersList = {};
  double searchSheetHeight = 280;
  double confirmBookingSheetHeight = 0;
  bool invisible = false;

  // ignore: prefer_const_declarations
  static final CameraPosition _kCapital = const CameraPosition(
    target: LatLng(
      -20.160701448903378,
      57.501004185581,
    ),
    zoom: 14.4746,
  );

  void makePayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentsPage(),
      ),
    );
  }

  void searchLocation() async {
    var response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage(),
      ),
    );

    if (response == 'getDirection') {
      showDetailsSheet();
    }
  }

  void createMarker() {
    // ignore: unnecessary_null_comparison
    if (workersAvailableIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(4, 4));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/images/icons/workerIcon1.png")
          .then((icon) {
        workersAvailableIcon = icon;
      });
    }
  }

  void showDetailsSheet() async {
    await getDirection();
    setState(() {
      searchSheetHeight = 0;
      confirmBookingSheetHeight = 320;
      mapPaddingBottom = 300;
    });
  }

  Future<void> getWorkerName() async {
    DatabaseReference workers = FirebaseDatabase.instance.ref('workers');
    workers.onValue.listen((DatabaseEvent event) async {
      final data = event.snapshot.value as Map;
      data.forEach((key, value) async {
        if (value['location']['lat'] ==
                globals.closestWorkerCoordinate.latitude &&
            value['location']['long'] ==
                globals.closestWorkerCoordinate.longitude) {
          globals.closestWorkerName = value['fullname'];
          globals.closestWorkerID = value['id'];
        }
      });
    });
  }

  void setTextWidgetState() {
    if (globals.categorySelected == "Salon") {
      invisible = true;
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

    workers.onValue.listen((DatabaseEvent event) async {
      final data = event.snapshot.value as Map;
      // ignore: avoid_print
      print('WORKERS: $data');
      data.forEach((key, value) async {
        /*ADDING MARKERS ACCORDING TO NEARBY WORKERS */
        if (value["serving"] == "none") {
          if (value["industry"] == globals.categorySelected) {
            // ignore: avoid_print
            print(value["location"]);
            //workersAvailableLocation.addAll(value["location"]);
            double distanceInM = Geolocator.distanceBetween(
              value["location"]["lat"],
              value["location"]["long"],
              currentPosition.latitude,
              currentPosition.longitude,
            );
            distanceinKM = distanceInM / 1000;
            // ignore: avoid_print
            print('Distance: $distanceinKM');
            if (distanceinKM <= 20) {
              LatLng workerLocation =
                  LatLng(value["location"]["lat"], value["location"]["long"]);

              String workerName = value["fullname"];

              closestWorkersList.putIfAbsent(
                  workerLocation, () => distanceinKM);

              Marker thisMarker = Marker(
                markerId: MarkerId(workerName),
                position: workerLocation,
                icon: workersAvailableIcon!,
              );
              tempMarkers.removeWhere(
                  (element) => element.markerId == thisMarker.markerId);
              tempMarkers.add(thisMarker);
              /*POLYLINES */
              var thisDetails = await HelperMethods.getDirectionDetails(
                  currentPos, workerLocation);
              // ignore: avoid_print
              print(thisDetails?.encodedPoints);

              List<PointLatLng> results = polylinePoints
                  .decodePolyline(thisDetails!.encodedPoints ?? '');

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
            }
          }
        } else if (value["serving"] != "none") {
          String workerName = value["fullname"];
          double lat = value["location"]["lat"];
          double long = value["location"]["long"];

          tempMarkers.removeWhere(
              (element) => element.markerId == MarkerId(workerName));

          _polylines.removeWhere(
              (element) => element.polylineId == PolylineId(workerName));

          closestWorkersList
              .removeWhere((key, value) => key == LatLng(lat, long));
        }
      });

      if (closestWorkersList.keys.isNotEmpty) {
        var sortedKeys = closestWorkersList.keys.toList(growable: false)
          ..sort(
            (k1, k2) =>
                closestWorkersList[k1]!.compareTo(closestWorkersList[k2]!),
          );
        LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
            key: (k) => k, value: (k) => closestWorkersList[k]);
        // ignore: avoid_print
        print('SORTED MAP: $sortedMap');
        // ignore: avoid_print
        print('FIRST ELEMENT IN SORTED MAP: ${sortedMap.keys.toList().first}');

        String address = await HelperMethods.findAddressViaCoordinates(
            sortedMap.keys.toList().first, context);

        getWorkerName();
        globals.closestWorkerCoordinate = sortedMap.keys.toList().first;
        globals.closestWorkerAddress = address;
        globals.closestWorkerDistance = sortedMap.values.toList().first;

        // ignore: avoid_print
        print('CLOSEST WORKER ADDRESS: ${globals.closestWorkerAddress}');
      } else {
        Address? address = Address();
        Provider.of<AppData>(context, listen: false)
            .updateClosestWorkerAddress(address);
        setState(() {
          AlanVoice.activate();
          AlanVoice.playText('No worker available at the moment');
        });
      }
      // var sortedKeys = closestWorkersList.keys.toList(growable: false)
      //   ..sort(
      //     (k1, k2) =>
      //         closestWorkersList[k1]!.compareTo(closestWorkersList[k2]!),
      //   );
      // LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
      //     key: (k) => k, value: (k) => closestWorkersList[k]);
      // // ignore: avoid_print
      // print('SORTED MAP: $sortedMap');
      // // ignore: avoid_print
      // print('FIRST ELEMENT IN SORTED MAP: ${sortedMap.keys.toList().first}');

      // if (sortedMap.isNotEmpty) {
      //   String address = await HelperMethods.findAddressViaCoordinates(
      //       sortedMap.keys.toList().first, context);

      //   globals.closestWorkerAddress = address;

      //   // ignore: avoid_print
      //   print('CLOSEST WORKER ADDRESS: ${globals.closestWorkerAddress}');
      // }

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

    String address =
        // ignore: use_build_context_synchronously
        await HelperMethods.findCoordinateAddress(position, context);
    // ignore: avoid_print
    print('MY ADDRESS: $address');
    createMarker();
    getWorkerLocations();
  }

  @override
  Widget build(BuildContext context) {
    setTextWidgetState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPaddingBottom),
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
              setState(() {
                mapPaddingBottom = 280;
              });
              setupPositionLocation();
            },
          ),

          //search sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: Container(
                height: searchSheetHeight,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Book now!',
                        style: TextStyle(
                          color: Color(0xff020435),
                          fontSize: 12,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'Choose your booking location',
                        style: TextStyle(
                          color: Color(0xff020435),
                          fontSize: 18,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          searchLocation();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: const [
                                Icon(
                                  LineAwesomeIcons.search,
                                  color: Color(0xff51DAD0),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Search booking location',
                                  style: TextStyle(
                                    color: Color(0xff020435),
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            LineAwesomeIcons.home,
                            color: BrandColors.viberGray,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Add Home',
                                style: TextStyle(
                                  color: Color(0xff020435),
                                  fontFamily: "Lato",
                                ),
                              ),
                              // Text((Provider.of<AppData>(context)
                              //                 .userBookingAddress !=
                              //             null)
                              //         ? Provider.of<AppData>(context)
                              //             .userBookingAddress!
                              //             .placeName!
                              //         : 'Add Home'
                              //     // style: TextStyle(
                              //     //   color: Color(0xff020435),
                              //     //   fontFamily: "Lato",
                              //     // ),
                              //     ),
                              Text(
                                'Your residential address',
                                style: TextStyle(
                                  color: BrandColors.viberGray,
                                  fontSize: 11,
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 1.0,
                        color: Color(0xFFe2e2e2),
                        thickness: 1.0,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.work_outline_outlined,
                            color: BrandColors.viberGray,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Add Work',
                                style: TextStyle(
                                  color: Color(0xff020435),
                                  fontFamily: "Lato",
                                ),
                              ),
                              Text(
                                'Your office address',
                                style: TextStyle(
                                  color: BrandColors.viberGray,
                                  fontSize: 11,
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //confirm booking sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                height: confirmBookingSheetHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        color: BrandColors.mastodonLightGray,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/icons/workerIcon1.png",
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    (globals.closestWorkerName != null)
                                        ? globals.closestWorkerName!
                                        : "Worker Name",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Lato",
                                      color: Color(0xff020435),
                                    ),
                                  ),
                                  Text(
                                    '${globals.closestWorkerDistance.toStringAsFixed(2)} km',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato",
                                      color: BrandColors.viberGray,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Text(
                                'Rs ${globals.totalCost.toString()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: "Lato",
                                  color: Color(0xff020435),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'User email: ${user.email}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Lato",
                                  color: Color(0xff020435),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                globals.categorySelected == 'AC'
                                    ? 'Service: ${globals.acService}'
                                    : 'Service: ${globals.salonService}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Lato",
                                  color: Color(0xff020435),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                globals.categorySelected == 'AC'
                                    ? 'Type of property: ${globals.propertyType}'
                                    : 'Occasion type: ${globals.occasionType}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Lato",
                                  color: Color(0xff020435),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                globals.categorySelected == 'AC'
                                    ? 'No of Units: ${globals.noOfUnits}'
                                    : 'No of persons: ${globals.noOfPersons}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Lato",
                                  color: Color(0xff020435),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              (invisible)
                                  ? Container()
                                  : Text(
                                      'No of Rooms: ${globals.noOfRooms}',
                                      /* use this if many conditions */
                                      // globals.categorySelected == 'AC'
                                      //     ? 'No of Rooms: ${globals.noOfRooms}'
                                      //     : globals.categorySelected == 'Painting'
                                      //         ? 'No of Paintings: ${globals.noOfUnits}'
                                      //         : '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Lato",
                                        color: Color(0xff020435),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Material(
                              color: const Color(0xff6759FF),
                              child: InkWell(
                                onTap: () {
                                  makePayment();
                                },
                                highlightColor: const Color.fromARGB(
                                  255,
                                  207,
                                  203,
                                  255,
                                ),
                                child: const Center(
                                  child: Text(
                                    "MAKE PAYMENT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getDirection() async {
    var userAddress =
        Provider.of<AppData>(context, listen: false).userBookingAddress;

    var workerAddress =
        Provider.of<AppData>(context, listen: false).closestWorkerAddress;
    var userLatLng = LatLng(userAddress.latitude!, userAddress.longitude!);
    var workerLatLng =
        LatLng(workerAddress!.latitude!, workerAddress.longitude!);

    var thisDetails =
        await HelperMethods.getDirectionDetails(userLatLng, workerLatLng);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(thisDetails!.encodedPoints ?? '');

    List<LatLng> polylineCoordinates = [];

    if (results.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      results.forEach((PointLatLng points) {
        polylineCoordinates.add(LatLng(points.latitude, points.longitude));
      });
    }
    _polylines.clear;
    setState(() {
      Polyline polyline = Polyline(
        polylineId: const PolylineId('polyid'),
        color: Colors.green,
        points: polylineCoordinates,
        jointType: JointType.round,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      _polylines.add(polyline);
    });
  }
}
