import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_marketplace/features/cart/bloc/cart_bloc.dart';
import 'package:nubank_marketplace/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:nubank_marketplace/features/user/presentation/bloc/user_bloc.dart';
import 'package:nubank_marketplace/router.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
            create: (context) => sl<UserBloc>()..add(GetUserEvent())),
        BlocProvider<OffersBloc>(
            create: (context) => sl<OffersBloc>()..add(GetOffersEvent())),
        BlocProvider<CartBloc>(create: (context) => sl<CartBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: const Color(0xFFa332b3),
            primaryColorLight: const Color(0xFFd765e6),
            primaryColorDark: const Color(0xFF710083),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF710083)),
            buttonTheme: const ButtonThemeData(
                buttonColor: Color(0xFF710083),
                textTheme: ButtonTextTheme.normal),
            textTheme: const TextTheme(
                bodyText1:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                headline4: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                headline5: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                headline6:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
        onGenerateRoute: NubankMarketplaceRouter.generateRoute,
      ),
    );
  }
}
