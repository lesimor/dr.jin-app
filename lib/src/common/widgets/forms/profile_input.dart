// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/intput.dart';
import 'package:bookrabbit/src/features/profiles/screens/my_profile_editor/controller.dart';

class ProfileFieldInput extends StatelessWidget {
  TextEditingController formController;
  ProfileEditorController widgetController;
  String placeHolder;
  int maxLength;
  int maxLines;

  ProfileFieldInput({
    super.key,
    required this.formController,
    required this.widgetController,
    this.placeHolder = '',
    this.maxLength = 10,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(
          controller: formController,
          hint: placeHolder,
          maxLength: maxLength,
          maxLines: maxLines,
          onChanged: (text) {
            widgetController.update();
          },
          textAlign: TextAlign.center,
        ),
        Text(
          '${formController.text.length}/${maxLength}자',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
