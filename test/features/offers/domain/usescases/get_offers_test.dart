import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';
import 'package:nubank_marketplace/features/offers/domain/repository/offers_repository.dart';
import 'package:nubank_marketplace/features/offers/domain/usecases/get_offers.dart';

class MockOfferRepository extends Mock implements OffersRepository {}

void main() {
  GetOffers usecase;
  MockOfferRepository mockOfferRepository;

  setUp(() {
    mockOfferRepository = MockOfferRepository();
    usecase = GetOffers(mockOfferRepository);
  });

  final List<ProductOffer> tProductOffer = [
    ProductOffer(
        id: "1",
        price: 100,
        product: Product(
            id: "1", name: "test", description: "test", imageUrl: "test"))
  ];

  test('should get Product Offer from repository', () async {
    //arrange
    when(mockOfferRepository.getOffers())
        .thenAnswer((realInvocation) async => Right(tProductOffer));
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, equals(Right(tProductOffer)));
    verify(mockOfferRepository.getOffers());
    verifyNoMoreInteractions(mockOfferRepository);
  });
}
