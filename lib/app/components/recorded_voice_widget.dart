import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_recorder/app/controller/flutter_sound_player_controller.dart';
import 'package:flutter_sound_recorder/app/controller/sound_controller.dart';
import 'package:flutter_sound_recorder/app/views/ble_page.dart';
import 'package:get/get.dart';

import '../../core/styles/text_styles.dart';

class RecordedVoiceWidget extends StatelessWidget {
  int index;

  RecordedVoiceWidget({super.key, required this.index});

  SoundController soundController = Get.find();
  FlutterSoundPlayerController flutterSoundPlayerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      child: Bounceable(
        onTap: () async {
          await flutterSoundPlayerController.startPlayer(
              recordFile: soundController.recordList[index]);
        },
        child: Center(
          child: Container(
            height: 90.h,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.sp),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recording ${index + 1}',
                        style:
                            TextStyles.generalBlackTextStyle2(fontSize: 20.sp),
                      ),
                      Row(
                        children: [
                          Bounceable(
                              onTap: () {
                                Get.to(() => FileSharingScreen());
                              },
                              child: const Icon(Icons.share)),
                          const Icon(Icons.play_arrow),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*
*
*
*
*
*   Obx(
                  () => Expanded(
                    child: ProgressBar(
                      progress: flutterSoundPlayerController.currentDuration.value,
                      buffered: soundController.currentDurationList[index],
                      total: soundController.currentDurationList[index],
                      onSeek: (duration) {
                        print('User selected a new time: $duration');
                      },
                    ),
                  ),
                ),
                *
                *
                *
                *
                *
                * */
