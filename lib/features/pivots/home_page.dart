// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_marketplace/core/utils/custom_icons.dart';
import 'package:nubank_marketplace/features/cart/bloc/cart_bloc.dart';
import 'package:nubank_marketplace/features/cart/cart_bottom_modal.dart';
import 'package:nubank_marketplace/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:nubank_marketplace/features/offers/presentation/widgets/offer_tile.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/splasg-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            CustomIcons.nubank,
            size: 40.0,
            color: Colors.white,
          ),
          title: const Text('marketplace'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<OffersBloc, OffersState>(
              builder: (context, offersState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Flash offers!',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      )
                    ],
                  ),
                  if (offersState is OffersLoaded)
                    ...offersState.offers.map((e) => OfferTile(
                          offer: e,
                        ))
                ],
              ),
            ),
          ),
        )),
        floatingActionButton: FittedBox(
          child: Stack(
            alignment: const Alignment(1.4, -1.5),
            children: [
              FloatingActionButton(
                onPressed: () => showModalBottomSheet(
                    context: context, builder: (context) => CartBottomModal()),
                child: const Icon(Icons.add),
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  if (cartState is CartLoaded &&
                      cartState.cartOffers.isNotEmpty)
                    return Container(
                      child: Center(
                        child: Text(cartState.cartOffers.length.toString(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints:
                          const BoxConstraints(minHeight: 32, minWidth: 32),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: Colors.black.withAlpha(50))
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).primaryColorLight,
                      ),
                    );
                  else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
