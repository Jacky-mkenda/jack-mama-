import 'dart:developer';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
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
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late ProgressDialog prDialog;
  File? pickedImageFile, pickedInsImageFile;
  String? strWeight = "", strHeight = "";
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
    prDialog = ProgressDialog(context);
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
                    child: const MyText(
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
                    child: const MyText(
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<UpdateProfileProvider>(
          builder: (context, updateProfileProvider, child) {
            if (!updateProfileProvider.loading) {
              if (updateProfileProvider.profileModel.status == 200) {
                if (updateProfileProvider.profileModel.result != null) {
                  log("profileModel result length ==> ${updateProfileProvider.profileModel.result?.length}");
                  if (mFirstNameController.text.toString().isEmpty) {
                    mFirstNameController.text = updateProfileProvider
                            .profileModel.result
                            ?.elementAt(0)
                            .firstName ??
                        "";
                  }
                  if (mLastNameController.text.toString().isEmpty) {
                    mLastNameController.text = updateProfileProvider
                            .profileModel.result
                            ?.elementAt(0)
                            .lastName ??
                        "";
                  }
                  if (mEmailController.text.toString().isEmpty) {
                    mEmailController.text = updateProfileProvider
                            .profileModel.result
                            ?.elementAt(0)
                            .email ??
                        "";
                  }
                  if (mMobileController.text.toString().isEmpty) {
                    mMobileController.text = updateProfileProvider
                            .profileModel.result
                            ?.elementAt(0)
                            .mobileNumber ??
                        "";
                  }
                  if (mInsNoController.text.toString().isEmpty) {
                    mInsNoController.text = updateProfileProvider
                            .profileModel.result
                            ?.elementAt(0)
                            .insuranceNo ??
                        "";
                  }
                  if (mInsNameController.text.toString().isEmpty) {
                    mInsNameController.text = updateProfileProvider
                            .profileModel.result
                            ?.elementAt(0)
                            .insuranceCompanyName ??
                        "";
                  }
                  if (mInsIMGController.text.toString().isEmpty) {
                    mInsIMGController.text = (updateProfileProvider
                                .profileModel.result
                                ?.elementAt(0)
                                .insuranceCardPic ??
                            "")
                        .split("/")
                        .last;
                  }
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
                                imagePickDialog("ProfilePic");
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
                                child: const MySvgAssetsImg(
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
                        padding: const EdgeInsets.all(0),
                        child: Form(
                          key: personalFormKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: Constant.textFieldHeight,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                        icon: const MySvgAssetsImg(
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                          imagePickDialog("InsImage");
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
                              const SizedBox(
                                height: 20,
                              ),
                              personalSaveButton()
                            ],
                          ),
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }

  Widget bmiDetailTab() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<UpdateProfileProvider>(
          builder: (context, updateProfileProvider, child) {
            if (!updateProfileProvider.loading) {
              if (updateProfileProvider.profileModel.status == 200) {
                if (updateProfileProvider.profileModel.result != null) {
                  if (updateProfileProvider.profileModel.result!.isNotEmpty) {
                    log("BMI profileModel result ==> ${updateProfileProvider.profileModel.result?.length}");
                    if (mAllergyController.text.toString().isEmpty) {
                      mAllergyController.text = updateProfileProvider
                              .profileModel.result
                              ?.elementAt(0)
                              .allergiesToMedicine ??
                          "";
                    }
                    if (mWeightController.text.toString().isEmpty) {
                      mWeightController.text = strWeight = updateProfileProvider
                              .profileModel.result
                              ?.elementAt(0)
                              .currentWeight ??
                          "";
                    }
                    if (mHeightController.text.toString().isEmpty) {
                      mHeightController.text = strHeight = updateProfileProvider
                              .profileModel.result
                              ?.elementAt(0)
                              .currentHeight ??
                          "";
                    }
                    log("Initial strWeight ==> $strWeight");
                    log("Initial strHeight ==> $strHeight");
                    log("mFinalBMIController text ==> ${mFinalBMIController.text}");
                    if (mFinalBMIController.text.toString().isEmpty) {
                      mFinalBMIController.text = Utility.calculateBMI(
                          updateProfileProvider.profileModel.result
                                  ?.elementAt(0)
                                  .currentWeight
                                  .toString() ??
                              "0",
                          updateProfileProvider.profileModel.result
                                  ?.elementAt(0)
                                  .currentHeight
                                  .toString() ??
                              "0");
                    }
                    return Form(
                      key: bmiFormKey,
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
                            child: TextFormField(
                              controller: mWeightController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              readOnly: false,
                              onFieldSubmitted: (strValue) {
                                log("WeightController strValue ==> $strValue");
                                if (strValue.toString().isNotEmpty) {
                                  strWeight = strValue.toString();
                                  log("strWeight ==> $strWeight");
                                }
                              },
                              decoration: InputDecoration(
                                hintText: weight,
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: textHintColor,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                ),
                                border: InputBorder.none,
                              ),
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: textTitleColor,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: Constant.textFieldHeight,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: Utility.textFieldBGWithBorder(),
                            child: TextFormField(
                              controller: mHeightController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              readOnly: false,
                              onFieldSubmitted: (strValue) {
                                log("HeightController strValue ==> $strValue");
                                log("HeightController strWeight ==> $strWeight");
                                if (strValue.toString().isNotEmpty &&
                                    strWeight.toString().isNotEmpty) {
                                  strHeight = strValue.toString();
                                  log("strHeight ==> $strHeight");
                                  mFinalBMIController
                                      .text = Utility.calculateBMI(
                                          strWeight ?? "0", strHeight ?? "0")
                                      .toString();
                                }
                              },
                              decoration: InputDecoration(
                                hintText: height,
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: textHintColor,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                ),
                                border: InputBorder.none,
                              ),
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: textTitleColor,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              decoration: Utility.textFieldBGWithBorder(),
                              child: MyTextFormField(
                                mHint: bmiHint,
                                mController: mFinalBMIController,
                                mObscureText: false,
                                mHintTextColor: textHintColor,
                                mReadOnly: true,
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

  Future<void> imagePickDialog(String pickType) async {
    log("pickType ==> $pickType");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: pickType == "ProfilePic"
                      ? pickProfileImageNote
                      : pickInsImageNote,
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
                getFromGallery(pickType);
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
                getFromCamera(pickType);
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
  void getFromGallery(String clickToPick) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        if (clickToPick == "ProfilePic") {
          pickedImageFile = File(pickedFile.path);
          mInsIMGController.text = p.basename(pickedFile.path);
          log("Gallery pickedImageFile ==> ${pickedImageFile!.path}");
        } else {
          pickedInsImageFile = File(pickedFile.path);
          log("Gallery pickedInsImageFile ==> ${pickedInsImageFile!.path}");
        }
      });
    }
  }

  /// Get from Camera
  void getFromCamera(String clickToPick) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        if (clickToPick == "ProfilePic") {
          pickedImageFile = File(pickedFile.path);
          mInsIMGController.text = p.basename(pickedFile.path);
          log("Camera pickedImageFile ==> ${pickedImageFile!.path}");
        } else {
          pickedInsImageFile = File(pickedFile.path);
          log("Camera pickedInsImageFile ==> ${pickedInsImageFile!.path}");
        }
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
        child: const MyText(
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
    String firstName = mFirstNameController.text.toString().trim();
    String lastName = mLastNameController.text.toString().trim();
    String email = mEmailController.text.toString().trim();
    String mobile = mMobileController.text.toString().trim();
    String birthDate = mBirthdateController.text.toString().trim();
    String insNumber = mInsNoController.text.toString().trim();
    String insName = mInsNameController.text.toString().trim();

    final isValidForm = personalFormKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      log("FirstName => $firstName");
      log("LastName => $lastName");
      log("Email => $email");
      log("BirthDate => $birthDate");
      log("Mobile Number => $mobile");
      log("Insurance Name => $insName");
      log("Insurance Number => $insNumber");
      log("Insurance Image => ${pickedImageFile?.path}");

      if (firstName.isEmpty) {
        Utility.showToast(enterFirstname);
        return;
      }
      if (lastName.isEmpty) {
        Utility.showToast(enterLastname);
        return;
      }
      if (email.isEmpty) {
        Utility.showToast(enterEmail);
        return;
      }
      if (mobile.isEmpty) {
        Utility.showToast(enterMobilenumber);
        return;
      }
      if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
        return;
      }
      final updateProfileProvider =
          Provider.of<UpdateProfileProvider>(context, listen: false);
      // updateprofile API call
      Utility.showProgress(context, prDialog);
      await updateProfileProvider.getUpdatePersonalDetails(
          email,
          firstName,
          lastName,
          mobile,
          "1",
          insNumber,
          pickedInsImageFile,
          pickedImageFile);

      log('PatientUpdateProfile loading ==>> ${updateProfileProvider.loading}');
      if (!updateProfileProvider.loading) {
        // Hide Progress Dialog
        prDialog.hide();
        if (updateProfileProvider.successPersonalModel.status == 200) {
          final profileProvider =
              // ignore: use_build_context_synchronously
              Provider.of<UpdateProfileProvider>(context, listen: false);
          await profileProvider.getPatientProfile();
        }
        // ignore: use_build_context_synchronously
        Utility.showSnackbar(
            context, updateProfileProvider.successPersonalModel.message ?? "");
      }
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
        child: const MyText(
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
    String allergies = mAllergyController.text.toString().trim();
    String finalBMI = mFinalBMIController.text.toString().trim();

    final isValidForm = bmiFormKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      log("allergies => $allergies");
      log("strHeight => $strHeight");
      log("strWeight => $strWeight");
      log("finalBMI => $finalBMI");
      final updateProfileProvider =
          Provider.of<UpdateProfileProvider>(context, listen: false);
      // updateprofile API call
      Utility.showProgress(context, prDialog);
      await updateProfileProvider.getUpdateBMI(
          allergies, strHeight, strWeight, finalBMI);

      log('PatientUpdateProfile loading ==>> ${updateProfileProvider.loading}');
      if (!updateProfileProvider.loading) {
        // Hide Progress Dialog
        prDialog.hide();
        if (updateProfileProvider.successBMIModel.status == 200) {
          final updateProfileProvider =
              // ignore: use_build_context_synchronously
              Provider.of<UpdateProfileProvider>(context, listen: false);
          await updateProfileProvider.getPatientProfile();
        }
        // ignore: use_build_context_synchronously
        Utility.showSnackbar(
            context, updateProfileProvider.successBMIModel.message ?? "");
      }
    }
  }
}
