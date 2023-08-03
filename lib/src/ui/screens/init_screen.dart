// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../values/k_colors.dart';
import '../../utils/page_args.dart';
import '../screen_controllers/init_screen_controller.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'my_home_screen.dart';

class InitScreen extends StatefulWidget {
  final PageArgs? args;
  const InitScreen(this.args, {Key? key}) : super(key: key);
  @override
  _InitScreenState createState() => _InitScreenState(args);
}

class _InitScreenState extends StateMVC<InitScreen> {
  late InitScreenController _con;
  PageArgs? args;
  _InitScreenState(PageArgs? arguments) : super(InitScreenController(arguments)) {
    _con = InitScreenController.con;
    args = arguments;
  }
  @override
  void initState() {
    _con.initScreen(arguments: args);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedSplashScreen.withScreenFunction(
          screenFunction: () async {
            await _con.init();
            return MyHomeScreen(null);
          },
          animationDuration: const Duration(milliseconds: 1000),
          backgroundColor: KWhite,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          curve: Curves.linear,
          splashIconSize: double.maxFinite,
          centered: true,
          splash: _splashBody(),
        ),
      ),
    );
  }

  _splashBody() {
    return const Center(
      child: FlutterLogo(),
    );
  }
}
