import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:teleceriado/services/http_interceptors.dart';

class WebClient {
  static const String url = "https://api.themoviedb.org/3/";

  http.Client client = 
    InterceptedClient.build(interceptors: [LoggingInterceptor()],
      requestTimeout: const Duration(seconds: 15));  
}