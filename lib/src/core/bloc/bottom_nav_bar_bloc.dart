import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(const BottomNavBarState(index: 0)) {
    on<NavigationIndexChanged>(_onNavigationIndexChanged);
  }
  void _onNavigationIndexChanged(
      NavigationIndexChanged event, Emitter<BottomNavBarState> emit) {
    emit(BottomNavBarState(index: event.index));
  }
}
