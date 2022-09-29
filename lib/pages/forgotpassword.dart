import 'dart:developer';

import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constant.dart';
import '../widgets/myassetsimg.dart';
import '../widgets/mytext.dart';
import '../widgets/mytextformfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final mEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        MyAssetsImg(
          imageName: "login_bg.png",
          fit: BoxFit.fill,
          imgHeight: MediaQuery.of(context).size.height,
          imgWidth: MediaQuery.of(context).size.width,
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: statusBarColor,
          appBar: Utility.appBarCommon(forgotPasswordTitle),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25),
                child: MyAssetsImg(
                  imgWidth: MediaQuery.of(context).size.width * 0.4,
                  imgHeight: MediaQuery.of(context).size.height * 0.35,
                  imageName: "login_icon.png",
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: appBgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MyText(
                                    mTitle: forgotPassNote,
                                    mFontSize: 16,
                                    mFontStyle: FontStyle.normal,
                                    mFontWeight: FontWeight.normal,
                                    mTextAlign: TextAlign.center,
                                    mTextColor: otherColor,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    height: Constant.textFieldHeight,
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: Utility.textFieldBGWithBorder(),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: MyTextFormField(
                                            mHint: emailAddressReq,
                                            mController: mEmailController,
                                            mObscureText: false,
                                            mMaxLine: 1,
                                            mHintTextColor: textHintColor,
                                            mTextColor: otherColor,
                                            mkeyboardType:
                                                TextInputType.emailAddress,
                                            mTextInputAction:
                                                TextInputAction.next,
                                            mInputBorder: InputBorder.none,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.email,
                                              color: otherColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  sendButton(),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      goToLogin(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget sendButton() {
    return InkWell(
      focusColor: primaryColor,
      onTap: () => validateFormData(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: Constant.buttonHeight,
        decoration: Utility.primaryDarkButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: send.toUpperCase(),
          mTextColor: white,
          mTextAlign: TextAlign.center,
          mFontSize: 16,
          mFontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget goToLogin() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: RichText(
        text: TextSpan(
          text: alreadyHaveAccount,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: otherLightColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
          children: <TextSpan>[
            TextSpan(
              text: loginFSpace.toUpperCase(),
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: primaryDarkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  log("$loginFSpace tapped!");
                  Navigator.of(context).pop();
                },
            ),
          ],
        ),
      ),
    );
  }

  void validateFormData() async {
    final isValidForm = _formKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      log("Email => ${mEmailController.text}");

      if (mEmailController.text.isEmpty) {
        Utility.showToast(enterEmail);
        return;
      }
      if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
        return;
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password has been send Successfully!')),
      );

      await showMyDialog();
    }
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Forgot Password Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: "Email : ${mEmailController.text}",
                  mTextColor: black,
                  mFontSize: 16,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: okay,
                mTextColor: primaryDarkColor,
                mFontSize: 20,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                log("$okay tapped!");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
