import 'package:manjhi/controller/local_storage_controller.dart';
import 'package:manjhi/view/mainview/main_navigate.dart';
import 'package:manjhi/view/userview/user_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;
  bool checkUserStatus = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _getUserLocal();
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      if (animation.isCompleted) {
        if (checkUserStatus == true) {
          Navigator.pushReplacementNamed(context, MainNavigate.id);
        } else {
          Navigator.pushReplacementNamed(context, UserNavigate.id);
        }
      }
    });
  }

  void _getUserLocal() async {
    checkUserStatus = await Provider.of<LocalStorageController>(context, listen: false)
        .validateLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'images/Manjhi.png',
            height: MediaQuery.of(context).size.height * 0.3,
        ),
        ),
      ),
    );
  }
}
