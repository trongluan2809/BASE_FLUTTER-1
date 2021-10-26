import 'dart:convert';

import 'package:base_flutter_project/build_config.dart';
import 'package:base_flutter_project/model/base_response.dart';
import 'package:base_flutter_project/model/error_model.dart';
import 'package:base_flutter_project/model/git_response.dart';
import 'package:base_flutter_project/utils/string_extenstion.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_manger.dart';
import 'api_url.dart';

class AppApiManager implements ApiManager {
  static final AppApiManager _singleton = AppApiManager._internal();

  static AppApiManager get instance => _singleton;
  static final _baseUrl = BuildConfig.endpoint;

  late http.Client _httpClient;
  late ApiUrl _apiUrl;

  String token = '';

  AppApiManager._internal() {
    _httpClient = http.Client();
    _apiUrl = ApiUrl();
  }

  @override
  void dispose() {
    _httpClient.close();
  }

  Map<String, String> tokenHeader({bool isJson = false}) {
    if (isJson) {
      return <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    return <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
  }

  /*
  * return body response
  * */
  Future<dynamic> _postRequest(String url, Map<String, String> header,
      {body}) async {
    var fullUrl = '$_baseUrl$url';
    var uri = Uri.parse(fullUrl);
    var response = await _httpClient.post(uri, headers: header, body: body);
    String bodyResponse = response.body;
    var prettyString =
        JsonEncoder.withIndent('  ').convert(jsonDecode(bodyResponse));
    _printResponse(fullUrl, response.statusCode, prettyString);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> json = jsonDecode(bodyResponse);
        BaseResponse baseResponse = DataResponse(json);
        if (baseResponse.isSuccess ?? false) {
          return baseResponse.data;
        } else {
          var messageError = '${baseResponse.message}';
          printLog('error: $messageError');
          return Future.error(ErrorModel(messageError));
        }
      } catch (ex) {
        printLog('catch error: $ex');
        return Future.error(ErrorModel(ex.toString()));
      }
    } else {
      var messageError = 'Request API Falure: ${response.statusCode}';
      printLog('catch error $messageError');
      return Future.error(ErrorModel(messageError));
    }
  }

  Future<dynamic> _getRequest(String url, Map<String, String> header) async {
    var fullUrl = '$_baseUrl$url';
    var uri = Uri.parse(fullUrl);
    var response = await _httpClient.get(uri, headers: header);
    String bodyResponse = response.body;
    var prettyString = JsonEncoder.withIndent('  ').convert(bodyResponse);
    _printResponse(fullUrl, response.statusCode, prettyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(bodyResponse);
      BaseResponse baseResponse = DataResponse(json);
      if (baseResponse.isSuccess ?? false) {
        return baseResponse.data;
      } else {
        var messageError = '${baseResponse.message}';
        printLog('error: $messageError');
        return Future.error(ErrorModel(messageError));
      }
    } else {
      var prettyString = "Request API Failure " +
          JsonEncoder.withIndent('  ').convert(jsonDecode(bodyResponse));
      _printResponse(fullUrl, response.statusCode, prettyString);
      var messageError = 'Request API Failure: ${response.statusCode}';
      return Future.error(ErrorModel(messageError));
    }
  }

  void _printResponse(String url, int statusCode, String response) {
    printLog(
        '$url ====> Response: $statusCode ${BuildConfig.isLog ? "\n$response" : ""}');
  }

  @override
  void setToken(String token) {
    this.token = token;
  }

  @override
  Future<GitResponse> getGitResponse() async {
    var queryParams = <String, String>{"q": "trending", "sort": "start"};
    String queryString = Uri(queryParameters: queryParams).query;

    var fullUrl = '$_baseUrl${_apiUrl.github}?$queryString';
    var uri = Uri.parse(fullUrl);

    var response = await _httpClient.get(uri);
    if (response.statusCode == 200) {
      String bodyResponse = response.body;
      final json = jsonDecode(bodyResponse);
      return Future.value(GitResponse.fromJson(json));
    } else {
      return Future.error("Có lỗi xảy ra");
    }
  }
}
