class Api {
  static const String BASE_URL = "https://flutter-jdapi.herokuapp.com/api";
  //首頁
  static const String HOME_PAGE = BASE_URL + "/profiles/homepage";
  //分類
  static const String CATEGORY_NAV = BASE_URL + "/profiles/navigationLeft";
  //分類頁商品數據
  static const String CATEGORY_CONTENT = BASE_URL + "/profiles/navigationRight";
  //返回商品列表
  static const String PRODUCTIONS_LIST = BASE_URL + "/profiles/productionsList";
  //返回商品詳情
  static const String PRODUCTIONS_DETAIL =
      BASE_URL + "/profiles/productionDetail";
}