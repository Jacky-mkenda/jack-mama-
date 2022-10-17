import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/pages/viewall.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/widgets/myassetsimg.dart';
import 'package:flutter/material.dart';

class NoAppointments extends StatelessWidget {
  const NoAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
        ),
        constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        child: Column(
          children: [
            MyAssetsImg(
              imgWidth: MediaQuery.of(context).size.width,
              imgHeight: 120,
              fit: BoxFit.contain,
              imageName: "nodata.png",
            ),
            const SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                text: findBestDoctorsNearYouBySpeciality,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: otherColor,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: " $clickHere",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: accentColor,
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        log("$clickHere tapped!");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ViewAll(
                              appBarTitle: speciality,
                              layoutType: "Speciality",
                            ),
                          ),
                        );
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
