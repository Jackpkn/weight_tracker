part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState extends Equatable {
  final int index;
  const BottomNavBarState({required this.index});
  @override
  List<Object> get props => [index];
}
