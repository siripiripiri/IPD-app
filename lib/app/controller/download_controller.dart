import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_sound_recorder/app/controller/flutter_sound_player_controller.dart';
import 'package:get/get.dart';

class DownloadController extends GetxController {
  RxBool simulatorActive = false.obs;
  RxInt downloadBytes = 0.obs;
  RxInt fileTotalBytes = 0.obs;
  var audioPath = "";
  //var audioPath ="https://firebasestorage.googleapis.com/v0/b/flutter-sound-recorder.appspot.com/o/soft-rain-ambient-111154.mp3?alt=media&token=a0fc04a8-efa3-47af-b280-65d581aa2a58";
  //var audioPath =
   //   "https://firebasestorage.googleapis.com/v0/b/flutter-sound-recorder.appspot.com/o/Yagmur-sesi-zil-sesi-indir-4.mp3?alt=media&token=a7a5ddfe-7b0f-46ae-ad81-50c16f7366be";

  startDownload() async {
    FlutterSoundPlayerController flutterSoundPlayerController = Get.find();
    String filePath = await downloadFile(audioPath);
    File soundFile =
        await byteDownloadSimulator(File(filePath).readAsBytesSync());

    await flutterSoundPlayerController.startPlayer(recordFile: soundFile.path);
  }

  Future<File> byteDownloadSimulator(Uint8List bytes) async {
    simulatorActive.value = true;
    fileTotalBytes.value = bytes.length;
    List<int> newBytes = [];
    for (int i = 0; i < bytes.length; i++) {
      if (simulatorActive.value == false) {
        i = bytes.length;
      } else {
        downloadBytes.value = i;
        await Future.delayed(const Duration(microseconds: 50));

        newBytes.add(bytes[i]);
      }
    }
    String localPath = '/Users/srijanupadhyay/Projects/IPD/test1/recording';
    File file = await File(
            '$localPath/${DateTime.now().millisecondsSinceEpoch}.mp3')
        .create();
    await file.writeAsBytes(newBytes);
    downloadBytes.value = 0;
    fileTotalBytes.value = 0;
    simulatorActive.value = false;
    return file;
  }

  Future<String> downloadFile(String url) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';
    String localPath = '/Users/srijanupadhyay/Projects/IPD/test1/recording';
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$localPath/$fileName';
        
        file = File(filePath);
        debugPrint("bytest = ${bytes.length}");
        await file.writeAsBytes(bytes);
      } else {
        filePath = 'Error code: ${response.statusCode}';
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }
}
