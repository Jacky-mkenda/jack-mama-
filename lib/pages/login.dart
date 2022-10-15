import 'dart:developer';

import 'package:patientapp/pages/forgotpassword.dart';
import 'package:patientapp/pages/registration.dart';
import 'package:patientapp/pages/sidedrawer.dart';
import 'package:patientapp/provider/generalprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/myassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:patientapp/widgets/mytextformfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ProgressDialog prDialog;
  SharedPre sharePref = SharedPre();
  final _formKey = GlobalKey<FormState>();
  late bool isPrivacyChecked, _passwordVisible;
  final mEmailController = TextEditingController();
  final mPasswordController = TextEditingController();
  dynamic email, password, type, deviceToken;
  late GeneralProvider generalProvider;

  @override
  void initState() {
    isPrivacyChecked = false;
    _passwordVisible = false;
    prDialog = ProgressDialog(context);
    super.initState();
  }

  @override
  void dispose() {
    mEmailController.dispose();
    mPasswordController.dispose();
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
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: MyAssetsImg(
                      imageName: "login_icon.png",
                      fit: BoxFit.contain,
                      imgWidth: MediaQuery.of(context).size.width * 0.43,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
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
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, right: 20),
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            mTitle: signIn,
                            mTextColor: textTitleColor,
                            mTextAlign: TextAlign.start,
                            mFontWeight: FontWeight.w800,
                            mFontSize: 32,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            mTitle: welcomeBack,
                            mTextColor: otherColor,
                            mTextAlign: TextAlign.start,
                            mFontWeight: FontWeight.w500,
                            mFontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      height: Constant.textFieldHeight,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      decoration:
                                          Utility.textFieldBGWithBorder(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
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
                                      height: 10,
                                    ),
                                    Container(
                                      height: Constant.textFieldHeight,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      decoration:
                                          Utility.textFieldBGWithBorder(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Expanded(
                                            child: MyTextFormField(
                                              mHint: passwordReq,
                                              mObscureText: _passwordVisible,
                                              mController: mPasswordController,
                                              mHintTextColor: textHintColor,
                                              mMaxLine: 1,
                                              mTextColor: otherColor,
                                              mInputBorder: InputBorder.none,
                                              mkeyboardType:
                                                  TextInputType.visiblePassword,
                                              mTextInputAction:
                                                  TextInputAction.done,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _passwordVisible =
                                                        !_passwordVisible;
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: otherColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    privacyCheckBox(),
                                    loginButton(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    forgotPassClick(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        goToRegistration(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void clearTextFormField() {
    mEmailController.clear();
    mPasswordController.clear();
  }

  Widget privacyCheckBox() {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
              checkColor: white,
              activeColor: accentColor,
              splashRadius: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              value: isPrivacyChecked,
              onChanged: (bool? value) {
                log("onChanged value => $value");
                setState(
                  () {
                    isPrivacyChecked = value!;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Utility.htmlTexts(privacyPolicyCheckBoxText),
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return InkWell(
      focusColor: primaryColor,
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MySideDrawer()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: Constant.buttonHeight,
        decoration: Utility.primaryButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: login.toUpperCase(),
          mTextColor: white,
          mTextAlign: TextAlign.center,
          mFontSize: 16,
          mFontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget forgotPassClick() {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        log("$forgotPassword tapped!");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ForgotPassword()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: MyText(
            mTitle: forgotPassword,
            mTextColor: otherLightColor,
            mTextAlign: TextAlign.start,
            mFontWeight: FontWeight.w500,
            mFontSize: 16),
      ),
    );
  }

  Widget goToRegistration() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: RichText(
        text: TextSpan(
          text: dontHaveAccount,
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
              text: signUpNow.toUpperCase(),
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
                  log("$signUpNow tapped!");
                  clearTextFormField();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Registration()));
                },
            ),
          ],
        ),
      ),
    );
  }

  bool validatePassword(String? value) {
    if (value == null || value.isEmpty || (value.length < 5)) {
      return true;
    } else {
      return false;
    }
  }

  void validateFormData() async {
    final isValidForm = _formKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      email = mEmailController.text.toString().trim();
      password = mPasswordController.text.toString().trim();
      type = "1";
      deviceToken = "123456789";
      log("Email => $email");
      log("Password => $password");
      log("type => $type");
      log("deviceToken => $deviceToken");
      log("isPrivacyChecked => $isPrivacyChecked");

      if (mEmailController.text.isEmpty) {
        Utility.showToast(enterEmail);
      } else if (mPasswordController.text.isEmpty) {
        Utility.showToast(enterPassword);
      } else if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
      } else if (mPasswordController.text.length < 6) {
        Utility.showToast("$enterMinimumCharacters in $password");
      } else if (!isPrivacyChecked) {
        Utility.showToast(acceptPrivacyPolicyMsg);
      } else {
        generalProvider = Provider.of<GeneralProvider>(context, listen: false);
        // doctor_login API call
        Utility.showProgress(context, prDialog);
        await generalProvider.loginDoctor(email, password, type, deviceToken);

        checkAndNavigate();
      }
    }
  }

  void checkAndNavigate() {
    log('checkAndNavigate loading ==>> ${generalProvider.loading}');
    if (!generalProvider.loading) {
      // Hide Progress Dialog
      prDialog.hide();

      if (generalProvider.loginRegisterModel.status == 200) {
        log('loginRegisterModel ==>> ${generalProvider.loginRegisterModel.toString()}');
        log('Login Successfull!');
        for (var i = 0;
            i < generalProvider.loginRegisterModel.result!.length;
            i++) {
          sharePref.save(
              "userid", generalProvider.loginRegisterModel.result![i].id);
          sharePref.save("firstname",
              generalProvider.loginRegisterModel.result![i].firstName);
          sharePref.save("lastname",
              generalProvider.loginRegisterModel.result![i].lastName);
          sharePref.save("image",
              generalProvider.loginRegisterModel.result![i].profileImg);
          sharePref.save(
              "email", generalProvider.loginRegisterModel.result![i].email);
          sharePref.save("password",
              generalProvider.loginRegisterModel.result![i].password);
          sharePref.save("mobile",
              generalProvider.loginRegisterModel.result![i].mobileNumber);
          sharePref.save(
              "type", generalProvider.loginRegisterModel.result![i].type);
          sharePref.save(
              "status", generalProvider.loginRegisterModel.result![i].status);
        }

        // Set UserID for Next
        Constant.userID =
            generalProvider.loginRegisterModel.result![0].id ?? "";
        log('Constant userID ==>> ${Constant.userID}');

        Utility.setFirstTime();
        clearTextFormField();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MySideDrawer(),
          ),
        );
      } else {
        Utility.showSnackbar(
            context, "${generalProvider.loginRegisterModel.message}");
      }
    }
  }
}
