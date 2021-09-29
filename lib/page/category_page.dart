import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchase_car/model/category_content_model.dart';
import 'package:purchase_car/page/product_list_page.dart';
import 'package:purchase_car/provider/category_page_provider.dart';
import 'package:purchase_car/provider/product_list_provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryPageProvider>(
      create: (context) {
        var provider = new CategoryPageProvider();
        provider.loadCategoryPageDate();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("分類"),
        ),
        body: Container(
          color: Color(0xFFf7f7f7),
          child: Consumer<CategoryPageProvider>(
            builder: (_, provider, __) {
              //加載動畫
              if (provider.isLoading && provider.catagoryNavList.length == 0) {
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
                          provider.loadCategoryPageDate();
                        },
                      ),
                    ],
                  ),
                );
              }

              print(provider.catagoryNavList);

              return Row(
                children: <Widget>[
                  // 分類左側
                  buildNavLeftContainer(provider),
                  //分類右側
                  Expanded(
                      child: Stack(
                    children: [
                      buildCategoryContent(provider.categoryContentList),
                      provider.isLoading
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Container()
                    ],
                  )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  //右側
  Widget buildCategoryContent(List<CategoryContentModel> contentList) {
    List<Widget> list = <Widget>[];

    //處理數據
    for (var i = 0; i < contentList.length; i++) {
      list.add(Container(
        height: 30.0,
        margin: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Text(
          "${contentList[i].title}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ));

      //商品數據容器
      List<Widget> descList = <Widget>[];

      for (var j = 0; j < contentList[i].desc.length; j++) {
        descList.add(InkWell(
          child: Container(
            width: 60.0,
            color: Colors.white,
            child: Column(
              children: [
                Image.asset(
                  "assets${contentList[i].desc[j].img}",
                  width: 50,
                  height: 50,
                ),
                Text("${contentList[i].desc[j].text}")
              ],
            ),
          ),
          onTap: () {
            // 前往商品內頁
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<ProductListProvider>(
                      create: (context) {
                        ProductListProvider provider = ProductListProvider();
                        provider.loadProductList();
                        return provider;
                      },
                      child: Consumer<ProductListProvider>(
                        builder: (_, provider, __) {
                          return Container(
                            child: ProductListPage(
                                title: contentList[i].desc[j].text),
                          );
                        },
                      ),
                    )));
          },
        ));
      }

      // 將descList追加到list中
      list.add(Padding(
        padding: const EdgeInsets.all(18.0),
        child: Wrap(
          spacing: 7.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          children: descList,
        ),
      ));
    }

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: ListView(
        children: list,
      ),
    );
  }

  //左側
  Container buildNavLeftContainer(CategoryPageProvider provider) {
    return Container(
      width: 90,
      child: ListView.builder(
          itemCount: provider.catagoryNavList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.only(top: 15),
                  color: provider.tabIndex == index
                      ? Colors.white
                      : Color(0xFFF8F8F8),
                  child: Text(
                    provider.catagoryNavList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: provider.tabIndex == index
                            ? Color(0xFFe93b3d)
                            : Color(0xFF333333),
                        fontWeight: FontWeight.w500),
                  )),
              onTap: () {
                // print(index);
                provider.loadCategoryContentData(index);
              },
            );
          }),
    );
  }
}
