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

import '../widgets/myappbarwithback.dart';

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

   final List<Map<String, String>> infoTiles = [
    {
      'title': 'Importance of Prenatal Care',
      'subtitle': 'Taking care of yourself and your baby'
    },
    {
      'title': 'Nutrition During Pregnancy',
      'subtitle': 'Eating right for a healthy pregnancy'
    },
    {
      'title': 'Exercise and Pregnancy',
      'subtitle': 'Staying active during pregnancy'
    },
    {
      'title': 'Common Discomforts and Remedies',
      'subtitle': 'Dealing with pregnancy discomforts'
    },
    {
      'title': 'Preparing for Labor and Delivery',
      'subtitle': 'Getting ready for the big day'
    },
    {
      'title': 'Newborn Care Basics',
      'subtitle': 'Taking care of your newborn baby'
    },
  ];

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: statusBarColor,
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(Constant.appBarHeight),
      child: AppBar(
       title: Text("Blog"),
      ),
    ),
      body: ListView.builder(
            itemCount: infoTiles.length,
            itemBuilder: (context, index) {
       return ListTile(
        key: Key(index.toString()),
         title: Text(infoTiles[index]['title']!),
         subtitle: Text(infoTiles[index]['subtitle']!),
         onTap: () {
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => InformationDetailPage(
                 title: infoTiles[index]['title']!,
                 content: getInformationContent(index),
               ),
             ),
           );
         },
       );
            },
          ),
    );
  }

 

  String getInformationContent(int index) {
    switch (index) {
      case 0:
        return 'Prenatal care is important for both the mother and the baby. Regular check-ups with healthcare providers help monitor the health of the mother and ensure the healthy development of the baby.';
      case 1:
        return 'Proper nutrition during pregnancy is crucial. Eating a balanced diet that includes essential nutrients such as folic acid, iron, calcium, and omega-3 fatty acids supports the baby\'s growth and development.';
      case 2:
        return 'Staying physically active during pregnancy has numerous benefits, including improved mood, increased energy, and easier labor. However, it\'s important to consult with your healthcare provider to determine suitable exercises for your specific situation.';
      case 3:
        return 'During pregnancy, various discomforts like nausea, backaches, and swollen feet may arise. There are remedies available to alleviate these discomforts, such as eating small and frequent meals, practicing good posture, and wearing comfortable shoes.';
      case 4:
        return 'Preparing for labor and delivery involves learning about the different stages of labor, pain management techniques, and creating a birth plan. It\'s essential to attend childbirth education classes and discuss your preferences with your healthcare provider.';
      case 5:
        return 'Caring for a newborn baby can be an overwhelming experience. Learning about feeding, bathing, diapering, and soothing techniques can help new parents feel more confident and prepared.';
      default:
        return '';
    }
  }
}


 

class InformationDetailPage extends StatelessWidget {
  final String title;
  final String content;

  InformationDetailPage({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          content,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}



