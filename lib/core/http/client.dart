import 'package:dio/dio.dart';

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

    return dio;
  }
}
