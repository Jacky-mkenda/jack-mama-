import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/pages/appointmentdetails.dart';
import 'package:patientapp/pages/bookappointment.dart';
import 'package:patientapp/pages/doctordetails.dart';
import 'package:patientapp/pages/historydetails.dart';
import 'package:patientapp/pages/viewall.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/widgets/mytextformfield.dart';

class HomeF extends StatefulWidget {
  const HomeF({Key? key}) : super(key: key);

  @override
  State<HomeF> createState() => _HomeFState();
}

class _HomeFState extends State<HomeF> {
  final mSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          decoration: Utility.topRoundBG(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: 'Hi, Divinetechs',
                      mTextColor: textTitleColor,
                      mTextAlign: TextAlign.start,
                      mFontWeight: FontWeight.normal,
                      mFontSize: 20,
                    ),
                    MyText(
                      mTitle: welcomeBack,
                      mTextColor: textTitleColor,
                      mTextAlign: TextAlign.start,
                      mFontWeight: FontWeight.bold,
                      mFontSize: 22,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 50,
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 15,
                      spreadRadius: 2,
                      color: shadowColor.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: MyTextFormField(
                        mHint: "Search...",
                        mController: mSearchController,
                        mHintTextColor: textEdtHintColor,
                        mObscureText: false,
                        mTextAlign: TextAlign.start,
                        mMaxLine: 1,
                        mTextColor: textTitleColor,
                        mkeyboardType: TextInputType.text,
                        mTextInputAction: TextInputAction.done,
                        mInputBorder: InputBorder.none,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                      ),
                      child: MySvgAssetsImg(
                        imageName: 'search.svg',
                        imgHeight: 18,
                        imgWidth: 18,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    MyText(
                      mTitle: speciality,
                      mFontSize: 16,
                      mFontWeight: FontWeight.bold,
                      mOverflow: TextOverflow.ellipsis,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    InkWell(
                      onTap: () {
                        log("Tapped on $seeAll");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewAll(
                                  appBarTitle: speciality,
                                  layoutType: "Speciality",
                                )));
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: MyText(
                        mTitle: seeAll,
                        mFontSize: 16,
                        mFontWeight: FontWeight.normal,
                        mOverflow: TextOverflow.ellipsis,
                        mTextAlign: TextAlign.end,
                        mTextColor: textSeeAllColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 90,
                child: specialityList(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    MyText(
                      mTitle: upcomingAppointments,
                      mFontSize: 16,
                      mFontWeight: FontWeight.bold,
                      mOverflow: TextOverflow.ellipsis,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    InkWell(
                      onTap: () {
                        log("Tapped on $seeAll");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewAll(
                                  appBarTitle: upcomingAppointments,
                                  layoutType: "Appointment",
                                )));
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: MyText(
                        mTitle: seeAll,
                        mFontSize: 16,
                        mFontWeight: FontWeight.normal,
                        mOverflow: TextOverflow.ellipsis,
                        mTextAlign: TextAlign.end,
                        mTextColor: textSeeAllColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 105,
                child: upcomingAppintmentList(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    MyText(
                      mTitle: upcomingTests,
                      mFontSize: 16,
                      mFontWeight: FontWeight.bold,
                      mOverflow: TextOverflow.ellipsis,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    InkWell(
                      onTap: () {
                        log("Tapped on $seeAll");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewAll(
                                  appBarTitle: upcomingTests,
                                  layoutType: "Test",
                                )));
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: MyText(
                        mTitle: seeAll,
                        mFontSize: 16,
                        mFontWeight: FontWeight.normal,
                        mOverflow: TextOverflow.ellipsis,
                        mTextAlign: TextAlign.end,
                        mTextColor: textSeeAllColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 125,
                // constraints:
                // const BoxConstraints(minHeight: 120, maxHeight: 250),
                child: upcomingTestList(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    MyText(
                      mTitle: availableDoctors,
                      mFontSize: 16,
                      mFontWeight: FontWeight.bold,
                      mOverflow: TextOverflow.ellipsis,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    InkWell(
                      onTap: () {
                        log("Tapped on $seeAll");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewAll(
                                  appBarTitle: availableDoctors,
                                  layoutType: "Doctors",
                                )));
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: MyText(
                        mTitle: seeAll,
                        mFontSize: 16,
                        mFontWeight: FontWeight.normal,
                        mOverflow: TextOverflow.ellipsis,
                        mTextAlign: TextAlign.end,
                        mTextColor: textSeeAllColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: availableDoctorList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget specialityList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 20, right: 20),
      scrollDirection: Axis.horizontal,
      itemCount: Constant.dummyDataList.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 12,
      ),
      itemBuilder: (BuildContext context, int position) => InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          log("Item Clicked! => $position");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ViewAll(
                    appBarTitle: availableDoctors,
                    layoutType: 'Doctors',
                  )));
        },
        child: Container(
          width: 80,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image:
                  ExactAssetImage(Constant.gradientBG.elementAt(position % 8)),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MyNetworkImage(
                imageUrl: Constant.dummyDataList.elementAt(position).specImage,
                fit: BoxFit.cover,
                imgHeight: 32,
                imgWidth: 32,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: MyText(
                  mTitle: Constant.dummyDataList.elementAt(position).speciality,
                  mFontSize: 12,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.normal,
                  mTextAlign: TextAlign.center,
                  mTextColor: white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget upcomingAppintmentList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 18, right: 18),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 3,
      ),
      itemCount: Constant.dummyDataList.length,
      itemBuilder: (BuildContext context, int position) => Container(
        padding: const EdgeInsets.only(top: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            log("Item Clicked!");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AppointmentDetails()));
          },
          child: Stack(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 82,
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  color: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 60),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    MyText(
                                      mTitle: Constant.dummyDataList
                                          .elementAt(position)
                                          .title,
                                      mFontSize: 14,
                                      mFontWeight: FontWeight.bold,
                                      mTextAlign: TextAlign.start,
                                      mTextColor: textTitleColor,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        MyText(
                                          mTitle: Constant.dummyDataList
                                              .elementAt(position)
                                              .speciality,
                                          mFontSize: 12,
                                          mFontWeight: FontWeight.normal,
                                          mTextAlign: TextAlign.start,
                                          mTextColor: otherLightColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: otherLightColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        MyText(
                                          mTitle: Constant.dummyDataList
                                              .elementAt(position)
                                              .status,
                                          mFontSize: 12,
                                          mFontWeight: FontWeight.normal,
                                          mTextAlign: TextAlign.start,
                                          mTextColor: pendingStatus,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: MyText(
                                  mTitle: Constant.dummyDataList
                                      .elementAt(position)
                                      .date,
                                  mFontSize: 13,
                                  mOverflow: TextOverflow.ellipsis,
                                  mMaxLine: 1,
                                  mFontWeight: FontWeight.normal,
                                  mTextAlign: TextAlign.start,
                                  mTextColor: textTitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CupertinoButton(
                          minSize: double.minPositive,
                          padding: EdgeInsets.zero,
                          child: MySvgAssetsImg(
                            imageName: "delete.svg",
                            fit: BoxFit.cover,
                            imgHeight: 25,
                            imgWidth: 25,
                          ),
                          onPressed: () {
                            log("on Delete Click!");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(12, -10, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  clipBehavior: Clip.antiAlias,
                  child: MyNetworkImage(
                    imageUrl:
                        Constant.dummyDataList.elementAt(position).imageUrl,
                    fit: BoxFit.fill,
                    imgHeight: 61,
                    imgWidth: 54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget upcomingTestList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 18, right: 18),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 3,
      ),
      itemCount: Constant.dummyDataList.length,
      itemBuilder: (BuildContext context, int position) => Container(
        padding: const EdgeInsets.only(top: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            log("Item Clicked!");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistoryDetails()));
          },
          child: Stack(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 82,
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  color: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 60),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    MyText(
                                      mTitle: Constant.dummyDataList
                                          .elementAt(position)
                                          .title,
                                      mFontSize: 14,
                                      mFontWeight: FontWeight.bold,
                                      mTextAlign: TextAlign.start,
                                      mTextColor: textTitleColor,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        MyText(
                                          mTitle: Constant.dummyDataList
                                              .elementAt(position)
                                              .speciality,
                                          mFontSize: 12,
                                          mFontWeight: FontWeight.normal,
                                          mTextAlign: TextAlign.start,
                                          mTextColor: otherLightColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: otherLightColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        MyText(
                                          mTitle: Constant.dummyDataList
                                              .elementAt(position)
                                              .status,
                                          mFontSize: 12,
                                          mFontWeight: FontWeight.normal,
                                          mTextAlign: TextAlign.start,
                                          mTextColor: pendingStatus,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: MyText(
                                  mTitle: Constant.dummyDataList
                                      .elementAt(position)
                                      .date,
                                  mFontSize: 13,
                                  mOverflow: TextOverflow.ellipsis,
                                  mMaxLine: 1,
                                  mFontWeight: FontWeight.normal,
                                  mTextAlign: TextAlign.start,
                                  mTextColor: textTitleColor,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: <Widget>[
                                  MySvgAssetsImg(
                                    imageName: "test_desc.svg",
                                    fit: BoxFit.cover,
                                    imgHeight: 15,
                                    imgWidth: 15,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Flexible(
                                    child: MyText(
                                      mTitle: Constant.dummyDataList
                                          .elementAt(position)
                                          .testDesc,
                                      mFontSize: 12,
                                      mMaxLine: 1,
                                      mOverflow: TextOverflow.ellipsis,
                                      mFontWeight: FontWeight.normal,
                                      mTextAlign: TextAlign.start,
                                      mTextColor: otherColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CupertinoButton(
                          minSize: double.minPositive,
                          padding: EdgeInsets.zero,
                          child: MySvgAssetsImg(
                            imageName: "delete.svg",
                            fit: BoxFit.cover,
                            imgHeight: 25,
                            imgWidth: 25,
                          ),
                          onPressed: () {
                            log("on Delete Click!");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(12, -10, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  clipBehavior: Clip.antiAlias,
                  child: MyNetworkImage(
                    imageUrl:
                        Constant.dummyDataList.elementAt(position).imageUrl,
                    fit: BoxFit.fill,
                    imgHeight: 61,
                    imgWidth: 54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget availableDoctorList() {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 6,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
      itemCount: Constant.dummyDataList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int position) => InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          log("Item Clicked! => $position");
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DoctorDetails()));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.antiAlias,
          children: <Widget>[
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              color: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 215,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 145,
                      width: MediaQuery.of(context).size.width,
                      child: MyNetworkImage(
                        imageUrl:
                            Constant.dummyDataList.elementAt(position).imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 4),
                          MyText(
                            mTitle: Constant.dummyDataList
                                .elementAt(position)
                                .title,
                            mFontSize: 15,
                            mMaxLine: 1,
                            mOverflow: TextOverflow.ellipsis,
                            mFontWeight: FontWeight.normal,
                            mTextAlign: TextAlign.center,
                            mTextColor: textTitleColor,
                          ),
                          const SizedBox(height: 2),
                          MyText(
                            mTitle: Constant.dummyDataList
                                .elementAt(position)
                                .speciality,
                            mFontSize: 12,
                            mFontWeight: FontWeight.normal,
                            mMaxLine: 1,
                            mOverflow: TextOverflow.ellipsis,
                            mTextAlign: TextAlign.center,
                            mTextColor: otherColor,
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                log("Item Clicked! => $position");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BookAppointment()));
              },
              child: Container(
                transform: Matrix4.translationValues(0, 10, 0),
                padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                decoration: Utility.primaryButton(),
                clipBehavior: Clip.antiAlias,
                child: MyText(
                  mTitle: bookNow,
                  mFontSize: 12,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.normal,
                  mMaxLine: 1,
                  mOverflow: TextOverflow.ellipsis,
                  mTextColor: white,
                  mTextAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
