import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';

Dio dio;

class HttpUtil {
  static HttpUtil get instance => _getInstance();

  static HttpUtil _httpUtil;

  /// 抓包用的代理地址
  String _proxyHost;

  static HttpUtil _getInstance() {
    if (_httpUtil == null) {
      _httpUtil = HttpUtil();
    }
    return _httpUtil;
  }

  void setProxyIP(String ipHost) {
    _proxyHost = ipHost;
    _httpUtil = HttpUtil();
  }

  HttpUtil() {
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );

    dio = Dio(options);

    dio.interceptors
      ..add(CookieManager(CookieJar()))
      ..add(InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
        // 请求数据
        return requestOptions;
      }, onResponse: (Response response) {
        // 获取的返回数据
      }, onError: (DioError dioError) {
        // 请求错误
      }));

    ///非releaseMode可以抓包
    if (!kReleaseMode) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          // _proxyHost为null说明没有设置代理，直连；不为空就走代理端口
          return _proxyHost == null ? 'DIRECT' : "PROXY $_proxyHost";
        };
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future get(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.get(url, queryParameters: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.get(url, queryParameters: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.get(url, options: options);
    } else {
      response = await dio.get(url);
    }
    return response;
  }

  Future post(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    return response;
  }
}
