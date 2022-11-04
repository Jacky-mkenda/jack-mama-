import 'package:flutter/material.dart';
import 'package:patientapp/pages/login.dart';
import 'package:patientapp/pages/sidedrawer.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/myassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<String> introBigtext = <String>[
    intro1Title,
    intro2Title,
    intro3Title,
  ];

  List<String> introSmalltext = <String>[
    intro1Desc,
    intro2Desc,
    intro3Desc,
  ];

  List<String> introPager = <String>[
    "intro1.png",
    "intro2.png",
    "intro3.png",
  ];

  PageController pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  int pos = 0;
  SharedPre sharedPre = SharedPre();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: intoPageview(),
    );
  }

  Widget intoPageview() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: primaryColor,
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(18),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: introPager.length,
                            axisDirection: Axis.horizontal,
                            effect: const ExpandingDotsEffect(
                              spacing: 6,
                              radius: 10,
                              dotWidth: 7,
                              expansionFactor: 4,
                              dotHeight: 7,
                              dotColor: gray,
                              activeDotColor: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        PageView.builder(
          itemCount: introPager.length,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: MyAssetsImg(
                          imageName: introPager[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            MyText(
                              mTextColor: primaryColor,
                              mMaxLine: 4,
                              mOverflow: TextOverflow.ellipsis,
                              mTitle: introBigtext[index],
                              mTextAlign: TextAlign.center,
                              mFontSize: 30,
                              mFontWeight: FontWeight.w600,
                              mFontStyle: FontStyle.normal,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MyText(
                              mTextColor: gray,
                              mMaxLine: 8,
                              mTitle: introSmalltext[index],
                              mTextAlign: TextAlign.center,
                              mOverflow: TextOverflow.ellipsis,
                              mFontSize: 14,
                              mFontWeight: FontWeight.normal,
                              mFontStyle: FontStyle.normal,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          onPageChanged: (index) {
            pos = index;
            currentPageNotifier.value = index;
            debugPrint("pos:$pos");
            setState(() {});
          },
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Visibility(
                visible: (pos == introPager.length - 1) ? false : true,
                child: InkWell(
                  onTap: () {
                    if (pos == introPager.length - 1) {
                      Utility.setFirstTime();
                      if (Constant.userID != "") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MySideDrawer();
                            },
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Login();
                            },
                          ),
                        );
                      }
                    }
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: primaryDarkColor,
                        borderRadius: BorderRadius.all(Radius.circular(51))),
                    child: const MyAssetsImg(
                      imageName: "next_icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("pos :==> $pos");
                  Utility.setFirstTime();
                  if (Constant.userID != "") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MySideDrawer();
                        },
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Login();
                        },
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: MyText(
                    mTextColor: black,
                    mTitle: (pos == introPager.length - 1) ? finish : skip,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mFontSize: 16,
                    mFontWeight: FontWeight.w500,
                    mTextAlign: TextAlign.center,
                    mFontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: Visibility(
            visible: pos == 0 ? false : true,
            child: InkWell(
              onTap: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                width: 45,
                height: 45,
                alignment: Alignment.center,
                child: const MyAssetsImg(
                  imageName: "previous_icon.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
