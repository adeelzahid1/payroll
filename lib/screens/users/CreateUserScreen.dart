import 'dart:math';
import 'package:flutter/material.dart';
import 'package:payroll/InheritedWidget/InheritedWidget.dart';
import 'package:payroll/modals/User.dart';
import 'package:payroll/screens/users/widgets/CreateUserInfoW.dart';
import 'package:payroll/screens/users/widgets/UserRightsWidget.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';



class CreateUserScreen extends StatelessWidget {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     // var user = ModalRoute.of(context)!.settings.arguments;
      User? user = ModalRoute.of(context)!.settings.arguments as User?;
    //Object? user = ModalRoute.of(context)!.settings.arguments;
    bool isUpdate = false;
    if (user != null) {
      isUpdate = true;
    } else {
      user = new User();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: InheritedProvider<User>(
        inheritedData: user,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              AppUtiles.hideKeyBoard(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 24, left: 16, right: 16),
              decoration: BoxDecorationShadowRectangle(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppUtiles.isInRow(context)
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: CreateUserInfo(globalKey: globalKey)),
                            Expanded(child: UserRightsWidget()),
                          ],
                        )
                      : Column(
                          children: [
                            CreateUserInfo(globalKey: globalKey),
                            UserRightsWidget(),
                          ],
                        ),
                  SizedBox(height: 20),
                  Container(
                      child: Center(
                          child: CustomRaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextSL(
                        text: isUpdate ? "Update" : "Save",
                        color: Colors.white,
                      ),
                    ),
                    onPress: () {
                      if (globalKey.currentState!.validate()) {
                        print("Valid");
                        globalKey.currentState!.save();

                        if (isUpdate) {
                          Navigator.pop(context, user);
                        } else {
                          user!.id = new Random().nextInt(5000);
                          Navigator.pop(context, user);
                        }
                      } else {
                        print("in Valid");
                      }
                    },
                    color: Theme.of(context).primaryColor,
                  ))),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
