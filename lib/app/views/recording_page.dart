import 'dart:ui' as ui show Gradient;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_recorder/app/controller/sound_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RecordingPage extends StatelessWidget {
  RecordingPage({super.key});

  final SoundController soundController = Get.find();

  Widget _buildBody(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.transparent, // Makes sure background image fills the screen
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.png'), // Replace with your SVG image path
          fit: BoxFit.cover,
        ),
      ),
      child: Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const  Padding(
              padding: EdgeInsets.only(bottom: 0, right: 0), // Adjust the left padding as needed
              child: Text(
              'Recording...',
              style: TextStyle(
                fontFamily: 'Bricolage',
                fontSize: 30,
                
                color: Color.fromARGB(1000, 86, 86, 86),
              ),
            ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 200.0.h),
            child: AudioWaveforms(padding: EdgeInsets.symmetric(horizontal: 60.sp),
              size: Size(double.infinity, 200.h),
              recorderController: soundController.recorderController,
              waveStyle: WaveStyle(
                showMiddleLine: false,
                extendWaveform: true,
                waveThickness: 5,
                gradient: ui.Gradient.linear(
                  const Offset(70, 50),
                  Offset(MediaQuery.of(context).size.width / 2, 0),
                  [Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(232, 34, 59, 108),],
                ),
              ),
            ),
          ),
           Padding(padding: EdgeInsets.only(bottom:36.0.h),
          child: Text(
            soundController.audioTime,
            style:const TextStyle(
              color: Color.fromARGB(232, 34, 59, 108),
              fontSize: 36,
              fontWeight: FontWeight.w600,
            )
          ),
          ),
          soundController.voiceState == VoiceState.recording
              ? SizedBox(
                          width: 144,
                          height: 48,
                          child:FloatingActionButton(
                            backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        onPressed: () {
                          soundController.pauseRecord();
                        },
                        child: SvgPicture.asset(
                          'assets/pppause.svg', // Replace with the correct path to your SVG file
                        ),
                        heroTag: null, // Null heroTag to avoid a tag conflict
                        mini: false, // Set mini to false for a larger button
                        ),
              )
              : SizedBox(
                          width: 144,
                          height: 48,
                          child:FloatingActionButton(
                            backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        onPressed: () {
                          soundController.startRecord();
                        },
                        child: SvgPicture.asset(
                          'assets/cont.svg',
                        ),
                        heroTag: null, // Null heroTag to avoid a tag conflict
                        mini: false, // Set mini to false for a larger button
                        ),
              )
        ],
      ),
      ),
    ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      leading: Bounceable(
          onTap: () {
            soundController.cancelRecord();
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Icon(
              Icons.close,
              color: Color.fromARGB(232, 34, 59, 108),
            ),
          )),
      // backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
          child: Bounceable(
              onTap: () {
                soundController.stopAndSaveRecord();
                Get.back();

              },
              child: const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Icon(
                  Icons.check,
                  color: Color.fromARGB(232, 34, 59, 108),
                ),
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }
}
