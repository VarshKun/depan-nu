import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

var userController = TextEditingController();
//category selected for worker e.g AC/ Salon
String categorySelected = "";

//closest worker available details
String? closestWorkerAddress;
LatLng closestWorkerCoordinate = const LatLng(0, 0);
String? closestWorkerName;
int closestWorkerID = 0;
double closestWorkerDistance = 0;

//booking details
int totalCost = 0;
/*Salon*/
String occasionType = "";
int noOfPersons = 0;
String salonService = "";

/*AC*/
String propertyType = "";
int noOfUnits = 0;
int noOfRooms = 0;
String acService = "";
