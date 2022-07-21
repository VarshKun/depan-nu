import 'package:depan_nu/datamodels/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  late Address userBookingAddress;
  Address? closestWorkerAddress;
  late Address userChosenAddress;

  void updateUserBookingAddress(Address userBooking) {
    userBookingAddress = userBooking;
    notifyListeners();
  }

  void updateUserChosenAddress(Address userChosen) {
    userChosenAddress = userChosen;
    notifyListeners();
  }

  void updateClosestWorkerAddress(Address closestWorker) {
    closestWorkerAddress = closestWorker;
    notifyListeners();
  }
}
