import 'package:dio/dio.dart';
import 'package:series_spot/core/http/app_interceptor.dart';

class HTTP {
  final Dio client = createClient();

  static Dio createClient() {
    const baseUrl = 'https://api.tvmaze.com/';
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => true,
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.add(AppInterceptors(dio));

    return dio;
  }
}
