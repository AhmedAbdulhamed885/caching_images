import 'dart:io';

import 'package:caching_images/Shared/constants/constants.dart';
import 'package:caching_images/Utilies/FileManger.dart';
import 'package:flutter/material.dart';

class ImagesManger {

  ImageProvider loadImage(
      {@required String url,
      @required int type,
      @required int appId,
      @required int moduleId,
      @required String screenType,
      @required int businessTypeId}) {
    final imageName= FileManger().getImageName(type,appId,moduleId,screenType,businessTypeId);
    if (FileManger().isInLocal('$globalFilePath/$imageName')) {
   //   DownloadImagesManger().downloadImage(url, ImageName)
      return FileImage(File('$globalFilePath/$imageName'));
    } else {
      //   DownloadImagesManger().downloadImage(url, ImageName)
      return NetworkImage(url);
    }
  }
}