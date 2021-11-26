import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product.dart';

class ProductOffer extends Equatable {
  final String id;
  final int price;
  final DateTime expirationDate;
  final Product product;

  ProductOffer(
      {@required this.id,
      this.expirationDate,
      @required this.price,
      @required this.product});

  @override
  List<Object> get props => [id, price, product];
}
