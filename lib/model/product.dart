import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final dynamic image;
  final String title;
  final String price;
  final String item;
  final int quantity;

  const Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.item,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [];
}
