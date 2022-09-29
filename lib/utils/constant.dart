import 'package:patientapp/model/dummyDataModel.dart';

class Constant {
  static String appName = "";

  // Dimentions START
  static double appBarHeight = 60;
  static double appBarTextSize = 20;
  static double textFieldHeight = 48;
  static double buttonHeight = 45;
  static double backBtnHeight = 15;
  static double backBtnWidth = 19;
  // Dimentions END

  static List<String> gradientBG = [
    'assets/images/spec_blue_bg.png',
    'assets/images/spec_green_bg.png',
    'assets/images/spec_bluelight_bg.png',
    'assets/images/spec_orange_bg.png',
    'assets/images/spec_brown_bg.png',
    'assets/images/spec_greenblue_bg.png',
    'assets/images/spec_red_bg.png',
    'assets/images/spec_pinkred_bg.png',
  ];

  static List<DummyDataModel> dummyDataList = [
    DummyDataModel(
      title: 'Dr. Emily Anderson',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Dentist',
      testDesc: 'Body Checkup',
      specImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfSv9j8utf_PY03aRK_5AM9iMCtbXKYTWB3g&usqp=CAU',
      imageUrl:
          'https://images.unsplash.com/photo-1607990283143-e81e7a2c9349?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTUwfHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Approved',
    ),
    DummyDataModel(
      title: 'Dr. Charly Wade',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Cardiologist',
      testDesc: 'Body Checkup',
      specImage:
          'https://images.unsplash.com/photo-1603030431751-f3109cd8d53b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzc4fHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      imageUrl:
          'https://images.unsplash.com/photo-1603030431751-f3109cd8d53b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzc4fHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Approved',
    ),
    DummyDataModel(
      title: 'Dr. Stuart Broad',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Ayurveda',
      testDesc: 'Body Checkup',
      specImage:
          'https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjA3fHxkb2N0b3J8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
      imageUrl:
          'https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjA3fHxkb2N0b3J8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Approved',
    ),
    DummyDataModel(
      title: 'Dr. Michelle Anderson',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Cardiologist',
      specImage:
          'https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGRvY3RvcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      testDesc: 'Body Checkup',
      imageUrl:
          'https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGRvY3RvcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Approved',
    ),
    DummyDataModel(
      title: 'Dr. Shruti Kedia',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Eyes Specialist',
      testDesc: 'Body Checkup',
      specImage:
          'https://images.unsplash.com/photo-1610013597524-6fe8bf4a4a36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzcwfHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      imageUrl:
          'https://images.unsplash.com/photo-1610013597524-6fe8bf4a4a36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzcwfHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Pending',
    ),
    DummyDataModel(
      title: 'Dr. John Marshal',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Cancer Specialist',
      testDesc: 'Body Checkup',
      specImage:
          'https://images.unsplash.com/photo-1615177393114-bd2917a4f74a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzkyfHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      imageUrl:
          'https://images.unsplash.com/photo-1615177393114-bd2917a4f74a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzkyfHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Approved',
    ),
    DummyDataModel(
      title: 'Dr. Zac Wolff',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Dentist',
      testDesc: 'Body Checkup',
      specImage:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzZ8fGRvY3RvcnxlbnwwfDF8MHx8&auto=format&fit=crop&w=400&q=60',
      imageUrl:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzZ8fGRvY3RvcnxlbnwwfDF8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Pending',
    ),
    DummyDataModel(
      title: 'Dr. Mistry Brick',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Cardiologist',
      testDesc: 'Body Checkup',
      specImage:
          'https://images.unsplash.com/photo-1592041828835-4216e6af4a78?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDM5fHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      imageUrl:
          'https://images.unsplash.com/photo-1592041828835-4216e6af4a78?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDM5fHxkb2N0b3J8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Approved',
    ),
    DummyDataModel(
      title: 'Dr. Fred Mask',
      subTitle: 'You can learn Flutter as well Dart.',
      speciality: 'Cancer Specialist',
      testDesc: 'Body Checkup',
      specImage:
          'https://images.unsplash.com/photo-1596942273255-16aa79a98a28?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nzd8fGRvY3RvcnxlbnwwfDF8MHx8&auto=format&fit=crop&w=400&q=60',
      imageUrl:
          'https://images.unsplash.com/photo-1596942273255-16aa79a98a28?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nzd8fGRvY3RvcnxlbnwwfDF8MHx8&auto=format&fit=crop&w=400&q=60',
      mobileNumber: '+91 1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Pending',
    ),
  ];
}
