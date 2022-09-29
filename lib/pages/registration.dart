import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:patientapp/pages/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/pages/sidedrawer.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';

import '../utils/constant.dart';
import '../utils/strings.dart';
import '../utils/utility.dart';
import '../utils/colors.dart';
import '../widgets/mytext.dart';
import '../widgets/mytextformfield.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  File? pickedImageFile;
  final ImagePicker imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late bool isPrivacyChecked, _passwordVisible;
  final mFirstNameController = TextEditingController();
  final mLastNameController = TextEditingController();
  final mEmailController = TextEditingController();
  final mPasswordController = TextEditingController();
  final mMobileController = TextEditingController();
  final mInsNoController = TextEditingController();
  final mInsNameController = TextEditingController();
  final mInsIMGController = TextEditingController();

  @override
  void initState() {
    isPrivacyChecked = false;
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    mFirstNameController.dispose();
    mLastNameController.dispose();
    mEmailController.dispose();
    mPasswordController.dispose();
    mMobileController.dispose();
    mInsNoController.dispose();
    mInsNameController.dispose();
    mInsIMGController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: loginRegBGColor,
      appBar: Utility.appBarCommon(signUp),
      body: Container(
        decoration: Utility.topRoundBG(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: MyTextFormField(
                            mHint: firstNameReq,
                            mController: mFirstNameController,
                            mObscureText: false,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: otherColor,
                            mkeyboardType: TextInputType.name,
                            mTextInputAction: TextInputAction.next,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: MyTextFormField(
                            mHint: lastNameReq,
                            mController: mLastNameController,
                            mObscureText: false,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: otherColor,
                            mkeyboardType: TextInputType.name,
                            mTextInputAction: TextInputAction.next,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: MyTextFormField(
                            mHint: emailAddressReq,
                            mController: mEmailController,
                            mObscureText: false,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: otherColor,
                            mkeyboardType: TextInputType.emailAddress,
                            mTextInputAction: TextInputAction.next,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: Row(
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
                                  mkeyboardType: TextInputType.visiblePassword,
                                  mTextInputAction: TextInputAction.done,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        _passwordVisible = !_passwordVisible;
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: MyTextFormField(
                            mHint: phoneNumberReq,
                            mController: mMobileController,
                            mObscureText: false,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: otherColor,
                            mkeyboardType: TextInputType.phone,
                            mTextInputAction: TextInputAction.next,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: MyTextFormField(
                            mHint: insuranceName,
                            mController: mInsNameController,
                            mObscureText: false,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: otherColor,
                            mkeyboardType: TextInputType.text,
                            mTextInputAction: TextInputAction.next,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: MyTextFormField(
                            mHint: insuranceNumber,
                            mController: mInsNoController,
                            mObscureText: false,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: otherColor,
                            mkeyboardType: TextInputType.text,
                            mTextInputAction: TextInputAction.done,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: Utility.textFieldBGWithBorder(),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: MyTextFormField(
                                  mHint: insuranceImage,
                                  mObscureText: false,
                                  mController: mInsIMGController,
                                  mHintTextColor: textHintColor,
                                  mMaxLine: 1,
                                  mReadOnly: true,
                                  mTextColor: otherColor,
                                  mInputBorder: InputBorder.none,
                                  mkeyboardType: TextInputType.text,
                                  mTextInputAction: TextInputAction.done,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    imagePickDialog();
                                  },
                                  icon: MySvgAssetsImg(
                                    imageName: "upload.svg",
                                    fit: BoxFit.cover,
                                    imgHeight: 20,
                                    imgWidth: 20,
                                    iconColor: otherColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        privacyCheckBox(),
                        signUpButton(),
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
    );
  }

  void clearTextFormField() {
    mFirstNameController.clear();
    mLastNameController.clear();
    mEmailController.clear();
    mPasswordController.clear();
    mMobileController.clear();
  }

  Future<void> imagePickDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: pickInsImageNote,
                  mTextColor: black,
                  mFontSize: 18,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: pickFromGallery,
                mTextColor: primaryDarkColor,
                mFontSize: 18,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.bold,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                getFromGallery();
              },
            ),
            TextButton(
              child: MyText(
                mTitle: captureByCamera,
                mTextColor: primaryDarkColor,
                mFontSize: 18,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.bold,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                getFromCamera();
              },
            ),
            TextButton(
              child: MyText(
                mTitle: cancel,
                mTextColor: black,
                mFontSize: 18,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.normal,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Get from gallery
  getFromGallery() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
        mInsIMGController.text = p.basename(pickedFile.path);
        log("Gallery ImageFile ==> ${pickedImageFile!.path}");
      });
    }
  }

  /// Get from Camera
  getFromCamera() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
        log("Camera ImageFile ==> ${pickedImageFile!.path}");
      });
    }
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
                print(value);
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

  Widget signUpButton() {
    return InkWell(
      focusColor: primaryColor,
      onTap: () => validateFormData(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: Constant.buttonHeight,
        decoration: Utility.primaryButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: signUp,
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
                  log(loginFSpace + " tapped!");
                  clearTextFormField();
                  Navigator.of(context).pop();
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
      log("FirstName => ${mFirstNameController.text}");
      log("LastName => ${mLastNameController.text}");
      log("Email => ${mEmailController.text}");
      log("Password => ${mPasswordController.text}");
      log("Mobile Number => ${mMobileController.text}");
      log("isPrivacyChecked => $isPrivacyChecked");

      if (mFirstNameController.text.isEmpty) {
        Utility.showToast(enterFirstname);
        return;
      }
      if (mLastNameController.text.isEmpty) {
        Utility.showToast(enterLastname);
        return;
      }
      if (mEmailController.text.isEmpty) {
        Utility.showToast(enterEmail);
        return;
      }
      if (mPasswordController.text.isEmpty) {
        Utility.showToast(enterPassword);
        return;
      }
      if (mMobileController.text.isEmpty) {
        Utility.showToast(enterMobilenumber);
        return;
      }
      if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
        return;
      }
      if (mPasswordController.text.length < 6) {
        Utility.showToast("$enterMinimumCharacters in $password");
        return;
      }
      if (!isPrivacyChecked) {
        Utility.showToast(acceptPrivacyPolicyMsg);
        return;
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successfull!')),
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
          title: const Text('Registration Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle:
                      "FirstName : ${mFirstNameController.text}\nLastName : ${mLastNameController.text}\nEmail : ${mEmailController.text}\nPassword : ${mPasswordController.text}\nMobile Number : ${mMobileController.text}\nIns. Name : ${mInsNameController.text}\nIns. Number : ${mInsNoController.text}\nIns. Image : ${mInsIMGController.text}",
                  mTextColor: black,
                  mFontSize: 16,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: next,
                mTextColor: primaryDarkColor,
                mFontSize: 20,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                clearTextFormField();
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MySideDrawer()));
              },
            ),
          ],
        );
      },
    );
  }
}
