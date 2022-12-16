// Flutter imports:
import 'package:flutter/cupertino.dart';

void showCustomAlert({
  required BuildContext context,
  required String title,
  Function()? onConfirm,
  String? message,
  Widget? messageWidget,
  String? confirmText,
  String? cancelText,
}) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: messageWidget != null
            ? messageWidget
            : message != null
                ? Text(message)
                : null,
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(cancelText != null ? cancelText : "취소"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(confirmText != null ? confirmText : "확인"),
            onPressed: () {
              if (onConfirm != null) {
                onConfirm();
              } else {
                Navigator.pop(context);
              }
            },
          )
        ],
      );
    },
  );
}
