import 'package:manjhi/controller/local_storage_controller.dart';
import 'package:manjhi/view/mainview/main_navigate.dart';
import 'package:manjhi/view/splash_screen.dart';
import 'package:manjhi/view/userview/user_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const Manjhi());
}

class Manjhi extends StatelessWidget {
  const Manjhi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocalStorageController(),
      child: MaterialApp(
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          UserNavigate.id: (context) => const UserNavigate(),
          MainNavigate.id: (context) => const MainNavigate(),
        },
      ),
    );
  }
}
