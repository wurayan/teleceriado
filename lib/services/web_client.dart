import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:teleceriado/services/http_interceptors.dart';

class WebClient {
  static const String url = "https://www.episodate.com/api/";

  http.Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()], requestTimeout: const Duration(seconds: 30));
}