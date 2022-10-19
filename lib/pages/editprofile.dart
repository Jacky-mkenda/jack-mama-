import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/provider/updateprofileprovider.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';

import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:patientapp/widgets/mytextformfield.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? pickedImageFile;
  final ImagePicker imagePicker = ImagePicker();
  final personalFormKey = GlobalKey<FormState>();
  final bmiFormKey = GlobalKey<FormState>();
  final mFirstNameController = TextEditingController();
  final mLastNameController = TextEditingController();
  final mEmailController = TextEditingController();
  final mBirthdateController = TextEditingController();
  final mMobileController = TextEditingController();
  final mInsNoController = TextEditingController();
  final mInsNameController = TextEditingController();
  final mInsIMGController = TextEditingController();

  final mAllergyController = TextEditingController();
  final mWeightController = TextEditingController();
  final mHeightController = TextEditingController();
  final mFinalBMIController = TextEditingController();

  @override
  void initState() {
    final updateProfileProvider =
        Provider.of<UpdateProfileProvider>(context, listen: false);
    updateProfileProvider.getPatientProfile();
    super.initState();
  }

  @override
  void dispose() {
    mFirstNameController.dispose();
    mLastNameController.dispose();
    mEmailController.dispose();
    mBirthdateController.dispose();
    mMobileController.dispose();
    mInsNoController.dispose();
    mInsNameController.dispose();
    mInsIMGController.dispose();

    mAllergyController.dispose();
    mWeightController.dispose();
    mHeightController.dispose();
    mFinalBMIController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: loginRegBGColor,
      appBar: Utility.appBarCommon(editProfile),
      body: Container(
        decoration: Utility.topRoundBG(),
        child: buildEditProfileTabs(),
      ),
    );
  }

  Widget buildEditProfileTabs() {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TabBar(
              isScrollable: false,
              labelColor: primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: accentColor,
              indicatorWeight: 1,
              labelPadding: const EdgeInsets.only(top: 5, bottom: 5),
              indicatorPadding: const EdgeInsets.all(1),
              unselectedLabelColor: tabDefaultColor,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: appBgColor,
                      border: Border(
                        right: BorderSide(color: boxBorderColor, width: 0.5),
                      ),
                    ),
                    child: MyText(
                      mTitle: personal,
                      mFontSize: 15,
                      mFontStyle: FontStyle.normal,
                      mFontWeight: FontWeight.w600,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mTextAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: appBgColor,
                      border: Border(
                        left: BorderSide(color: boxBorderColor, width: 0.5),
                      ),
                    ),
                    child: MyText(
                      mTitle: bMI,
                      mFontSize: 15,
                      mFontStyle: FontStyle.normal,
                      mFontWeight: FontWeight.w600,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mTextAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: boxBorderColor,
          ),
          Expanded(
            child: TabBarView(
              children: [
                personalDetailTab(),
                bmiDetailTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget personalDetailTab() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: Form(
        key: personalFormKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer<UpdateProfileProvider>(
            builder: (context, updateProfileProvider, child) {
              if (!updateProfileProvider.loading) {
                if (updateProfileProvider.profileModel.status == 200) {
                  if (updateProfileProvider.profileModel.result != null) {
                    if (updateProfileProvider.profileModel.result!.isNotEmpty) {
                      return Column(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                clipBehavior: Clip.antiAlias,
                                child: pickedImageFile != null
                                    ? Image.file(
                                        pickedImageFile!,
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80,
                                      )
                                    : MyNetworkImage(
                                        imageUrl: updateProfileProvider
                                                .profileModel.result!
                                                .elementAt(0)
                                                .profileImg ??
                                            "",
                                        fit: BoxFit.cover,
                                        imgHeight: 80,
                                        imgWidth: 80,
                                      ),
                              ),
                              Positioned(
                                child: InkWell(
                                  onTap: () {
                                    imagePickDialog();
                                  },
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: black50,
                                      shape: BoxShape.circle,
                                    ),
                                    child: MySvgAssetsImg(
                                      imageName: 'edit_camera.svg',
                                      fit: BoxFit.fill,
                                      imgHeight: 27,
                                      imgWidth: 27,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
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
                              mTextColor: textTitleColor,
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
                              mTextColor: textTitleColor,
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
                              mTextColor: textTitleColor,
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
                                    mHint: birthDateHint,
                                    mObscureText: false,
                                    mController: mBirthdateController,
                                    mHintTextColor: textHintColor,
                                    mMaxLine: 1,
                                    mReadOnly: true,
                                    mTextColor: textTitleColor,
                                    mInputBorder: InputBorder.none,
                                    mkeyboardType: TextInputType.text,
                                    mTextInputAction: TextInputAction.done,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: () {
                                      openDatePicker();
                                    },
                                    icon: MySvgAssetsImg(
                                      imageName: "calendar.svg",
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
                              mTextColor: textTitleColor,
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
                              mTextColor: textTitleColor,
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
                              mTextColor: textTitleColor,
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
                                    mTextColor: textTitleColor,
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
                          const SizedBox(
                            height: 20,
                          ),
                          personalSaveButton(),
                        ],
                      );
                    } else {
                      return const NoData();
                    }
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
          ),
        ),
      ),
    );
  }

  Widget bmiDetailTab() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: Form(
        key: bmiFormKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: Constant.textFieldHeight,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: Utility.textFieldBGWithBorder(),
                child: MyTextFormField(
                  mHint: allergiesToMedicine,
                  mController: mAllergyController,
                  mObscureText: false,
                  mMaxLine: 1,
                  mHintTextColor: textHintColor,
                  mTextColor: textTitleColor,
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
                  mHint: weight,
                  mController: mWeightController,
                  mObscureText: false,
                  mMaxLine: 1,
                  mHintTextColor: textHintColor,
                  mTextColor: textTitleColor,
                  mkeyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
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
                  mHint: height,
                  mController: mHeightController,
                  mObscureText: false,
                  mMaxLine: 1,
                  mHintTextColor: textHintColor,
                  mTextColor: textTitleColor,
                  mkeyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  mTextInputAction: TextInputAction.done,
                  mInputBorder: InputBorder.none,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 118,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: Utility.textFieldBGWithBorder(),
                  child: MyTextFormField(
                    mHint: bmiHint,
                    mController: mFinalBMIController,
                    mObscureText: false,
                    mHintTextColor: textHintColor,
                    mTextColor: textTitleColor,
                    mkeyboardType: TextInputType.multiline,
                    mTextInputAction: TextInputAction.done,
                    mInputBorder: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              bmiSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  void clearTextFormField(String clickType) {
    if (clickType == 'Personal') {
      mFirstNameController.clear();
      mLastNameController.clear();
      mEmailController.clear();
      mBirthdateController.clear();
      mMobileController.clear();
      mInsNameController.clear();
      mInsNoController.clear();
      mInsIMGController.clear();
    } else if (clickType == 'BMI') {
      mAllergyController.clear();
      mWeightController.clear();
      mHeightController.clear();
      mFinalBMIController.clear();
    }
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
  void getFromGallery() async {
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
  void getFromCamera() async {
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

  void openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      log('$pickedDate'); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      log(formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        mBirthdateController.text =
            formattedDate; //set output date to TextField value.
      });
    }
  }

  Widget personalSaveButton() {
    return InkWell(
      focusColor: primaryColor,
      onTap: () => validatePersonalData(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: Constant.buttonHeight,
        decoration: Utility.primaryButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: save,
          mTextColor: white,
          mTextAlign: TextAlign.center,
          mFontSize: 16,
          mFontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void validatePersonalData() async {
    final isValidForm = personalFormKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      log("FirstName => ${mFirstNameController.text}");
      log("LastName => ${mLastNameController.text}");
      log("Email => ${mEmailController.text}");
      log("Password => ${mBirthdateController.text}");
      log("Mobile Number => ${mMobileController.text}");
      log("Insurance Name => ${mInsNameController.text}");
      log("Insurance Number => ${mInsNoController.text}");
      log("Insurance Image => ${mInsIMGController.text}");

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
      if (mMobileController.text.isEmpty) {
        Utility.showToast(enterMobilenumber);
        return;
      }
      if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
        return;
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update Successfull!')),
      );

      await showMyDialog('Personal');
    }
  }

  Widget bmiSaveButton() {
    return InkWell(
      focusColor: primaryColor,
      onTap: () => validateBMIData(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: Constant.buttonHeight,
        decoration: Utility.primaryButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: save,
          mTextColor: white,
          mTextAlign: TextAlign.center,
          mFontSize: 16,
          mFontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void validateBMIData() async {
    final isValidForm = bmiFormKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      log("Weight => ${mWeightController.text}");
      log("Height => ${mHeightController.text}");

      if (mWeightController.text.isEmpty) {
        Utility.showToast(weightReqMsg);
        return;
      }
      if (mHeightController.text.isEmpty) {
        Utility.showToast(heightReqMsg);
        return;
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update Successfull!')),
      );

      await showMyDialog('BMI');
    }
  }

  Future<void> showMyDialog(clickType) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: clickType == 'Personal'
                      ? "FirstName : ${mFirstNameController.text}\nLastName : ${mLastNameController.text}\nEmail : ${mEmailController.text}\nBirthDate : ${mBirthdateController.text}\nMobile Number : ${mMobileController.text}\nIns. Name : ${mInsNameController.text}\nIns. Number : ${mInsNoController.text}\nIns. Image : ${mInsIMGController.text}"
                      : "Allergies to Medicine : ${mAllergyController.text}\nWeight : ${mWeightController.text}\nHeight : ${mHeightController.text}\nBMI : ${mFinalBMIController.text}",
                  mTextColor: black,
                  mFontSize: 16,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: save,
                mTextColor: primaryDarkColor,
                mFontSize: 20,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                clearTextFormField(clickType);
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
