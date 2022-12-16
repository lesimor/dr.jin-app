// Flutter imports:
import "package:flutter/material.dart";

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

enum MessageType { info, alert }

void showToast({
  required String message,
  MessageType messageType = MessageType.info,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: messageType == MessageType.alert
        ? Colors.red
        : CustomColors.primaryGreen,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
