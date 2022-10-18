import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:patientapp/pages/editprofile.dart';
import 'package:patientapp/provider/profileprovider.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';

import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getPatientProfile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: loginRegBGColor,
      appBar: myAppBar(),
      body: SizedBox(
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  clipBehavior: Clip.antiAlias,
                  child: MyNetworkImage(
                    imageUrl: !profileProvider.loading
                        ? profileProvider.profileModel.status == 200
                            ? profileProvider.profileModel.result != null
                                ? profileProvider
                                        .profileModel.result!.isNotEmpty
                                    ? (profileProvider.profileModel.result!
                                            .elementAt(0)
                                            .profileImg ??
                                        Constant.userPlaceholder)
                                    : Constant.userPlaceholder
                                : Constant.userPlaceholder
                            : Constant.userPlaceholder
                        : Constant.userPlaceholder,
                    fit: BoxFit.cover,
                    imgHeight: 80,
                    imgWidth: 80,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                MyText(
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? ("${profileProvider.profileModel.result!.elementAt(0).firstName} ${profileProvider.profileModel.result!.elementAt(0).lastName}")
                                  : guestUser
                              : guestUser
                          : guestUser
                      : guestUser,
                  mFontSize: 16,
                  mMaxLine: 2,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w700,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: white,
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: Container(
                    decoration: Utility.topRoundBG(),
                    child: buildProfileTabs(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: statusBarColor,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: MySvgAssetsImg(
          imageName: "back.svg",
          fit: BoxFit.contain,
          imgHeight: 15,
          imgWidth: 19,
        ),
      ),
      title: MyText(
        mTitle: profile,
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            log('EditProfile pressed!');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfile()));
          },
          icon: MySvgAssetsImg(
            imageName: 'edit_icon.svg',
            fit: BoxFit.cover,
            imgWidth: 23,
            imgHeight: 23,
          ),
        ),
      ],
    );
  }

  Widget buildProfileTabs() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TabBar(
              isScrollable: false,
              labelColor: primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: accentColor,
              indicatorWeight: 1,
              labelPadding: const EdgeInsets.only(top: 5, bottom: 5),
              indicatorPadding: const EdgeInsets.all(0),
              unselectedLabelColor: tabDefaultColor,
              tabs: <Widget>[
                Tab(
                  child: MyText(
                    mTitle: personal,
                    mFontSize: 15,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.w600,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mTextAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: MyText(
                    mTitle: bMI,
                    mFontSize: 15,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.w600,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mTextAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: MyText(
                    mTitle: qrCode,
                    mFontSize: 15,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.w600,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mTextAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: boxBorderColor,
          ),
          Expanded(
            child: TabBarView(
              children: [
                personalDetailTab(),
                bmiDetailTab(),
                qrCodeTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget personalDetailTab() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return Column(
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .mobileNumber!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                              .elementAt(0)
                                              .mobileNumber ??
                                          "")
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: emailAddress,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .email!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                              .elementAt(0)
                                              .email ??
                                          "-")
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 1,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .location!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                              .elementAt(0)
                                              .location ??
                                          "-")
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 5,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: birthDate,
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
                  mTitle: "-",
                  mFontSize: 14,
                  mMaxLine: 1,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: insuranceCompanyName,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .insuranceCompanyName!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                              .elementAt(0)
                                              .insuranceCompanyName ??
                                          "-")
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 2,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: insuranceNumber,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .insuranceNo!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                              .elementAt(0)
                                              .insuranceNo ??
                                          "-")
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 2,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: insuranceImage,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? (profileProvider.profileModel.result!
                                      .elementAt(0)
                                      .insuranceCardPic
                                      .toString()
                                      .split("/")
                                      .last)
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 2,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget bmiDetailTab() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyText(
                  mTitle: allergiesToMedicine,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .allergiesToMedicine!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .allergiesToMedicine
                                          .toString())
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 3,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: weight,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .currentWeight!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                              .elementAt(0)
                                              .currentWeight ??
                                          "-")
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 1,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: height,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? profileProvider.profileModel.result!
                                          .elementAt(0)
                                          .currentHeight!
                                          .isNotEmpty
                                      ? (profileProvider.profileModel.result!
                                              .elementAt(0)
                                              .currentHeight ??
                                          "-")
                                      : "-"
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 5,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: bMIWithFullForm,
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
                  mTitle: !profileProvider.loading
                      ? profileProvider.profileModel.status == 200
                          ? profileProvider.profileModel.result != null
                              ? profileProvider.profileModel.result!.isNotEmpty
                                  ? (Utility.calculateBMI(
                                      profileProvider.profileModel.result
                                              ?.elementAt(0)
                                              .currentWeight
                                              .toString() ??
                                          "",
                                      profileProvider.profileModel.result
                                              ?.elementAt(0)
                                              .currentHeight
                                              .toString() ??
                                          ""))
                                  : "-"
                              : "-"
                          : "-"
                      : "-",
                  mFontSize: 14,
                  mMaxLine: 5,
                  mOverflow: TextOverflow.ellipsis,
                  mFontWeight: FontWeight.w500,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget qrCodeTab() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        color: white,
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return MyNetworkImage(
              imageUrl: !profileProvider.loading
                  ? profileProvider.profileModel.status == 200
                      ? profileProvider.profileModel.result != null
                          ? profileProvider.profileModel.result!.isNotEmpty
                              ? (profileProvider.profileModel.result
                                      ?.elementAt(0)
                                      .patientsQrcodeImg
                                      .toString() ??
                                  "")
                              : ""
                          : ""
                      : ""
                  : "",
              fit: BoxFit.cover,
              imgHeight: MediaQuery.of(context).size.height * 0.25,
              imgWidth: MediaQuery.of(context).size.width * 0.5,
            );
          },
        ),
      ),
    );
  }
}
