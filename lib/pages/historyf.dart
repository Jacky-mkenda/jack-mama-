import 'dart:developer';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/pages/historydetails.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/provider/historyprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryF extends StatefulWidget {
  const HistoryF({Key? key}) : super(key: key);

  @override
  State<HistoryF> createState() => _HistoryFState();
}

class _HistoryFState extends State<HistoryF> {
  @override
  void initState() {
    final historyProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    historyProvider.getMedicineHistory();
    super.initState();
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
          child: historyList(),
        ),
      ),
    );
  }

  Widget historyList() {
    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, child) {
        if (!historyProvider.loading) {
          if (historyProvider.appointmentModel.status == 200 &&
              historyProvider.appointmentModel.result != null) {
            if (historyProvider.appointmentModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: historyProvider.appointmentModel.result!.length,
                itemBuilder: (BuildContext context, int position) {
                  return Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        log("Item Clicked!");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HistoryDetails(
                                historyProvider.appointmentModel.result,
                                position),
                          ),
                        );
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 60),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                MyText(
                                                  mTitle: historyProvider
                                                          .appointmentModel
                                                          .result!
                                                          .elementAt(position)
                                                          .doctorName ??
                                                      "",
                                                  mFontSize: 14,
                                                  mFontWeight: FontWeight.bold,
                                                  mTextAlign: TextAlign.start,
                                                  mTextColor: textTitleColor,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    MyText(
                                                      mTitle: historyProvider
                                                              .appointmentModel
                                                              .result!
                                                              .elementAt(
                                                                  position)
                                                              .specialitiesName ??
                                                          "",
                                                      mFontSize: 12,
                                                      mFontWeight:
                                                          FontWeight.normal,
                                                      mTextAlign:
                                                          TextAlign.start,
                                                      mTextColor:
                                                          otherLightColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Container(
                                                      width: 4,
                                                      height: 4,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: otherLightColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    MyText(
                                                      mTitle: historyProvider
                                                                  .appointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pending
                                                          : (historyProvider
                                                                      .appointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approved
                                                              : (historyProvider
                                                                          .appointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejected
                                                                  : historyProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absent
                                                                      : (historyProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                              "5"
                                                                          ? completed
                                                                          : "-"))),
                                                      mFontSize: 12,
                                                      mFontWeight:
                                                          FontWeight.normal,
                                                      mTextAlign:
                                                          TextAlign.start,
                                                      mTextColor: historyProvider
                                                                  .appointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pendingStatus
                                                          : (historyProvider
                                                                      .appointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approvedStatus
                                                              : (historyProvider
                                                                          .appointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejectedStatus
                                                                  : historyProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absentStatus
                                                                      : (historyProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                              "5"
                                                                          ? completedStatus
                                                                          : black))),
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
                                              mTitle:
                                                  '${Utility.formateDate((historyProvider.appointmentModel.result!.elementAt(position).date ?? "").toString())} at ${Utility.formateTime((historyProvider.appointmentModel.result!.elementAt(position).startTime ?? ""))} - ${Utility.formateTime((historyProvider.appointmentModel.result!.elementAt(position).endTime ?? ""))}',
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
                                              const MySvgAssetsImg(
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
                                                  mTitle: historyProvider
                                                          .appointmentModel
                                                          .result!
                                                          .elementAt(position)
                                                          .description ??
                                                      "",
                                                  mFontSize: 12,
                                                  mMaxLine: 1,
                                                  mOverflow:
                                                      TextOverflow.ellipsis,
                                                  mFontWeight:
                                                      FontWeight.normal,
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
                                    // CupertinoButton(
                                    //   minSize: double.minPositive,
                                    //   padding: EdgeInsets.zero,
                                    //   child: const MySvgAssetsImg(
                                    //     imageName: "delete.svg",
                                    //     fit: BoxFit.cover,
                                    //     imgHeight: 25,
                                    //     imgWidth: 25,
                                    //   ),
                                    //   onPressed: () {
                                    //     log("on Delete Click!");
                                    //   },
                                    // ),
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
                                imageUrl: historyProvider
                                        .appointmentModel.result
                                        ?.elementAt(position)
                                        .doctorImage
                                        .toString() ??
                                    Constant.userPlaceholder,
                                fit: BoxFit.fill,
                                imgHeight: 61,
                                imgWidth: 54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const NoData();
            }
          } else {
            return const NoData();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }
}
