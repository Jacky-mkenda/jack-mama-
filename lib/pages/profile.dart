import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:patientapp/pages/editprofile.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';

import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/widgets/mytext.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
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
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            clipBehavior: Clip.antiAlias,
            child: MyNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
              fit: BoxFit.cover,
              imgHeight: 80,
              imgWidth: 80,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          MyText(
            mTitle: "Erena Grills",
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
        child: Column(
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
              mTitle: "john.marshal@gmail.com",
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
              mTitle: "The Johns Hopkins Hospital Baltimore, MD.",
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
              mTitle: "1988/05/08",
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
              mTitle: "Jubilee Insurance",
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
              mTitle: "AGI23457",
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
              mTitle: "1617259783.jpeg",
              mFontSize: 14,
              mMaxLine: 2,
              mOverflow: TextOverflow.ellipsis,
              mFontWeight: FontWeight.w500,
              mFontStyle: FontStyle.normal,
              mTextAlign: TextAlign.start,
              mTextColor: textTitleColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget bmiDetailTab() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
              mTitle: "Skin problem when I take capsules",
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
              mTitle: "65",
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
              mTitle: "172",
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
              mTitle:
                  "BMI is 21.97 and you are in the healthy weight BMI range!",
              mFontSize: 14,
              mMaxLine: 5,
              mOverflow: TextOverflow.ellipsis,
              mFontWeight: FontWeight.w500,
              mFontStyle: FontStyle.normal,
              mTextAlign: TextAlign.start,
              mTextColor: textTitleColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget qrCodeTab() {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(8),
          color: white,
          child: MyNetworkImage(
            imageUrl:
                "https://api.qrserver.com/v1/create-qr-code/?size=185x185&ecc=L&qzone=1&data=http%3A%2F%2Fwww.example.org",
            fit: BoxFit.cover,
            imgHeight: MediaQuery.of(context).size.height * 0.25,
            imgWidth: MediaQuery.of(context).size.width * 0.5,
          )),
    );
  }
}
