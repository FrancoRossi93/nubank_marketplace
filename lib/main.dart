import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            create: (context) => sl<OffersBloc>()..add(GetOffersEvent()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: NubankMarketplaceRouter.generateRoute,
      ),
    );
  }
}
