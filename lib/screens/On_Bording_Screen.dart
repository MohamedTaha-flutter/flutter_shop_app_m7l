import 'package:flutter/material.dart';
import 'package:shop_app/local/cache_helper.dart';
import 'package:shop_app/screens/Login/loginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/boardingModel.dart';
import '../styles/color.dart';
import '../widget/buildBondingWidget.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingData = [
    BoardingModel(
      title: 'On Board 1 Title',
      image: 'assets/image/onBoarding.png',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      title: 'On Board 2 Title',
      image: 'assets/image/onBoarding.png',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      title: 'On Board 3 Title',
      image: 'assets/image/onBoarding.png',
      body: 'On Board 3 Body',
    ),
  ];

  var boardingController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: "OnBoarding", value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                "SKIP",
                style: TextStyle(
                    color: mainColor, fontSize: 18, fontFamily: 'Quicksand'),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                onPageChanged: (index) {
                  if (index == boardingData.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBondingWidget(boardingData[index]),
                itemCount: boardingData.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingData.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: mainColor,
                      expansionFactor: 4,
                      spacing: 4,
                      dotHeight: 10,
                      dotWidth: 10),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: mainColor,
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
