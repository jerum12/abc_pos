part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends ItemEvent {
  final String name;

  const AddItem(this.name);

  @override
  List<Object> get props => [name];
}

class EditItem extends ItemEvent {
  final int id;
  final String newName;

  const EditItem(this.id, this.newName);

  @override
  List<Object> get props => [id, newName];
}

class DeleteItem extends ItemEvent {
  final int id;

  const DeleteItem(this.id);

  @override
  List<Object> get props => [id];
}
