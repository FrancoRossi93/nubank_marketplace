import 'package:flutter/material.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';

class OfferTile extends StatelessWidget {
  final ProductOffer offer;

  const OfferTile({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Material(
          elevation: 10,
          shadowColor: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          child: ExpansionTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(offer.product.imageUrl),
                      fit: BoxFit.fill)),
            ),
            title: Text(offer.product.name,
                style: Theme.of(context).textTheme.headline5),
            subtitle: Text(offer.price.toString(),
                style: Theme.of(context).textTheme.headline6),
            collapsedIconColor: Theme.of(context).primaryColor,
            childrenPadding: const EdgeInsets.all(20),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        offer.product.description,
                        style: Theme.of(context).textTheme.bodyText1,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {},
                          textColor: Colors.white,
                          textTheme: Theme.of(context).buttonTheme.textTheme,
                          color: Theme.of(context).primaryColor,
                          child: const Text(
                            'Agregar',
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}