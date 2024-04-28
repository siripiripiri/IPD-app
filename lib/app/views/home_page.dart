import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_recorder/app/views/recording_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../controller/sound_controller.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SoundController soundController = Get.find();
  var box = Hive.box("soundBox");

  RxBool busy = false.obs;

  @override
  void initState() {
    super.initState();

    box.clear();
  }

  Widget _buildBody() {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.only(bottom: 60.h, right: 0,left: 10.h),
            child: Text(
              'Hello, Srijan',
              style: TextStyle(
                fontFamily: 'Bricolage',
                fontSize: 30,
                color: Color.fromARGB(1000, 86, 86, 86),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 350.h,
                      height: 350.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 190, 198, 242),
                            Color.fromARGB(232, 34, 59, 108),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                   SizedBox(
                        width: 320.h,
                        height: 320.h,
                        child: FloatingActionButton(
                          backgroundColor: Color.fromARGB(1000, 95, 100, 145),
                          onPressed: () {
                              soundController.startRecord();
                              Get.to(() => RecordingPage());
                          },
                          child: SvgPicture.asset(
                            'assets/mic.svg',
                          ),
                          elevation: 1,
                          heroTag: null,
                          mini: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),

                  ],
                  
                ),
              ],
            ),
          ),
             Padding( 
            padding: EdgeInsets.only(left: 50.h, right: 5.h, top:30.h),
            child: Text(
              'Try Saying: "I Love making Machine Learning Models"',
              style: TextStyle(
                fontFamily: 'Bricolage',
                fontSize: 24,
                color: Color.fromARGB(1000, 86, 86, 86),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 28,
                  height: 28,
                ),
              ),
              const Text(
                'Parkinder',
                style: TextStyle(
                  fontFamily: 'Bricolage',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(1000, 95, 100, 145),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
    backgroundColor:Color.fromARGB(255, 251, 234, 255),
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label:'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        label: 'Community',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Account',
      )
    ],
    onTap: (index) {
      // Handle navigation events
    },
  ),

    );
  }
}

