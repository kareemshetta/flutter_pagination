import 'package:dio/dio.dart';
import './endpoints.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(baseUrl: kBaseUrl, receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData(Map<String, dynamic> query) async {
    final response = await dio.get(kGetPosts, queryParameters: query);
    return response;
  }
}
