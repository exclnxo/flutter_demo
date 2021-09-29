import 'package:flutter/material.dart';
import 'package:purchase_car/config/api.dart';
import 'package:purchase_car/model/home_page_model.dart';
import 'package:purchase_car/net/net_request.dart';

class HomePageProvider with ChangeNotifier {
  late HomePageModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';

  loadHomePageDate() {
    isLoading = true;
    isError = false;
    errorMsg = '';
    NetRequest().requestData(Api.HOME_PAGE).then((res) {
      isLoading = false;
     if (res.code == 200) {
       model = HomePageModel.fromJson(res.data);
     }
     notifyListeners();
    }).catchError((error) {
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}