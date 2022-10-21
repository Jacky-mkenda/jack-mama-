import 'dart:developer';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';

class AllFeedback extends StatefulWidget {
  const AllFeedback({
    Key? key,
  }) : super(key: key);

  @override
  State<AllFeedback> createState() => _AllFeedbackState();
}

class _AllFeedbackState extends State<AllFeedback> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: Utility.myAppBar(context, feedback),
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const MyText(
                          mTitle: '4.5',
                          mFontSize: 32,
                          mFontWeight: FontWeight.bold,
                          mFontStyle: FontStyle.normal,
                          mTextAlign: TextAlign.start,
                          mTextColor: accentColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RatingBar(
                              initialRating: 4,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemSize: 15,
                              ratingWidget: RatingWidget(
                                full: const MySvgAssetsImg(
                                  imageName: 'star_full.svg',
                                  fit: BoxFit.cover,
                                ),
                                half: const MySvgAssetsImg(
                                  imageName: 'star_border.svg',
                                  fit: BoxFit.cover,
                                ),
                                empty: const MySvgAssetsImg(
                                  imageName: 'star_border.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              onRatingUpdate: (rating) {
                                log('$rating');
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const MyText(
                              mTitle: '1090 ratings',
                              mFontSize: 14,
                              mFontWeight: FontWeight.normal,
                              mFontStyle: FontStyle.normal,
                              mTextAlign: TextAlign.start,
                              mTextColor: textTitleColor,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AlignedGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  padding: const EdgeInsets.all(20),
                  mainAxisSpacing: 20,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int position) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RatingBarIndicator(
                        rating: 4.5,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: starColor,
                        ),
                        itemPadding: const EdgeInsets.only(right: 1),
                        itemCount: 5,
                        itemSize: 15,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const MyText(
                        mTitle:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                        mFontSize: 14,
                        mFontWeight: FontWeight.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: otherColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
