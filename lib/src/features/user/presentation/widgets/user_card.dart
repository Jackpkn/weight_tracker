import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/src/app_exports.dart';

class UserCard extends StatelessWidget {
  final UserModel userModel;
  final VoidCallback onTap;
  const UserCard({
    super.key,
    required this.userModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8).copyWith(
          bottom: 4,
        ),
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: AppCustomStyle.containerBorderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableText(
              text: userModel.name.toString(),
              style: AppStyle.userNameTextStyle,
            ),
            InkWell(
              onTap: () {
                context.read<UserBloc>().add(
                      DeleteUser(
                        userModel.name.toString(),
                      ),
                    );
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
