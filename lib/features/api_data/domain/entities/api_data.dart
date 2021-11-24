import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';

class ApiData extends Equatable {
  final User user;
  final List<ProductOffer> productsOffer;

  ApiData({@required this.user, @required this.productsOffer});

  @override
  List<Object> get props => [user, productsOffer];
}
