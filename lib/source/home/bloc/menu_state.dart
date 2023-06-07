part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuLoading extends MenuState {}

// class HomeState {
//   final List<Product> cartItems;
//   const HomeState(this.cartItems);
// }

class MenuSuccess extends MenuState {
  final List<Product> cartItems;
  final String total;
  const MenuSuccess({this.cartItems = const <Product>[], this.total = "0.0"});

  @override
  List<Object> get props => [cartItems, total];
}

class MenuError extends MenuState {
  final String errorMessage;

  const MenuError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
