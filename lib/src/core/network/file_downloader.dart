import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  Dio dio = Dio();

  Future<bool> startDownloading({required String file}) async {
    String baseUrl =
        "https://dev-api-flutter.mjscode.pro/storage/archive/$file";
    String fileName = file;
    String path = await _getFilePath(fileName);

    try {
      final response = await dio.download(
        baseUrl,
        path,
        deleteOnError: true,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      throw Exception("Error getting directory: $err");
    }
    return "${dir.path}$filename";
  }
}
