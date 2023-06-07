part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends HomeEvent {
  final Product product;

  const AddItemEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveItemEvent extends HomeEvent {
  final Product product;

  const RemoveItemEvent(this.product);

  @override
  List<Object> get props => [product];
}
