import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'home_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/splash-page';

  @override
  Widget build(BuildContext context) {
    final LiquidController _liquidController = LiquidController();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      _liquidController.animateToPage(page: 1, duration: 400);
    });
    return Scaffold(
      body: LiquidSwipe(
          pages: [
            Container(
              height: double.infinity,
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/nubank-logo-splash.png',
                          scale: 2.5,
                        ),
                      )
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    )
                  ]),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorDark,
                  ])),
            )
          ],
          fullTransitionValue: 500,
          waveType: WaveType.liquidReveal,
          liquidController: _liquidController,
          onPageChangeCallback: (e) => Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false)),
    );
  }
}
