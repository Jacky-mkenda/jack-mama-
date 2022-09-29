import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: Utility.appBarCommon(notifications),
      body: SizedBox(
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
            child: buildNotification(),
          ),
        ),
      ),
    );
  }

  Widget buildNotification() {
    return AlignedGridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 14,
      crossAxisCount: 1,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Constant.dummyDataList.length,
      itemBuilder: (BuildContext context, int position) => Container(
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              clipBehavior: Clip.antiAlias,
              child: MyNetworkImage(
                imageUrl: Constant.dummyDataList.elementAt(position).imageUrl,
                fit: BoxFit.cover,
                imgHeight: 50,
                imgWidth: 50,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyText(
                    mTitle: Constant.dummyDataList.elementAt(position).title,
                    mTextAlign: TextAlign.start,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mFontSize: 16,
                    mTextColor: textTitleColor,
                    mFontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    mTitle: Constant.dummyDataList.elementAt(position).subTitle,
                    mTextAlign: TextAlign.start,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mFontSize: 14,
                    mTextColor: otherColor,
                    mFontWeight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    mTitle: Constant.dummyDataList.elementAt(position).date,
                    mTextAlign: TextAlign.start,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mFontSize: 12,
                    mTextColor: primaryColor,
                    mFontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
