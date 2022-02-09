import 'dart:io';
import 'package:caching_images/Shared/constants/constants.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DownloadImagesManger {
  Dio _dio = Dio();
  File _file;
  Response _response;
  DownloadImagesManger(){
    _httpClient(this._dio);
  }

  Future<void> downloadImage({
    @required String url,
    @required String downloadedImageName,
  }) async {
    var randomAccessFile;
    try {
      if (globalFilePath.isNotEmpty) {
        _file = File('$globalFilePath/$downloadedImageName');
        _response = await _getResponse(_dio, url);
        randomAccessFile = _file.openSync(mode: FileMode.write);
        print(_response.data);
        randomAccessFile.writeFromSync(_response.data);
        await randomAccessFile.close();
      }
    } catch (e) {
      await randomAccessFile ?? randomAccessFile.close();
      //Hamdy .. please change print with log function used on S2G
      print('${e.toString()} error in download');
    }
  }

  Future<Response> _getResponse(Dio dio, String url) async {
    return await dio.get(
      url,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
  }

  void _httpClient(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
