import 'dart:io';


import 'package:auth/auth/screens/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:network/SharedPrefManager.dart';
import 'package:network/models/user.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';


class PayRollSplashScreen extends StatefulWidget {
  @override
  _PayRollSplashScreenState createState() => _PayRollSplashScreenState();
}

class _PayRollSplashScreenState extends State<PayRollSplashScreen> {
  Future<bool> isLogin() async {
    await Future.delayed(Duration(seconds: 2), () {});
    return await SharedPrefManagerUser.getInstance().then((value) {
      User? user = value!.getUser();
      if (user != null) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    try {
      // HttpService.instance.;
    } catch (e) {
      print("Error Loading WebApi: $e");
    }

    isLogin().then((value) async {
      if (value) {
        Navigator.pushReplacementNamed(
            context, PayRollAppPagesConstants.mainScreenPayRoll);
      } else {
        // Navigator.pushReplacementNamed(
        //     context, PayRollAppPagesConstants.mainScreenPayRoll);

        // dynamic result = await Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );

        // Navigator.pushReplacementNamed(context, PayRollAppPagesConstants.loginPayRollPageRoute);
        dynamic result = await Navigator.pushNamed(context, PayRollAppPagesConstants.loginPayRollPageRoute);
        if (result != null) {
          User user = result as User;
          print(user.name);
          Navigator.pushReplacementNamed(
              context, PayRollAppPagesConstants.mainScreenPayRoll);
        } else {
          exit(0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "BMS",
            style: TextStyle(
              fontFamily: "DMSans",
              fontWeight: FontWeight.w500,
              fontSize: 38.0,
            ),
          ),
        ),
      ),
    );
  }
}
