import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/src/app_exports.dart';

import 'edit_weight_dialog.dart';

class WeightCard extends StatelessWidget {
  final WeightModel weight;
  final List<WeightModel?> listOfWeights;
  final Color color;
  final int index;
  final TextEditingController weighController;
  const WeightCard({
    super.key,
    required this.weight,
    required this.color,
    required this.weighController,
    required this.index,
    required this.listOfWeights,
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(weight.date.toString());
    final formattedDate = formatDate(dateTime);
    return GestureDetector(
      onTap: () {},
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        margin: const EdgeInsets.all(7).copyWith(
          bottom: 4,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppCustomStyle.containerBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableText(
              text: weight.username.toString(),
              style: AppStyle.usernameC,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "weight: ${weight.weight.toString()}/kg",
                      style: AppStyle.weightStyle,
                    ),
                    const SizedBox(height: 3),
                    ReusableText(
                        text: formattedDate, style: AppStyle.userNameTextStyle),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<WeightBloc>()
                              .add(DeleteWeightEntry(weight.id!));
                          showSnackBar(context, AppTexts.delete);
                        },
                        icon: const Icon(Icons.delete)),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showEditWeightDialog(
                          context: context,
                          weight: weight,
                          weighController: weighController,
                          index: index,
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
