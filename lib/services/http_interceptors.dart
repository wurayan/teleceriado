import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();
  
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    logger.v("Requisição para: ${request.url}\nCabeçalhos: ${request.headers}\nCorpo: ${request.toString()}");
    return request;
    // throw UnimplementedError();
  }
  
  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    if(response.statusCode ~/ 100 == 2){
      logger.i("Resposta de ${response.request?.url ?? "bah"}\nStatus da Resposta: ${response.statusCode}\nCabeçalho: ${response.headers}\nCorpo: ${response.toString()}");
    } else {
      logger.e("Requisição para ${response.request?.url ?? "bah"}\nStatus da Resposta: ${response.statusCode}\nCabeçalho: ${response.headers}\nCorpo: ${response.toString()}");
    }
    return response;
  }
  
  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }
  
  @override
  Future<bool> shouldInterceptResponse() async {
    // throw UnimplementedError();
    return true;
  }

  // @override
  // Future<RequestData> interceptRequest ({required RequestData data}) async {
  //   logger.v('Requisição para ${data.baseUrl}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}');
  //   return data;
  // }

  // @override
  // Future<ResponseData> interceptResponse ({required ResponseData data}) async {
  //   if (data.statusCode ~/ 100 == 2) {
  //     logger.i('Resposta de ${data.url}\nStatus da Resposta:${data.statusCode}\nCabeçalho: ${data.headers}\nCorpo: ${data.body}');
  //   } else{
  //     logger.e('Requisição para ${data.url}\nStatus da Resposta:${data.statusCode}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}');
  //   }
  //   return data;
  // }
  
}