import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Product(
      {@required this.id,
      @required this.name,
      this.description,
      this.imageUrl});

  @override
  List<Object> get props => [id, name, description, imageUrl];
}
