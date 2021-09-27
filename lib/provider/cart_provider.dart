import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purchase_car/model/product_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<ProductInfoModel> models = [];

  Future<void> addToCart(ProductInfoModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //先取緩存的數據
    List<String>? list = [];
    list = prefs.getStringList("cartInfo");

    //取出緩存
    if (list != null) {
      List<String> tmpList = [];
      //判斷緩存中有無商品
      bool isUpdated = false;
      for (var i = 0; i < list.length; i++) {
        ProductInfoModel tmpData = ProductInfoModel.fromJson(json.decode(list[i]));

        if(tmpData.id == data.id) {
          isUpdated = true;
        }

        //放到數組中
        String tmpDataStr = json.encode(tmpData.toJson());
        tmpList.add(tmpDataStr);
        models.add(tmpData);
     }

      if (isUpdated == false) {
        String str = json.encode(data.toJson());
        tmpList.add(str);
        models.add(data);
      }
      //存入緩存
      prefs.setStringList("cartInfo", list);
      //通知聽眾
      notifyListeners();
    } else {
      print("無商品");
      //傳過來的數據傳到數列中
      list!.add(json.encode(data.toJson()));
      //存入緩存
      prefs.setStringList("cartInfo", list);
      //更新本地數據
      models.add(data);
      //通知聽眾
      notifyListeners();
    }
  }

  void getCarList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? list = [];
    //取出緩存
    list = prefs.getStringList("cartInfo");
    if (list != null) {
      for (var i = 0; i < list.length; i ++) {
        ProductInfoModel tmpData = ProductInfoModel.fromJson(json.decode(list[i]));
        models.add(tmpData);
      }
      notifyListeners();
    }
  }

  //刪除商品
  void removeFromCart(String id) async {
    //從緩存刪除
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    //取出緩存
    list = prefs.getStringList("cartInfo")!;

    //遍歷緩存數據
    for (var i = 0; i < list.length; i ++) {
      ProductInfoModel tmpData = ProductInfoModel.fromJson(json.decode(list[i]));
      if (tmpData.id == id) {
        list.remove(list[i]);
        break;
      }
    }
    //遍歷本地數據
    for (var i = 0; i < models.length; i ++) {
      if (this.models[i].id == id) {
        this.models.remove(this.models[i]);
        break;
      }
    }
    
    //緩存重新複製
    prefs.setStringList("cartInfo", list);
    notifyListeners();
  }

}