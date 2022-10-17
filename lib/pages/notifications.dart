import 'dart:developer';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/pages/appointmentdetails.dart';
import 'package:patientapp/provider/notificationprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  ProgressDialog? prDialog;

  @override
  void initState() {
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    notificationProvider.getPatientNotification();
    prDialog = ProgressDialog(context);
    super.initState();
  }

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
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, child) {
        if (!notificationProvider.loading) {
          if (notificationProvider.notificationModel.status == 200 &&
              notificationProvider.notificationModel.result != null) {
            if (notificationProvider.notificationModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    notificationProvider.notificationModel.result!.length,
                itemBuilder: (BuildContext context, int position) => Container(
                  padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: white,
                  ),
                  child: InkWell(
                    onTap: () {
                      log("Tapped on Notification at $position");
                      readAndViewNotification(
                          notificationProvider.notificationModel.result
                                  ?.elementAt(position)
                                  .id ??
                              "",
                          notificationProvider.notificationModel.result
                                  ?.elementAt(position)
                                  .appointmentId ??
                              "");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          clipBehavior: Clip.antiAlias,
                          child: MyNetworkImage(
                            imageUrl: notificationProvider
                                    .notificationModel.result
                                    ?.elementAt(position)
                                    .doctorProfileImg
                                    .toString() ??
                                Constant.userPlaceholder,
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
                                mTitle: notificationProvider
                                        .notificationModel.result
                                        ?.elementAt(position)
                                        .doctorName
                                        .toString() ??
                                    "",
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
                                mTitle: notificationProvider
                                        .notificationModel.result
                                        ?.elementAt(position)
                                        .title
                                        .toString() ??
                                    "",
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
                                mTitle: Utility.covertTimeToText(
                                    notificationProvider
                                            .notificationModel.result
                                            ?.elementAt(position)
                                            .createdAt
                                            .toString() ??
                                        ""),
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
                ),
              );
            } else {
              return Utility.pageLoader();
            }
          } else {
            return Utility.pageLoader();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }

  void readAndViewNotification(
      String notificationID, String appointmentID) async {
    log("notificationID ==> $notificationID");
    Utility.showProgress(context, prDialog!);
    final removeNotificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    await removeNotificationProvider.removeNotification(notificationID, "0");

    log("readAndViewNotification loading :==> ${removeNotificationProvider.loading}");
    if (!removeNotificationProvider.loading) {
      if (removeNotificationProvider.successModel.status == 200) {
        // Update Notification List
        if (!mounted) return;
        final notificationProvider =
            Provider.of<NotificationProvider>(context, listen: false);
        await notificationProvider.getPatientNotification();
        await prDialog!.hide();

        log("appointmentID : ==> $appointmentID");
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AppointmentDetails(appointmentID),
          ),
        );
      } else {
        await prDialog!.hide();
        if (!mounted) return;
        Utility.showSnackbar(
            context, removeNotificationProvider.successModel.message ?? "");
      }
    }
  }
}
