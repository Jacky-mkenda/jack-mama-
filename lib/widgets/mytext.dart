import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String mTitle;
  final double? mFontSize;
  final dynamic mFontWeight,
      mFontStyle,
      mTextColor,
      mTextAlign,
      mMaxLine,
      mOverflow,
      mLetterSpacing;

  const MyText(
      {Key? key,
      required this.mTitle,
      this.mFontSize,
      this.mFontWeight,
      this.mFontStyle,
      this.mTextColor,
      this.mTextAlign,
      this.mMaxLine,
      this.mOverflow,
      this.mLetterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        mTitle,
        textAlign: mTextAlign,
        maxLines: mMaxLine,
        overflow: mOverflow,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            fontSize: mFontSize,
            color: mTextColor,
            fontWeight: mFontWeight,
            fontStyle: mFontStyle,
            letterSpacing: mLetterSpacing,
          ),
        ),
      ),
    );
  }
}
