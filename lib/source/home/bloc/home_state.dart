part of 'home_bloc.dart';

// @immutable
// abstract class HomeState {
//   const HomeState();

//   List<Object> get props => [];
// }

class HomeState {
  final List<Product> cartItems;
  const HomeState(this.cartItems);
}

class CartState {}
