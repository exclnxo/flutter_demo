import 'package:flutter/material.dart';
import 'package:purchase_car/config/api.dart';
import 'package:purchase_car/model/product_info_model.dart';
import 'package:purchase_car/net/net_request.dart';

class ProductListProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<ProductInfoModel> list = [];

  loadProductList() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(Api.PRODUCTIONS_LIST).then((res) {
      isLoading = false;
      print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          ProductInfoModel tmpModel = ProductInfoModel.fromJson(item);
          list.add(tmpModel);
        }
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}
