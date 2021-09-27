import 'package:flutter/material.dart';
import 'package:purchase_car/config/api.dart';
import 'package:purchase_car/net/net_request.dart';
import 'package:purchase_car/model/category_content_model.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> catagoryNavList = [];
  List<CategoryContentModel> categoryContentList = [];
  int tabIndex = 0;

  //分類左側
  loadCategoryPageDate() {
    isLoading = true;
    isError = false;
    errorMsg = "";

    //請求數據
    NetRequest().requestData(Api.CATEGORY_NAV).then((res) {
      isLoading = false;
      // print(res.data);
      if (res.data is List) {
        for (var i = 0; i < res.data.length; i++) {
          catagoryNavList.add(res.data[i]);
        }
        loadCategoryContentData(this.tabIndex);
      }
      notifyListeners();
    }).catchError((error) {
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }

  //分類右側
  loadCategoryContentData(int index) {
    this.tabIndex = index;
   isLoading = true;
   categoryContentList.clear();

   //請求數據
   var data = {"title": catagoryNavList[index]};
   NetRequest()
       .requestData(Api.CATEGORY_CONTENT, data: data, method: "post")
       .then((res) {
     isLoading = false;
     print(res.data);
     if (res.data is List) {
       for(var item in res.data) {
         CategoryContentModel tmpModel = CategoryContentModel.fromJson(item);
         categoryContentList.add(tmpModel);
       }
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