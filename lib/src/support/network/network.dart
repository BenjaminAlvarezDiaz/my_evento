// ignore_for_file: unused_catch_clause, dead_code, constant_identifier_names, annotate_overrides, unnecessary_new, prefer_const_declarations, prefer_final_fields

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'http_method_enum.dart';
import 'network_request.dart';
import 'network_response.dart';

enum HttpCodesEnum {
  NoInternetConnection,
  s204_NoContent,
  e400_BadRequest,
  e401_Unauthorized,
  e402_PaymentRequired,
  e403_Forbidden,
  e404_NotFound,
  e405_MethodNotAllowed,
  e406_NotAcceptable,
  e407_ProxyAuthenticationRequired,
  e408_RequestTimeout,
  e409_Conflict,
  e410_Gone,
  e411_LengthRequired,
  e412_PreconditionFailed,
  e413_PayloadTooLarge,
  e414_URITooLong,
  e415_UnsupportedMediaType,
  e416_RangeNotSatisfiable,
  e417_ExpectationFailed,
  e418_ImAteapot,
  e422_UnprocessableEntity,
  e425_TooEarly,
  e426_UpgradeRequired,
  e428_PreconditionRequired,
  e429_TooManyRequests,
  e431_RequestHeaderFieldsTooLarge,
  e451_UnavailableForLegalReasons,
  e500_InternalServerError,
  e501_NotImplemented,
  e502_BadGateway,
  e503_ServiceUnavailable,
  e504_GatewayTimeout,
  e505_HTTPVersionNotSupported,
  e506_VariantAlsoNegotiates,
  e507_InsufficientStorage,
  e508_LoopDetected,
  e510_NotExtended,
  e511_NetworkAuthenticationRequired
}

class HttpResult implements Exception {
  final String msg;
  final HttpCodesEnum type;
  const HttpResult({this.msg = "", required this.type});
  String toString() => 'Error: $msg';
}

class Network {
  static final Network _singleton = new Network._internal();
  static final maxConnectionAttempts = 1;
  String? token;
  var _dioCacheManager = DioCacheManager(CacheConfig());

  factory Network() {
    return _singleton;
  }

  Network._internal();

  setToken(String token) {
    this.token = token;
  }

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return;
      }
    } catch (e) {
      throw HttpResult(type: HttpCodesEnum.NoInternetConnection);
    }

    throw HttpResult(type: HttpCodesEnum.NoInternetConnection);
  }

  Future<NetworkResponse?> callApi(NetworkRequest request) async {
    try {
      await checkInternetConnection();
      Response? response;

      switch (request.httpMethod) {
        case HttpMethodEnum.httpGet:
          response = await _get(request);
          break;
        case HttpMethodEnum.httpPost:
          response = await _post(request);
          break;
        case HttpMethodEnum.httpPut:
          response = await _put(request);
          break;
        case HttpMethodEnum.httpDelete:
          response = await _delete(request);
          break;
      }

      return _processResult(response!);
    } on DioError catch (er) {
      _processStatusCode(er.response);
    } on Exception catch (e) {
      throw const HttpResult(type: HttpCodesEnum.e404_NotFound);
    }

    return null;
  }

  Future<Response?> _get(NetworkRequest request) async {
    for (int attempt = 0;
        attempt <
            ((request.httpMethod == HttpMethodEnum.httpGet &&
                    request.enableRepeat)
                ? maxConnectionAttempts
                : 1);
        attempt++) {
      Options _options = request.enableCache
          ? buildCacheOptions(Duration(minutes: request.cacheDurationInMinutes),
              forceRefresh: request.forceRefresh)
          : Options();
      _options.headers!["authorization"] = 'Bearer $token';
      Dio _dio = Dio();

      if (request.enableCache) {
        _dio.interceptors.add(_dioCacheManager.interceptor);
      }

      Response result = await _dio
          .get<String>(request.url, options: _options)
          .timeout(Duration(seconds: request.timeOutInSeconds));
      return result;
    }

    return null;
  }

  Future<Response> _post(NetworkRequest request) async {
    var optionHeaders = {
      "Authorization": "$token",
      "content_type": "${request.mediaType} charset=utf-8"
    };

    Options _options = Options(headers: optionHeaders);
    /* _options.headers!["authorization"] = 'Bearer $token';
    _options.headers!["content-type"] = '${request.mediaType} charset=utf-8'; */
    return await Dio()
        .post<String>(request.url, data: request.jsonBody, options: _options)
        .timeout(Duration(seconds: request.timeOutInSeconds));
  }

  Future<Response> _put(NetworkRequest request) async {
    Options _options = Options();
    _options.headers!["authorization"] = 'Bearer $token';
    _options.headers!["content-type"] = '${request.mediaType} charset=utf-8';

    return await Dio()
        .put<String>(request.url, data: request.jsonBody, options: _options)
        .timeout(Duration(seconds: request.timeOutInSeconds));
  }

  Future<Response> _delete(NetworkRequest request) async {
    Options _options = Options();
    _options.headers!["authorization"] = 'Bearer $token';
    _options.headers!["content-type"] = '${request.mediaType} charset=utf-8';
    return await Dio()
        .put<String>(request.url, options: _options)
        .timeout(Duration(seconds: request.timeOutInSeconds));
  }

  NetworkResponse? _processResult(Response? response) {
    NetworkResponse result = new NetworkResponse();

    if (response != null) {
      _processStatusCode(response);

      if (response.data.isNotEmpty) {
        result.response = response.data;
        result.statusCode = response.statusCode;
        result.message = response.statusMessage;
        return result;
      } else {
        return throw HttpResult(type: HttpCodesEnum.s204_NoContent);
      }
    }
    return null;
  }

  _processStatusCode(Response? response) {
    if (response != null) {
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode != null) {
        throw HttpResult(type: getErrorEnum(response.statusCode!));
      }
    }
  }

  HttpCodesEnum getErrorEnum(int code) {
    try {
      return HttpCodesEnum.values
          .where((x) => x.toString().contains(code.toString()))
          .single;
    } catch (e) {}

    return HttpCodesEnum.e500_InternalServerError;
  }
}
