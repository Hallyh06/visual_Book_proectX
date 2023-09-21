// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_book_tablet/core/constant/app_assets.dart';
import 'package:visual_book_tablet/core/utils/busy_button.dart';
import 'package:visual_book_tablet/core/utils/flushbar_notification.dart';
import 'package:visual_book_tablet/core/utils/font.dart';
import 'package:visual_book_tablet/features/auth/presentation/pages/view_gift_scree.dart';

class VisualCodeScreen extends StatefulWidget {
  const VisualCodeScreen({super.key});

  @override
  State<VisualCodeScreen> createState() => _VisualCodeScreenState();
}

class _VisualCodeScreenState extends State<VisualCodeScreen> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(20),
              Align(
                child: Image.asset(
                  AppAssets.vsLogo,
                  height: 150,
                  width: 150,
                ),
              ),
              TextBold(
                'Enter Visual Code',
                fontSize: 20,
              ),
              const Gap(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: PinCodeTextField(
                  controller: codeController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    inactiveFillColor: const Color(0xffFFFFFF),
                    inactiveColor: const Color(0xffDBD2C2),
                    activeColor: const Color(0xffDBD2C2),
                    selectedColor: const Color(0xffDBD2C2),
                    selectedFillColor: const Color(0xffDBD2C2),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: const Color(0xffFFFFFF),
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const Gap(60),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: BusyButton(
                  ttitle: 'Proceed',
                  onTap: () {
                    if (codeController.text.isEmpty) {
                      FlushbarNotification.showErrorMessage(context,
                          message: 'Visual code cannot be empty');
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewGiftScreenn(visualCode: codeController.text),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
