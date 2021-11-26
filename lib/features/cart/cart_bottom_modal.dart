import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_marketplace/features/cart/bloc/cart_bloc.dart';
import 'package:nubank_marketplace/features/cart/widgets/snack_bar_error.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';
import 'package:nubank_marketplace/features/user/presentation/bloc/user_bloc.dart';

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: const Text('Checkout'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
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
                      onPressed: () {
                        int currentBalance = (BlocProvider.of<UserBloc>(context)
                                .state as UserLoaded)
                            .user
                            .balance;
                        if (cartState is CartLoaded &&
                            cartState.cartOffers.isNotEmpty) {
                          if (currentBalance >= totalValue) {
                            List<ProductOffer> offersExpired = cartState
                                .cartOffers
                                .where((element) => element.expirationDate
                                    .isBefore(DateTime.now()))
                                .toList();
                            if (offersExpired.isEmpty) {
                              BlocProvider.of<CartBloc>(context)
                                ..add(CartPurchaseEvent(totalValue));
                              Navigator.of(context).pop();
                            } else {
                              offersExpired.forEach((element) {
                                SnackBarError.buildErrorSnackBar(context,
                                    errorMessage:
                                        'Offer for ${element.product.name} has expired.');
                              });
                            }
                          } else {
                            SnackBarError.buildErrorSnackBar(context,
                                errorMessage:
                                    'Insufficient balance.\nCurrent: \$$currentBalance');
                          }
                        }
                      },
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
