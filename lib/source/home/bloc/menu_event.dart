part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends MenuEvent {
  final Product product;

  const AddItemEvent(this.product);

  @override
  List<Object> get props => [product];
}

class ChangeQuantityEvent extends MenuEvent {
  final int id;
  final int newQuantity;

  const ChangeQuantityEvent(this.id, this.newQuantity);

  @override
  List<Object> get props => [id, newQuantity];
}

class RemoveItemEvent extends MenuEvent {
  final Product product;

  const RemoveItemEvent(this.product);

  @override
  List<Object> get props => [product];
}
