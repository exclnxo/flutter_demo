import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:purchase_car/config/api.dart';
import 'package:purchase_car/model/home_page_model.dart';
import 'package:purchase_car/net/net_request.dart';
import 'package:purchase_car/provider/home_page_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // NetRequest();
    NetRequest().requestData(Api.HOME_PAGE).then((res) => print(res.msg));

    return ChangeNotifierProvider(
      create: (context) {
        var provider = new HomePageProvider();
        provider.loadHomePageDate();
        return provider;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('首頁'),
          ),
          body: Container(
            color: Color(0xFFf4f4f4),
            child: Consumer<HomePageProvider>(builder: (_, provider, __) {
              if (provider.isLoading) {
                return Center(child: CupertinoActivityIndicator());
              }

              if (provider.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(provider.errorMsg),
                      OutlineButton(
                        child: Text('刷新'),
                        onPressed: () {
                          provider.loadHomePageDate();
                        },
                      )
                    ],
                  ),
                );
              }

              HomePageModel model = provider.model;

              return ListView(
                children: <Widget>[
                  //輪播圖
                  buildAspectRatio(model),
                  //圖標分類
                  // buildLogos(model)
                  //秒殺頭部
                  buildMSHeaderContainer(),
                  //秒殺商品
                  buildMSBodyContainer(model)
                ],
              );
            }),
          )),
    );
  }

  //秒殺商品
  Container buildMSBodyContainer(HomePageModel model) {
    return Container(
      height: 120,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.quicks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets${model.quicks[index].image}",
                    width: 85,
                    height: 85,
                  ),
                  Text(
                    "價格${model.quicks[index].price}",
                    style: TextStyle(color: Colors.red, fontSize: 16.0),
                  ),
                ],
              ),
            );
          }),
    );
  }

  //秒殺頭部
  Container buildMSHeaderContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      height: 50.0,
      child: Row(
        children: [
          Image.asset("assets/image/bej.png", width: 90, height: 20),
          Spacer(),
          Text("更多秒殺"),
          Icon(
            CupertinoIcons.right_chevron,
            size: 14,
          )
        ],
      ),
    );
  }

  // 圖標分類
  Widget buildLogos(HomePageModel model) {
    List<Widget> list = [];

    for (var i = 0; i < model.logos.length; i++) {
      list.add(Container(
        width: 60,
        child: Column(
          children: [
            Image.asset("assets${model.logos[i].image}", width: 50, height: 50),
            Text("assets${model.logos[i].title}")
          ],
        ),
      ));
    }

    return Container(
      color: Colors.white,
      height: 170,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        spacing: 7.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.spaceBetween,
        children: list,
      ),
    );
  }

  // 輪播圖
  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset("assets${model.swipers[index].image}");
        },
      ),
    );
  }
}
