import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/pages/sidedrawer.dart';
import 'package:patientapp/provider/generalprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:patientapp/widgets/mytextformfield.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late ProgressDialog prDialog;
  SharedPre sharePref = SharedPre();
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
  dynamic firstName,
      lastName,
      email,
      password,
      mobileNumber,
      insNumber,
      insName,
      insCompanyId,
      deviceToken;
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
                                  icon: const MySvgAssetsImg(
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
                        // privacyCheckBox(),
                        SizedBox(height: 30,),
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
    mInsNoController.clear();
    mInsNameController.clear();
    mInsIMGController.clear();
  }

  Future<void> imagePickDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
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
              child: const MyText(
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
              child: const MyText(
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
              child: const MyText(
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
    } else {
      pickedImageFile = File("");
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
        mInsIMGController.text = p.basename(pickedFile.path);
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
                log("onChanged value ==> $value");
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
        child: const MyText(
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
                  log("$loginFSpace tapped!");
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
      firstName = mFirstNameController.text.toString().trim();
      lastName = mLastNameController.text.toString().trim();
      email = mEmailController.text.toString().trim();
      password = mPasswordController.text.toString().trim();
      mobileNumber = mMobileController.text.toString().trim();
      insNumber = mInsNoController.text.toString().trim();
      insName = mInsNameController.text.toString().trim();
      insCompanyId = "1";
      deviceToken = "1234567890";
      log("FirstName => $firstName");
      log("LastName => $lastName");
      log("Email => $email");
      log("Password => $password");
      log("Mobile Number => $mobileNumber");
      log("insNumber => $insNumber");
      log("insName => $insName");
      log("insImage => ${pickedImageFile?.path.toString()}");
      log("isPrivacyChecked => $isPrivacyChecked");

      if (mFirstNameController.text.isEmpty) {
        Utility.showToast(enterFirstname);
      } else if (mLastNameController.text.isEmpty) {
        Utility.showToast(enterLastname);
      } else if (mEmailController.text.isEmpty) {
        Utility.showToast(enterEmail);
      } else if (mPasswordController.text.isEmpty) {
        Utility.showToast(enterPassword);
      } else if (mMobileController.text.isEmpty) {
        Utility.showToast(enterMobilenumber);
      } else if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
      } else if (mPasswordController.text.length < 6) {
        Utility.showToast("$enterMinimumCharacters in $password");
      } else if (!isPrivacyChecked) {
        Utility.showToast(acceptPrivacyPolicyMsg);
      } else {
        generalProvider = Provider.of<GeneralProvider>(context, listen: false);
        // registration API call
        Utility.showProgress(context, prDialog);
        await generalProvider.registerPatient(
          firstName,
          lastName,
          email,
          password,
          mobileNumber,
          deviceToken,
          insCompanyId,
          insName,
          pickedImageFile,
        );

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
        log('Registration Successfull!');
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

        clearTextFormField();
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
