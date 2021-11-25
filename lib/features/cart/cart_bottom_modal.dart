import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_marketplace/features/cart/bloc/cart_bloc.dart';

class CartBottomModal extends StatelessWidget {
  int totalValue = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, cartState) {
      if (cartState is CartLoaded && cartState.cartOffers.isNotEmpty) {
        totalValue = 0;
        cartState.cartOffers.forEach((element) {
          totalValue += element.price;
        });
      }
      return Scaffold(
        body: Center(
          child: cartState is CartLoaded && cartState.cartOffers.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ...cartState.cartOffers.map((e) => ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(e.product.imageUrl),
                                      fit: BoxFit.fill)),
                            ),
                            title: Text(e.product.name,
                                style: Theme.of(context).textTheme.headline5),
                            subtitle: Text(e.price.toString(),
                                style: Theme.of(context).textTheme.headline6),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.redAccent,
                              onPressed: () =>
                                  BlocProvider.of<CartBloc>(context)
                                    ..add(RemoveOfferFromCartEvent(
                                        initialCart: cartState.cartOffers,
                                        offer: e)),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Total: \$$totalValue",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(fontSize: 26),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Text('No offers have been added.'),
        ),
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: MaterialButton(
                      onPressed: () => BlocProvider.of<CartBloc>(context)
                        ..add(CartPurchaseEvent(totalValue)),
                      textColor: Colors.white,
                      textTheme: Theme.of(context).buttonTheme.textTheme,
                      color: Theme.of(context).primaryColor,
                      child: const Text(
                        'Purchase',
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
