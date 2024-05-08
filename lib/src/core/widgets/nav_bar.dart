import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bottom_nav_bar_bloc.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (BuildContext context, BottomNavBarState state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            onTap: (int index) {
              context
                  .read<BottomNavBarBloc>()
                  .add(NavigationIndexChanged(index));
              switch (index) {
                case 0:
                  context.go('/');
                  break;
                case 1:
                  context.go('/profile');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
