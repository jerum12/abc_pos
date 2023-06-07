import 'package:abc_pos/source/item/bloc/item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ItemBloc _itemBloc = ItemBloc();

  @override
  void dispose() {
    _itemBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        bloc: _itemBloc,
        builder: (context, state) {
          if (state is ItemLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ItemSuccess) {
            final items = state.items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _itemBloc.add(DeleteItem(item.id));
                    },
                  ),
                );
              },
            );
          } else if (state is ItemError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddItemDialog(_itemBloc),
          );
        },
      ),
    );
  }
}

class AddItemDialog extends StatefulWidget {
  final ItemBloc itemBloc;

  AddItemDialog(this.itemBloc);

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Item'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Item Name'),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            final itemName = _nameController.text;
            if (itemName.isNotEmpty) {
              widget.itemBloc.add(AddItem(itemName));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
