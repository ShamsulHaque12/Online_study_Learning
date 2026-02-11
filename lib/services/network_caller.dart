import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:online_study/services/shared_preferences_helper.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;
  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'something went wrong',
  });
}

class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest({required String url}) async {
    _logger.i(
      'AccessToken: Bearer ${await SharedPreferencesHelper.getAccessToken()}',
    );
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Authorization':
            'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
      };
      _logRequest(url, headers);
      Response response = await get(uri, headers: headers);
      _logResponse(url, response);
      final decodeResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeResponse,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeResponse['message'] ?? decodeResponse['detail'],
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeResponse['message'] ?? decodeResponse['detail'],
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false);
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
    bool useToken = true,
    Duration? customTimeout,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
          'Token at home_deviation_initiation_controller => ${await SharedPreferencesHelper.getAccessToken()}',
        );
        debugPrint('Body is network, $body');
      }
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        if (useToken)
          'Authorization':
              'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
      };
      _logRequest(url, headers, requestBody: body);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(customTimeout ?? const Duration(seconds: 60));
      _logger.i('Reseponse decoded: ${response.body}');
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['message'],
        );
      } else if (response.statusCode == 400) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['message'],
        );
      } else {
        // showSnackBar(false, decodeData['message']);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['message'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> putRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization':
            'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
      };
      _logRequest(url, headers);
      Response response = await put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> patchRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
      };

      _logger.i(headers);
      _logRequest(url, headers);

      Response response;
      if (body != null) {
        response = await patch(uri, headers: headers, body: jsonEncode(body));
      } else {
        response = await patch(uri, headers: headers);
      }

      _logger.i("Patch response: ${response.body}");
      _logResponse(url, response);

      final decodeData = jsonDecode(response.body);

      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: response.statusCode == 200,
        responseData: decodeData,
      );
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': await SharedPreferencesHelper.getAccessToken() ?? '',
      };

      _logRequest(url, headers, requestBody: body);

      Response response;
      if (body != null) {
        response = await delete(uri, headers: headers, body: jsonEncode(body));
      } else {
        response = await delete(uri, headers: headers);
      }

      _logResponse(url, response);

      final decodeData = jsonDecode(response.body);

      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: response.statusCode == 200,
        responseData: decodeData,
        errorMessage: decodeData['message'] ?? '',
      );
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> multipartRequest({
    required String url,
    String? filePath,
    String? fieldName,
    Map<String, String>? additionalFields,
    bool useToken = true,
    String method = 'POST',
    http.MediaType? fileContentType,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      var request = http.MultipartRequest(method.toUpperCase(), uri);

      // Add authorization header
      if (useToken) {
        request.headers['Authorization'] =
            'Bearer ${await SharedPreferencesHelper.getAccessToken()}';
      }

      // Only handle image files
      if (filePath != null && fieldName != null) {
        final mimeType = lookupMimeType(filePath);
        if (mimeType == null || !mimeType.startsWith('image/')) {
          return NetworkResponse(
            statusCode: 400,
            isSuccess: false,
            errorMessage: 'Invalid file type. Only images allowed.',
          );
        }

        final file = await http.MultipartFile.fromPath(
          fieldName,
          filePath,
          contentType: MediaType(
            mimeType.split('/')[0],
            mimeType.split('/')[1],
          ),
        );
        request.files.add(file);
      }

      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final decodeData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['message'] ?? 'Upload failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> sendAudioToAI(
    String apiUrl,
    String audioPath, {
    Duration? forceTimeout,
  }) async {
    final uri = Uri.parse(apiUrl);

    final mimeType =
        lookupMimeType(audioPath, headerBytes: [0x52, 0x49, 0x46, 0x46]) ??
        'audio/m4a';
    final mimeTypeData = mimeType.split('/');

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] =
        'Bearer ${await SharedPreferencesHelper.getAccessToken()}';
    final audioMultipartFile = await http.MultipartFile.fromPath(
      'audio_file',
      audioPath,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );

    request.files.add(audioMultipartFile);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      // _logResponse(ApiEndpoints.voiceMessage, response);

      final decodeData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['message'] ?? 'Unauthorized',
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decodeData['message'] ?? 'Upload failed',
        );
      }
    } catch (e) {
      _logger.e('Multipart request error: $e');
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(
    String url,
    Map<String, dynamic> headers, {
    Map<String, dynamic>? requestBody,
  }) {
    _logger.i('URl => $url\nHeaders => $headers\nRequest Body => $requestBody');
  }

  void _logResponse(String url, Response response) {
    _logger.i(
      'Url => $url\nStatus Code => ${response.statusCode}\nHeaders => ${response.headers}\nBody => ${response.body}',
    );
  }
}
