import 'package:dio/dio.dart';

class ComResponse<T> {
  int code;
  String msg;
  T data;

  ComResponse({required this.code, required this.msg, required this.data});
}

class NetRequest {
  var dio = Dio();

  Future<ComResponse<T>> requestData<T>(String path,
      {Map<String, dynamic>? queryParameters,
        dynamic data,
        String method = 'get'}) async {

    try {
      Response response = method == 'get'
          ? await dio.get(path, queryParameters: queryParameters)
          : await dio.post(path, data: data);

      return ComResponse(
          code: response.data['code'],
          msg: response.data['msg'],
          data: response.data['data']
      );
    } on DioError catch(e) {
      //DioError 只會返回伺服器錯誤500
      print(e.message);

      String message = e.message;
      if (e.type == DioErrorType.connectTimeout)
        message = 'Connection TimeOut';
      else if (e.type == DioErrorType.receiveTimeout)
        message = 'Receive TimeOut';
      else if (e.type == DioErrorType.response) {
        message = "404 server not found ${e.response!.statusCode}";
      }

      return Future.error(message);
    }
  }
}