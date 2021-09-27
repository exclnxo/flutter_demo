import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:purchase_car/provider/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //保留一個slidable打開
  final SlidableController _slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('購物車'),
      ),
      body:Consumer<CartProvider>(
        builder: (_, provider, __) {
          if (provider.models.length == 0) {
            return Center(
              child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                   child: Image.asset(
                     "assets/image/shop_cart.png",
                     width: 90,
                     height: 90,
                   ),
                 ),
                 Text("購物車空空如也!!",
                 style:  TextStyle(fontSize: 16.0, color: Color(0xFF999999)),
                 )
               ],
              ),
            );
          } else {
            //有商品
            return Stack(
              children: [
                //商品列表
                ListView.builder(
                    itemCount: provider.models.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                              child: Card(
                                margin: EdgeInsets.all(8.0),
                                child: buildProductItem(provider, index),
                              ))
                        ],
                      );
                    }
                )
              ],
            );
          }
        }),
    );

  }

  Widget buildProductItem(CartProvider provider, int index) {
    return Slidable(
      controller: _slidableController,
      actionPane: SlidableDrawerActionPane(), //顯示效果
      actionExtentRatio: 0.2, //顯示大小比例
      //action
      secondaryActions: [
        SlideAction(
            child: Center(
              child: Text('刪除',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0),
              ),
            ),
          color: Color(0xFFe4393c),
          onTap: () {
              //刪除事件
              provider.removeFromCart(provider.models[index].id);
          },
        )
      ],
      child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: Image.asset("assets${provider.models[index].cover}",
                                      width: 90,
                                      height: 90,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(top: 5.0),
                                              child: Text(provider.models[index].title,
                                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400,),
                                                  maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text("價格${provider.models[index].price}",
                                                style: TextStyle(fontSize: 16.0, fontWeight:  FontWeight.w400,
                                                color: Color(0xFFe93b3d)),
                                                )
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                ),
    );
  }
}