part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemLoading extends ItemState {}

class ItemSuccess extends ItemState {
  final List<Item> items;

  const ItemSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class ItemError extends ItemState {
  final String errorMessage;

  const ItemError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
