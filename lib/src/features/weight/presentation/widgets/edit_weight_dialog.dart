import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/src/app_exports.dart';

void showEditWeightDialog({
  required BuildContext context,
  required WeightModel weight,
  required TextEditingController weighController,
  required int index,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: ReusableText(
          text: AppTexts.editWeight,
        ),
        content: SizedBox(
          height: 45,
          child: ReusableTextFormField(
            keyboardType: TextInputType.number,
            hintText: AppTexts.enterNewWeight,
            labelText: 'weight',
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
            onTap: () {
              double newWeight = double.parse(weighController.text.trim());
              WeightModel updatedWeight = WeightModel(
                weight: newWeight,
                date: weight.date,
                username: weight.username,
              );
              if (weighController.text.isEmpty) {
                showSnackBar(context, 'Please enter weight');
                return;
              } else {
                double weight = double.parse(weighController.text);
                if (weight <= 0) {
                  showSnackBar(context, 'Please enter a valid weight');
                  return;
                } else if (weight < 10 || weight > 200) {
                  showSnackBar(
                      context, 'Weight should be in range between 10 to 200');
                  return;
                }
              }
              context.read<WeightBloc>().add(EditWeightEntry(
                  updatedWeight, weight.username.toString(), weight.id!));
              Navigator.of(context).pop();
            },
            child: GlobalContainer(
              borderWidth: 1.1,
              height: 35,
              width: 90,
              borderRadius: BorderRadius.circular(5),
              color: Colors.black12,
              child: ReusableText(
                text: AppTexts.editWeight,
              ),
            ),
          )
        ],
      );
    },
  );
}
