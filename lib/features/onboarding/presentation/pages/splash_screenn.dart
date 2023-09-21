import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_book_tablet/core/constant/app_assets.dart';
import 'package:visual_book_tablet/features/auth/presentation/pages/barcode_page.dart';
import 'package:visual_book_tablet/features/auth/presentation/pages/view_gift_scree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String visited = preferences.getString('giftCode') ?? '';
    return visited;
  }

  checkVisitStatus() async {
    String visited = await getCode();
    Future.delayed(const Duration(seconds: 3), () {
      if (visited == '') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BarcodePage()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ViewGiftScreenn(
                visualCode: visited,
              ),
            ),
            (route) => false);
      }
    });
  }

  @override
  void initState() {
    checkVisitStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Center(
        child: Image.asset(
          AppAssets.vsLogo,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
