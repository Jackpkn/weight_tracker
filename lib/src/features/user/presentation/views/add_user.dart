import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weight_tracker/src/app_exports.dart';
import 'package:weight_tracker/src/core/widgets/loader.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  DateTime? lastPressedAt;
  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (lastPressedAt == null ||
        now.difference(lastPressedAt!) > const Duration(seconds: 2)) {
      lastPressedAt = now;
      showSnackBar(context, 'Press back again to exit');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: ReusableText(
              text: AppTexts.userManagement,
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showAddNewData(context, _usernameController);
                },
              ),
            ],
          ),
          body: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                showSnackBar(context, state.message);
                context.read<UserBloc>().add(GetUserEvent());
              } else if (state is UserAdded) {
                showSnackBar(context, AppTexts.userAdded);
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return const Loader();
              }
              if (state is UserData && state.users.isNotEmpty) {
                return Padding(
                  padding: AppCustomStyle.addScreenPadding,
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return UserCard(
                        userModel: state.users[index],
                        onTap: () {
                          context.push(
                              '/home/${state.users[index].name.toString()}');
                        },
                      );
                    },
                  ),
                );
              } else {
                return _errorWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  _errorWidget() {
    return Center(
      child: GlobalContainer(
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        color: Colors.greenAccent,
        borderWidth: 1,
        child: ReusableText(
          text: AppTexts.noUserFound,
          style: AppStyle.userNoUserFound,
        ),
      ),
    );
  }
}
