import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/src/app_exports.dart';

void showAddNewData(
  BuildContext context,
  TextEditingController usernameController,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: ReusableText(
          text: AppTexts.addNewUser,
        ),
        content: SizedBox(
          height: 40,
          child: ReusableTextFormField(
            validator: (v) {
              if (v!.isEmpty) {
                return AppTexts.userCannotBeEmpty;
              }
              return null;
            },
            controller: usernameController,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              usernameController.clear();
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
            onTap: () {
              if (usernameController.text.isEmpty) {
                showSnackBar(context, 'Please enter username');
                return;
              } else {
                final userBloc = context.read<UserBloc>();
                userBloc.add(CreateUserEvent(
                  username: usernameController.text.trim(),
                ));
                usernameController.clear(); // Clear the TextEditingController
                Navigator.of(context).pop();
              }
            },
            child: GlobalContainer(
              borderWidth: 1.1,
              height: 35,
              width: 90,
              borderRadius: BorderRadius.circular(5),
              color: Colors.black12,
              child: ReusableText(
                text: AppTexts.addNewUser,
              ),
            ),
          )
        ],
      );
    },
  );
}
