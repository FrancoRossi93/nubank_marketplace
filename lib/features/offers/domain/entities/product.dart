import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;

  Product(
      {@required this.id, @required this.name, this.description, this.image});

  @override
  List<Object> get props => [id, name, description, image];
}
