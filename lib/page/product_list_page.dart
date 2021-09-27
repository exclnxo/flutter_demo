import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:purchase_car/model/product_info_model.dart';
import 'package:purchase_car/provider/cart_provider.dart';
import 'package:purchase_car/provider/product_list_provider.dart';

class ProductListPage extends StatefulWidget {
  final String title;

  const ProductListPage({Key? key, required this.title}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: Container(
        color: Color(0xFFF7F7F7),
        child: Consumer<ProductListProvider> (
          builder: (_, provider, __) {
            //加載動畫
            if (provider.isLoading) {
              return Center(child: CupertinoActivityIndicator());
            }

            //捕獲異常
            if (provider.isError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.errorMsg),
                    OutlineButton(
                      child: Text('刷新'),
                      onPressed: () {
                        provider.loadProductList();
                      },
                    ),
                  ],
                ),
              );
            }

            //返回數據展示
            return ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  ProductInfoModel model = provider.list[index];
                  // print(model.toJson());

                  return InkWell(child:
                  buildProductItem(model),
                  onTap: () {
                   //加入購物車
                  Provider.of<CartProvider>(context, listen: false).addToCart(model);
                  Fluttertoast.showToast(msg: '成功加入購物車',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    fontSize: 16.0
                  );
                  });
            });
          },
        ),
      ),
    );
  }

  Row buildProductItem(ProductInfoModel model) {
    return Row(
                  children: [
                    Image.asset("assets${model.cover}",
                    width: 95, height: 120,),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  model.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("價格${model.price}",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFFe93b3d)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  Text("${model.comment}條評價",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xFF999999)),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text("好評率${model.rate}",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xFF999999)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ))
                  ],
                );
  }
}
