import 'package:flutter/material.dart';
import 'package:weight_tracker/src/app_exports.dart';

void addNewWeight({
  required BuildContext context,
  required TextEditingController weighController,
  required Function() onTap,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: ReusableText(
          text: AppTexts.addNewWeight,
        ),
        content: SizedBox(
          height: 40,
          child: ReusableTextFormField(
            validator: (v) {
              if (v!.isEmpty) {
                return AppTexts.enterNewWeight;
              }
              return null;
            },
            controller: weighController,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              weighController.clear();
              Navigator.of(context).pop();
            },
            child: GlobalContainer(
              height: 35,
              width: 90,
              borderWidth: 1.1,
              borderRadius: BorderRadius.circular(5),
              color: Colors.black12,
              child: ReusableText(
                text: AppTexts.cancel,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: GlobalContainer(
              borderWidth: 1.1,
              height: 35,
              width: 90,
              borderRadius: BorderRadius.circular(5),
              color: Colors.black12,
              child: ReusableText(
                text: AppTexts.addWeight,
              ),
            ),
          )
        ],
      );
    },
  );
}
