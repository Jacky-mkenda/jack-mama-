import 'dart:developer';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:patientapp/pages/allfeedback.dart';
import 'package:patientapp/pages/bookappointment.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  final mAddCommentController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mAddCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: Utility.appBarCommon(doctorDetails),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      clipBehavior: Clip.antiAlias,
                      child: MyNetworkImage(
                        imageUrl:
                            "https://images.unsplash.com/photo-1607990283143-e81e7a2c9349?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTUwfHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
                        fit: BoxFit.fill,
                        imgHeight: 66,
                        imgWidth: 66,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyText(
                              mTitle: "Dr. Emily Anderson",
                              mTextAlign: TextAlign.start,
                              mTextColor: textTitleColor,
                              mFontSize: 15,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            MyText(
                              mTitle: "Dentist",
                              mTextAlign: TextAlign.start,
                              mTextColor: otherLightColor,
                              mFontSize: 14,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.w400,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RatingBarIndicator(
                                  rating: 4.5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: starColor,
                                  ),
                                  itemPadding: const EdgeInsets.only(right: 1),
                                  itemCount: 5,
                                  itemSize: 12,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                MyText(
                                  mTitle: "(120 $reviews)",
                                  mTextAlign: TextAlign.start,
                                  mTextColor: otherLightColor,
                                  mFontSize: 12,
                                  mFontStyle: FontStyle.normal,
                                  mFontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                log('Tapped on $seeAllReviews');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AllFeedback()));
                              },
                              child: MyText(
                                mTitle: seeAllReviews,
                                mMaxLine: 3,
                                mOverflow: TextOverflow.ellipsis,
                                mTextAlign: TextAlign.start,
                                mTextColor: accentColor,
                                mFontSize: 14,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        log('Clicked on call!');
                        Utility.launchPhoneDialer('9913269834');
                      },
                      child: MySvgAssetsImg(
                        imageName: "mobile_dark.svg",
                        fit: BoxFit.cover,
                        imgHeight: 38,
                        imgWidth: 38,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyText(
                      mTitle: contactNo,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "+91 9632587410",
                      mFontSize: 14,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyText(
                      mTitle: address,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "The Johns Hopkins Hospital Baltimore, MD.",
                      mFontSize: 14,
                      mMaxLine: 5,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyText(
                      mTitle: aboutUs,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "Specialist of Dentist.",
                      mFontSize: 14,
                      mMaxLine: 3,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyText(
                      mTitle: workingTime,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "10:30 am to 11:00 am",
                      mFontSize: 14,
                      mMaxLine: 2,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyText(
                      mTitle: services,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      mFontSize: 14,
                      mMaxLine: 5,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyText(
                      mTitle: healthCare,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      mFontSize: 14,
                      mMaxLine: 5,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 65,
              ),
              Visibility(
                visible: true,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    log("Tapped on $makeAnAppointment");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BookAppointment()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: Constant.buttonHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.rectangle,
                    ),
                    child: MyText(
                      mTitle: makeAnAppointment,
                      mFontSize: 16,
                      mOverflow: TextOverflow.ellipsis,
                      mFontStyle: FontStyle.normal,
                      mFontWeight: FontWeight.w600,
                      mMaxLine: 1,
                      mTextAlign: TextAlign.center,
                      mTextColor: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
