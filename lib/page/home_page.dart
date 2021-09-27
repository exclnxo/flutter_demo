import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:purchase_car/config/api.dart';
import 'package:purchase_car/net/net_request.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('首頁'),
      ),
      body: Container(),
    );
  }
}
