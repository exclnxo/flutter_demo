# Flutter練習

使用到套件及服務紀錄.

##底部導航頁

使用BottomNavigationBar配合IndexStack,在BottomNavigationBar的items數組中加入BottomNavigationBarItem(可填入圖示及名稱),
IndexStack是繼承自Stack,Stack畫面元件可以重疊在一起,IndexStack是加了一個Index參數可以控制該元件可以顯示哪個畫面,IndexedStack在children中加入頁面.
Index參數可用變數控制,本練習室使用Provider整合.

##Provider
建立一個class with ChangeNotifier. 已BottomNaviProvider(底部導航Provider)為例,建立一個 bottomNaviIndex變數 紀錄現在頁面Index,
創建method changeBottomNaviIndex 在有新跳轉到頁面時使用並加入 notifyListeners() 回傳至接收者.
在使用到Provider的畫面上要先使用ChangeNotifierProvider,可限定使用的範圍,在Widget要使用Consumer來取得provider使用.
在底部導航頁要跳轉時就可以使用BottomNaviProvider裡的method更新bottomNaviIndex.

//dio
第三方網路庫,更簡易使用網路相關功能,在練習中在NetRequest中自行封裝處理回傳資料及錯誤.

//shared_preferences
緩存,呼叫SharedPreferences.getInstance()可儲存跟取出資料.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
