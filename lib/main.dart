import 'package:flutter/material.dart';
import 'package:purchase_car/page/index_page.dart';
import 'package:purchase_car/provider/bottom_navi_provider.dart';
import 'package:provider/provider.dart';
import 'package:purchase_car/provider/cart_provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BottomNaviProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) {
            CartProvider provider = new CartProvider();
            provider.getCarList();
            return provider;
          },
        )
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
