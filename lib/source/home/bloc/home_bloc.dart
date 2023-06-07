import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../model/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState([])) {
    on<HomeEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is AddItemEvent) {
      final updateItems = List<Product>.from(state.cartItems)
        ..add(event.product);
      emit(HomeState(updateItems));
    }
  }
}
