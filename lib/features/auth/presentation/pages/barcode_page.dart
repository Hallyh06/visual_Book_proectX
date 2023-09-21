import 'dart:math';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_book_tablet/features/auth/presentation/pages/view_gift_scree.dart';
import 'package:visual_book_tablet/features/auth/presentation/pages/visual_code_screen.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({super.key});

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  String code = '';
  void generateCode() {
    var rndnumber = "";
    var rnd = Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    code = rndnumber;
    print(code);
  }

  @override
  void initState() {
    generateCode();
    Future.delayed(
        const Duration(
          minutes: 2,
        ), () {
      /*  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewGiftScreenn(
            visualCode: code,
          ),
        ),
      );*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: BarcodeWidget(
              barcode: Barcode.qrCode(), // Barcode type and settings
              data: code, // Content
              width: 350,
              height: 350,
            ),
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimerCountdown(
                  spacerWidth: 0,
                  colonsTextStyle: GoogleFonts.inter(
                    fontSize: 17,
                    color: const Color(0xffDBD2C2),
                  ),
                  timeTextStyle: GoogleFonts.inter(
                    fontSize: 17,
                    color: const Color(0xffDBD2C2),
                  ),
                  format: CountDownTimerFormat.minutesSeconds,
                  minutesDescription: '',
                  secondsDescription: '',
                  endTime: DateTime.now().add(
                    const Duration(
                      minutes: 2,
                      seconds: 0,
                    ),
                  ),
                  onEnd: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewGiftScreenn(visualCode: code),
                        ),
                      );
                    });
                  }),
              Text(
                ' Left To Scan For Code',
                style: GoogleFonts.inter(
                  color: const Color(
                    0xffDBD2C2,
                  ),
                  fontSize: 17,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
