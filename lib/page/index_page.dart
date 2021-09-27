import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchase_car/page/car_page.dart';
import 'package:purchase_car/page/home_page.dart';
import 'package:purchase_car/page/category_page.dart';
import 'package:purchase_car/provider/bottom_navi_provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<BottomNaviProvider>(
        builder: (_,mProvider,__) {
          return BottomNavigationBar(
            //超過3個要用
            type: BottomNavigationBarType.fixed,
            currentIndex: mProvider.bottomNaviIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text("首頁"),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text("購物車"),
                icon: Icon(Icons.shopping_cart),
              ),
            ],
            onTap: (index) {
              // print(index);
              mProvider.changeBottomNaviIndex(index);
            },
          );
        },
      ),
      body: Consumer<BottomNaviProvider>(
        builder: (_,mProvider, __) => IndexedStack(
          index: mProvider.bottomNaviIndex,
          //多層佈局元件 只顯示一個Widget
          children: <Widget>[
            CategoryPage(),
            CartPage(),
          ],
        ),
      )
    );
  }
}
