import 'package:abc_pos/model/item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemLoading()) {
    on<AddItem>(_mapAddItemToState);
    on<EditItem>(_mapEditItemToState);
    on<DeleteItem>(_mapDeleteItemToState);
  }
  final List<Item> _items = [];

  Future<void> _mapAddItemToState(
      AddItem event, Emitter<ItemState> emit) async {
    try {
      emit(ItemLoading());
      final newItem = Item(
        id: _items.length + 1,
        name: event.name,
      );
      _items.add(newItem);
      emit(ItemSuccess(List.from(_items)));
    } catch (e) {
      emit(const ItemError('Failed to add item.'));
    }
  }

  Future<void> _mapEditItemToState(
      EditItem event, Emitter<ItemState> emit) async {
    try {
      emit(ItemLoading());
      final index = _items.indexWhere((item) => item.id == event.id);
      if (index >= 0) {
        final updatedItem = Item(
          id: _items[index].id,
          name: event.newName,
        );
        _items[index] = updatedItem;
        emit(ItemSuccess(List.from(_items)));
      }
    } catch (e) {
      emit(const ItemError('Failed to edit item.'));
    }
  }

  Future<void> _mapDeleteItemToState(
      DeleteItem event, Emitter<ItemState> emit) async {
    try {
      emit(ItemLoading());
      _items.removeWhere((item) => item.id == event.id);
      emit(ItemSuccess(List.from(_items)));
    } catch (e) {
      emit(const ItemError('Failed to delete item.'));
    }
  }
}
