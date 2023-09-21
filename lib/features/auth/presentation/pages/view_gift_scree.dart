// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_media_slider/carousel_media.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:visual_book_tablet/core/utils/font.dart';

class ViewGiftScreenn extends StatefulWidget {
  const ViewGiftScreenn({
    super.key,
    required this.visualCode,
  });
  final String visualCode;
  @override
  State<ViewGiftScreenn> createState() => _ViewGiftScreennState();
}

class _ViewGiftScreennState extends State<ViewGiftScreenn> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;

  String type = '';
  String giftUrlLink = '';
  String giverName = '';
  String caption = '';
  _getGift() async {
    /* try {
      await FirebaseFirestore.instance
          .collection('Gift')
          .doc(widget.visualCode)
          .get()
          .then((value) {
        type = value['giftType'];
        giftUrlLink = value['mediaUrl'];
        giverName = value['giverName'];
        caption = value['caption'];
Ca
        print(giftUrlLink);
        (widget.visualCode);
      
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const VisualCodeScreen()),
          (route) => false);
      FlushbarNotification.showErrorMessage(context, message: e.toString());
    }*/
  }

  setvisitStatus({required String code}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('giftCode', code);
    print(code);
  }

  List<CarouselMedia> media = [
    CarouselMedia(
      mediaName: 'Image 1',
      mediaUrl:
          'https://firebasestorage.googleapis.com/v0/b/visual-book-ba653.appspot.com/o/files%2Fdata%2Fuser%2F0%2Fcom.example.visual_book%2Fcache%2Fscaled_04751193-b73e-4e83-8cbc-78d9cf16be7c5287462624821024891.jpg?alt=media&token=71f387f6-be50-4bab-b2db-532d7b4352c1',
      mediaType: CarouselMediaType.image,
      carouselImageSource: CarouselImageSource.network,
    ),
    CarouselMedia(
      mediaName: 'Image 2',
      mediaUrl:
          'https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=',
      mediaType: CarouselMediaType.image,
      carouselImageSource: CarouselImageSource.network,
    ),
    CarouselMedia(
      mediaName: 'Image 5',
      mediaUrl:
          'https://firebasestorage.googleapis.com/v0/b/visual-book-ba653.appspot.com/o/files%2Fdata%2Fuser%2F0%2Fcom.example.visual_book%2Fcache%2Fb870427a-6da4-4aff-8310-f56da08941c0%2F14fd755dcc5bc2aacd97a00a1c9236ab.mp4?alt=media&token=5e8bd487-524a-404e-ab38-a7c870e2967f',
      mediaType: CarouselMediaType.video,
      carouselImageSource: CarouselImageSource.network,
    )
  ];
  List<String> message = [
    'This is a pix',
    'This is a picture',
    'This is a video',
  ];
  int currentIndex = 0;
  var duration = 0;
  @override
  void initState() {
    setvisitStatus(code: widget.visualCode);
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(
            'https://firebasestorage.googleapis.com/v0/b/visual-book-ba653.appspot.com/o/files%2Fdata%2Fuser%2F0%2Fcom.example.visual_book%2Fcache%2Fb870427a-6da4-4aff-8310-f56da08941c0%2F14fd755dcc5bc2aacd97a00a1c9236ab.mp4?alt=media&token=5e8bd487-524a-404e-ab38-a7c870e2967f'),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((value) {
        setState(() {
          intervalSeconds = _controller.value.duration.inSeconds;
          print(duration);
        });
      });
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  CarouselOptions? carouselOptions = CarouselOptions(
    pageSnapping: false,
  );
  int intervalSeconds = 3;
  @override
  Widget build(BuildContext context) {
    List<Widget> carouselList = [
      Image.network(
        'https://firebasestorage.googleapis.com/v0/b/visual-book-ba653.appspot.com/o/files%2Fdata%2Fuser%2F0%2Fcom.example.visual_book%2Fcache%2Fscaled_04751193-b73e-4e83-8cbc-78d9cf16be7c5287462624821024891.jpg?alt=media&token=71f387f6-be50-4bab-b2db-532d7b4352c1',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Image.network(
        'https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      VideoPlayer(
        _controller,
      )
    ];
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Stack(
        children: [
          Align(
            child: SizedBox(
                height: double.infinity,
                width: MediaQuery.of(context).size.width * 0.7,
                child: CarouselSlider(
                  items: carouselList,
                  options: CarouselOptions(
                    height: double.infinity,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: currentIndex == 2
                        ? Duration(seconds: intervalSeconds)
                        : const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                        currentIndex == 2
                            ? _controller.play()
                            : _controller.pause();
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ) /* FlutterCarouselMediaSlider(
                boxFit: BoxFit.fill,
                carouselMediaList: media,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),*/
                ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffFFFFFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        TextBold(
                          'Wisdom',
                          fontSize: 20,
                        ),
                        const Gap(5),
                        TextSemiBold(
                          message[currentIndex],
                          fontSize: 15,
                          color: const Color(0xff000000).withOpacity(0.8),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ), /*FutureBuilder(
        future: _getGift(),
        builder: (context, state) {
          return giftUrlLink == ''
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffDBD2C2),
                  ),
                )
              : SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      type == 'Photo'
                          ? Image.network(
                              giftUrlLink,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : VideoPlayer(
                              _controller,
                            ),
                      
                    ],
                  ),
                );
        },
      ),*/
    );
  }
}
