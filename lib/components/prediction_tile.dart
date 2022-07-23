// ignore: import_of_legacy_library_into_null_safe
import 'package:brand_colors/brand_colors.dart';
import 'package:depan_nu/datamodels/address.dart';
import 'package:depan_nu/datamodels/prediction.dart';
import 'package:depan_nu/dataprovider/appdata.dart';
import 'package:depan_nu/helper/requesthelper.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:depan_nu/globalvariables.dart' as globals;

class PredictionTile extends StatelessWidget {
  final Prediction? prediction;
  // ignore: use_key_in_widget_constructors
  const PredictionTile({this.prediction});

  void getPlaceDetails(String placeID, context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Container(
              color: Colors.transparent,
              child: const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff020435),
                  color: Colors.amber,
                ),
              ),
            ));
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=AIzaSyD6BeUaj-_8YHSAricj7CrEi1xXh3m6nlg";
    var response = await RequestHelper.getRequest(url);

    Navigator.pop(context);

    if (response == "failed") {
      return;
    }

    if (response['status'] == 'OK') {
      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false)
          .updateUserChosenAddress(thisPlace);
      // ignore: avoid_print
      print(thisPlace.placeName);
      globals.userController.text = thisPlace.placeName!;
      Navigator.pop(context, 'getDirection');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return TextButton(
      onPressed: () {
        getPlaceDetails(prediction!.placeId!, context);
      },
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                const Icon(
                  LineAwesomeIcons.map_pin,
                  color: BrandColors.viberGray,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        prediction!.mainText!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          color: Color(0xff020435),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        prediction!.secondaryText!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: BrandColors.viberGray),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
