import 'package:abc_pos/model/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuLoading()) {
    on<AddItemEvent>(_mapAddItemToState);
    on<RemoveItemEvent>(_mapDeleteItemToState);
    on<ChangeQuantityEvent>(_mapChangeQuantityToState);
  }

  List<Product> _cartItems = [];

  Future<void> _mapAddItemToState(
      AddItemEvent event, Emitter<MenuState> emit) async {
    try {
      emit(MenuLoading());

      _cartItems.add(event.product);

      String total = calculateTotal();

      emit(MenuSuccess(cartItems: List.from(_cartItems), total: total));
    } catch (e) {
      emit(const MenuError('Failed to add item.'));
    }
  }

  Future<void> _mapDeleteItemToState(
      RemoveItemEvent event, Emitter<MenuState> emit) async {
    try {
      emit(MenuLoading());

      List<Product> updatedCart = List.from(_cartItems);
      updatedCart.remove(event.product);

      _cartItems = updatedCart;
      String total = calculateTotal();

      emit(MenuSuccess(cartItems: List.from(updatedCart), total: total));
    } catch (e) {
      emit(const MenuError('Failed to delete item.'));
    }
  }

  Future<void> _mapChangeQuantityToState(
      ChangeQuantityEvent event, Emitter<MenuState> emit) async {
    try {
      emit(MenuLoading());

      final index = _cartItems.indexWhere((pr) => pr.id == event.id);

      Product updatedProduct = Product(
        id: _cartItems[index].id,
        title: _cartItems[index].title,
        price: _cartItems[index].price,
        image: _cartItems[index].image,
        item: _cartItems[index].item,
        quantity: _cartItems[index].quantity + event.newQuantity,
      );
      _cartItems[index] = updatedProduct;
      String total = calculateTotal();
      emit(MenuSuccess(cartItems: List.from(_cartItems), total: total));
    } catch (e) {
      emit(const MenuError('Failed to add item.'));
    }
  }

  String calculateTotal() {
    double total = 0.0;

    for (var product in _cartItems) {
      String price = product.price;
      double p = double.parse(price.substring(1));
      total += p * product.quantity;
    }

    return total.toStringAsFixed(2);
  }
}
