import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketclinic_assignment/resources.dart';

class AppUtils {

  Widget getCustomToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: PrimaryTealColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(text,style: TextStyle(color: whiteColor),),
        ],
      ),);
    return toast;
  }

}

bool isWeb() => kIsWeb;
