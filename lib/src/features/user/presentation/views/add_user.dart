import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/src/core/widgets/custom_button.dart';
import 'package:weight_tracker/src/core/widgets/custom_reusable_text.dart';
import 'package:weight_tracker/src/core/widgets/custom_text_form_field.dart';

import '../../../../core/utils/show_snackbar.dart';
import '../bloc/user_bloc.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            showSnackBar(context, state.message);
          } else if (state is UserAdded) {
            showSnackBar(context, 'User added successfully');
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ReusableTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'username can not be empty';
                      }
                      return null;
                    },
                    controller: _usernameController,
                    onSaved: (onSaved) {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        final userBloc = context.read<UserBloc>();
                        return userBloc.add(CreateUserEvent(
                          username: _usernameController.text.trim(),
                        ));
                      }
                    },
                    child: const ReusableText(
                      text: 'Add User',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
