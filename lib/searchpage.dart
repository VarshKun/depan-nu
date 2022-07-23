// ignore: import_of_legacy_library_into_null_safe
import 'package:brand_colors/brand_colors.dart';
import 'package:depan_nu/components/prediction_tile.dart';
import 'package:depan_nu/datamodels/prediction.dart';
import 'package:depan_nu/dataprovider/appdata.dart';
import 'package:depan_nu/helper/requesthelper.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'globalvariables.dart' as globals;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String userLocation = '';
  var userController = TextEditingController(); //pickup
  var workerController = TextEditingController(); //dest
  bool buttonState = true;

  List<Prediction> userAddressPredictionList = [];

  void searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=AIzaSyD6BeUaj-_8YHSAricj7CrEi1xXh3m6nlg&sessiontoken=123254251&components=country:mu";
      var response = await RequestHelper.getRequest(url);

      if (response == "failed") {
        return;
      }

      if (response['status'] == 'OK') {
        var predictionJson = response['predictions'];
        var thisList = (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();
        setState(() {
          userAddressPredictionList = thisList;
        });
      }
    }
  }

  void setButtonState() {
    setState(() {
      if (Provider.of<AppData>(context).closestWorkerAddress!.placeName ==
          null) {
        buttonState = false;
      } else {
        buttonState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setButtonState();
    String address =
        Provider.of<AppData>(context).userBookingAddress.placeName ?? '';
    String closestWorkerAddress =
        (Provider.of<AppData>(context).closestWorkerAddress!.placeName == null)
            ? "No worker available"
            : Provider.of<AppData>(context).closestWorkerAddress!.placeName ??
                '';
    workerController.text = closestWorkerAddress;

    userController.text = address;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 280,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 15,
                  right: 24,
                  bottom: 20,
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            workerController.clear();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xff020435),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Set Booking Location',
                            style: TextStyle(
                              color: Color(0xff020435),
                              fontSize: 20,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/icons/pickicon.png",
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.twitterGray,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextField(
                                readOnly: true,
                                onChanged: (value) {
                                  TextSelection previousSelection =
                                      globals.userController.selection;
                                  globals.userController.text = value;
                                  globals.userController.selection =
                                      TextSelection.collapsed(
                                          offset: globals
                                              .userController.text.length);
                                  globals.userController.selection =
                                      previousSelection;
                                  searchPlace(value);
                                },
                                autofocus: true,
                                controller: userController,
                                //controller: userController,
                                decoration: InputDecoration(
                                  hintText: address,
                                  fillColor: BrandColors.twitterGray,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/icons/desticon.png",
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.twitterGray,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextField(
                                readOnly: true,
                                controller: workerController,
                                decoration: const InputDecoration(
                                  hintText: 'Worker location',
                                  fillColor: BrandColors.twitterGray,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Container(
                        height: 45,
                        margin: const EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Material(
                            color: buttonState
                                ? const Color(0xff6759FF)
                                : BrandColors.viberGray,
                            child: InkWell(
                              onTap: buttonState
                                  ? () {
                                      Navigator.pop(context, 'getDirection');
                                    }
                                  : null,
                              highlightColor: const Color.fromARGB(
                                255,
                                207,
                                203,
                                255,
                              ),
                              child: const Center(
                                child: Text(
                                  "BOOK NOW",
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
            // ignore: prefer_is_empty
            (userAddressPredictionList.length > 0)
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          prediction: userAddressPredictionList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 1.0,
                        color: Color(0xFFe2e2e2),
                        thickness: 1.0,
                      ),
                      itemCount: userAddressPredictionList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
