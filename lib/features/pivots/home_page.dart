import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_marketplace/core/utils/custom_icons.dart';
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () {},
          label: Icon(Icons.shop)),
    );
  }
}
