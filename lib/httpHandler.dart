import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'models/user.dart';

/// The [Duration] on which the request will tried out
final Duration requestTimeoutLimit = Duration(seconds: 90);

Map<String, dynamic> headersJSON = {'Content-Type': 'application/json'};

/// Message to show on Timeout
const String _timeOutMessage = 'Request timed out, please check your internet connection and try again ';

/// Message to show on network error ( when [SocketException] is thrown )
const String _networkErrorMessage = 'Error in Network, please makesure you have active internet connection ';

//<editor-fold desc="Handle all HTTP Request ">
/// Implements both get,post,put and delete functions of http package
/// Each function returns a custom class [HttpData] which caries the response
/// from the request
class HttpHandler {
  //<editor-fold desc="Get data from the Url">
  /// A custom http get which pass a [String] of url where the data is to be fetched
  /// by http get. It returns the [HttpData] of the response
  static Future<HttpData> httpGet({@required String url}) async {
    final httpResponse = HttpData();
    try {
      Response response = await get(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'
          }).timeout(requestTimeoutLimit);
      httpResponse.statusCode = response.statusCode;
      httpResponse.responseBody = json.decode(response.body);
      httpResponse.hasError = false;
      httpResponse.networkError = false;
      httpResponse.message = 'Successfully';
      httpResponse.response = response;
    } on SocketException catch (_) {
      httpResponse.hasError = true;
      httpResponse.networkError = true;
      httpResponse.message = _networkErrorMessage;
    } on TimeoutException catch (_) {
      httpResponse.hasError = true;
      httpResponse.networkError = true;
      httpResponse.message = _timeOutMessage;
    } catch (e) {
      httpResponse.hasError = true;
      httpResponse.networkError = false;
      httpResponse.message = 'An error occurred, please try again ';
    }

    return httpResponse;
  }

//</editor-fold>

  //<editor-fold desc="Post Data to the URL">
  static Future<HttpData> httpPost(
      {@required String url,
        @required Map<String, dynamic> postBody,
        Map<String, String> header }) async {
    final _httpData = HttpData();
    Response response;
    try {
      response = await post(url,
          headers: header ??  {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'
          },
          body: jsonEncode(postBody))
          .timeout(requestTimeoutLimit);
      _httpData.statusCode = response.statusCode;
      _httpData.responseBody = json.decode(response.body);
      _httpData.hasError = false;
      _httpData.networkError = false;
      _httpData.message = 'Successfully';
      _httpData.response = response;
    } on SocketException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Error in Network, please make sure you have active internet connection ';
    } on TimeoutException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Request timed out, please check your internet connection and try again ';
    } catch (e) {
      print(e);
      _httpData.hasError = true;
      _httpData.networkError = false;
      _httpData.message = '${e.toString()} An error occurred, please try again ';
    }finally{
      _httpData.response = response;
    }

    return _httpData;
  }

//</editor-fold>

  //<editor-fold desc="HTTP POST with data and file to the URL">

  /// Post a request with a file
  /// [filePath] is the string of path of the file to be posted
  /// [fileKey] is the String of the file key the file will be transferred as
  /// [method] is the  HTTP method ie POST/PUT of type string
  /// [url] is the string url to send data to
  /// The response is [HttpData] which carries the response and some important details

  static Future<HttpData> httpSendDataWithImage({@required String filePath,@required String fileKey,@required String url,@required String method,
    @required Map<String, String> postBody,
    Map<String, dynamic> header }) async {
    var request = MultipartRequest(method, Uri.parse(url));

    request.files.add(await MultipartFile.fromPath(fileKey, filePath));
    request.fields.addAll(postBody);
    request.headers.addAll(header ?? {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'
    });

    final _httpData = HttpData();
    StreamedResponse response;
    try {
      response = await request.send()
          .timeout(Duration(seconds: 120));
      String responseBody = await response.stream.bytesToString();
      _httpData.statusCode = response.statusCode;
      _httpData.responseBody = json.decode(responseBody);
      _httpData.hasError = false;
      _httpData.networkError = false;
      _httpData.message = 'Successfully';
//      _httpData.response = response.
    } on SocketException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Error in Network, please make sure you have active internet connection ';
    } on TimeoutException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Request timed out, please check your internet connection and try again ';
    } catch (e) {
      print(e.toString());
      print(response.reasonPhrase);
      _httpData.hasError = true;
      _httpData.networkError = false;
      _httpData.message = 'An error occurred, please try again ';
    }

//    _httpData.response =
    return _httpData;
  }
  //</editor-fold>

  //<editor-fold desc="HTTP PUT with data to the URL">
  Future<HttpData> httpPut(
      {@required String url,
        @required Map<String, dynamic> postBody,
        Map<String, dynamic> header}) async {
    final _httpData = HttpData();
    try {
      Response response = await put(url,
          headers: header ??   {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'
          },
          body: jsonEncode(postBody))
          .timeout(requestTimeoutLimit);
      _httpData.statusCode = response.statusCode;
      _httpData.responseBody = json.decode(response.body);
      _httpData.hasError = false;
      _httpData.networkError = false;
      _httpData.message = 'Successfuly';
      _httpData.response = response;
    } on SocketException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Error in Network, please makesure you have active internet connection ';
    } on TimeoutException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Request timed out, please check your internet connection and try again ';
    } catch (e) {
      _httpData.hasError = true;
      _httpData.networkError = false;
      _httpData.message = 'An error occurred, please try again ';
    }

    return _httpData;
  }
//</editor-fold>

  //<editor-fold desc="Post Data to the URL">
  Future<HttpData> httpDelete(
      {@required String url,
        Map<String, dynamic> header }) async {
    final _httpData = HttpData();
    try {
      Response response = await delete(url,
          headers: header ??  {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'
          })
          .timeout(requestTimeoutLimit);
      _httpData.statusCode = response.statusCode;
      _httpData.responseBody = json.decode(response.body);
      _httpData.hasError = false;
      _httpData.networkError = false;
      _httpData.message = 'Successfully';
      _httpData.response = response;
    } on SocketException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Error in Network, please make sure you have active internet connection ';
    } on TimeoutException catch (_) {
      _httpData.hasError = true;
      _httpData.networkError = true;
      _httpData.message =
      'Request timed out, please check your internet connection and try again ';
    } catch (e) {
      _httpData.hasError = true;
      _httpData.networkError = false;
      _httpData.message = 'An error occurred, please try again ';
    }

    return _httpData;
  }

//</editor-fold>


}
//</editor-fold>

//<editor-fold desc="A custom class to hold Http response">
/// For holding [Response] of Http request with some additional
/// attributes to know the status of the request
class HttpData {
  bool hasError;
  bool networkError;
  Map<String,dynamic> responseBody;
  int statusCode;
  String message;
  Response response ;
}
//</editor-fold>

class TokenService {
  String token;
  User authUser;

  TokenService._privateConstructor();

  static final TokenService _instance = TokenService._privateConstructor();

  factory TokenService() {
    return _instance;
  }

}

// class HttpHeaders {
//   static const Map<String, String> CONTENT_TYPE_JSON = {
//     'Content-Type': 'application/json'
//   };
// }
