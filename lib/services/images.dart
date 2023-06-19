import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<Uint8List> getBytesFromAsset(String path, int width, int height) async {
  ByteData data = await rootBundle.load(path);
  Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width, targetHeight: height);
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
}

Future<Uint8List> getBytesFromUrlImage(String imgUrl) async {
  File image = await getCacheImages(imgUrl);
  return image.readAsBytes();
}

Future<File?> saveCacheImages(String imgUrl) async {
  await DefaultCacheManager().downloadFile(imgUrl);
  final File? file = await getCacheImages(imgUrl);
  return file;
}

Future<dynamic>getCacheImages(String imgUrl) async {
  File? file;
  final FileInfo? cacheInfo = await DefaultCacheManager().getFileFromCache(imgUrl);
  if(cacheInfo?.file == null){
    file = await saveCacheImages(imgUrl);
  }else{
    file = cacheInfo?.file;
  }

  return file;
}

Future<String>uploadImage(String id, String path, image, String type) async {
  Reference _reference = FirebaseStorage.instance
      .ref().child('users').child(id).child('images')
      .child(path)
      .child('${DateTime.now().millisecondsSinceEpoch.toString()}.png');

  if(type == 'file'){
    await _reference.putFile(image, SettableMetadata(contentType: 'image/png'));
  }else{
    await _reference.putData(image, SettableMetadata(contentType: 'image/png'));
  }

  return await _reference.getDownloadURL().then((url) async {
    return url;
  });
}

Future<File?>getImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;
    try{
      return File(file.path ?? 'no-image');
    }catch(e){
      return null;
    }
  }else{
    return null;
  }
}

Future<Uint8List?>printImage(previewContainer) async {
  RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
  ui.Image _markerImage = await boundary.toImage(pixelRatio: 2.0);
  ByteData? byteData = await _markerImage.toByteData(format: ui.ImageByteFormat.png);
  Uint8List? pngBytes = byteData?.buffer.asUint8List();

  return pngBytes;
}
