import 'dart:developer';

import 'package:patientapp/provider/forgotpasswordprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/widgets/myassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:patientapp/widgets/mytextformfield.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  final String viewFrom;
  const ForgotPassword(this.viewFrom, {Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late ProgressDialog prDialog;
  final _formKey = GlobalKey<FormState>();
  final mEmailController = TextEditingController();

  @override
  void initState() {
    prDialog = ProgressDialog(context);
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
                                  const MyText(
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
                      Visibility(
                        visible: widget.viewFrom == "Drawer" ? false : true,
                        child: goToLogin(),
                      ),
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
      String email = mEmailController.text.toString().trim();
      log("Email => ${mEmailController.text}");

      if (email.isEmpty) {
        Utility.showToast(enterEmail);
      } else if (!EmailValidator.validate(email)) {
        Utility.showToast(enterValidEmail);
      } else {
        final forgotPasswordProvider =
            Provider.of<ForgotPasswordProvider>(context, listen: false);
        Utility.showProgress(context, prDialog);
        // forgot_password API call
        await forgotPasswordProvider.getForgotPassword(email);
        if (!forgotPasswordProvider.loading) {
          // Hide Progress Dialog
          prDialog.hide();

          // ignore: use_build_context_synchronously
          Utility.showSnackbar(
              context, "${forgotPasswordProvider.successModel.message}");
          if (forgotPasswordProvider.successModel.status == 200) {
            clearTextFormField();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          }
        }
      }
    }
  }

  void clearTextFormField() {
    mEmailController.clear();
  }
}
