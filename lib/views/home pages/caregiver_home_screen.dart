import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constatnts.dart';
import '../splash and onboarding/sign_in_or_register_screen.dart';

class CareGiverHomeScreen extends StatefulWidget {
  const CareGiverHomeScreen({super.key});

  @override
  State<CareGiverHomeScreen> createState() => _CareGiverHomeScreenState();
}

class _CareGiverHomeScreenState extends State<CareGiverHomeScreen> {

  final GlobalKey<ScaffoldState> key = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: Drawer(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 16, 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings_outlined,
                        color: AppColors.mintGreen,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'الاعدادات',
                        style: TextStyle(
                            fontSize: 25,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.mintGreen,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 7, 20, 7),
                  horizontalTitleGap: 0,
                  minLeadingWidth: 35,
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: AppColors.mintGreen,
                    size: 27,
                  ),
                  title: const Text(
                    'الاعدادات',
                    style: TextStyle(fontSize: 22, color: AppColors.lightBlack),
                  ),
                  onTap: () {
                    
                  },
                ),
              ),
              const Divider(
                height: 0.5,
                thickness: 0.5,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 7, 20, 7),
                  horizontalTitleGap: 0,
                  minLeadingWidth: 35,
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: AppColors.mintGreen,
                    size: 27,
                  ),
                  title: const Text(
                    'الاعدادات',
                    style: TextStyle(fontSize: 22, color: AppColors.lightBlack),
                  ),
                  onTap: () {
                   
                  },
                ),
              ),
            
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(0, 7, 20, 10),
                      horizontalTitleGap: 0,
                      minLeadingWidth: 35,
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 27,
                      ),
                      title: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', false);
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const SignInOrRegister()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      backgroundColor: AppColors.white,
      body: Container(),
    );
  }
}