import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:payroll/InheritedWidget/InheritedWidget.dart';
import 'package:payroll/modals/ShopName.dart';
import 'package:payroll/modals/User.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DropDown/CustomDropDown.dart';
import 'package:payroll/widgets/TextField/TextFormFieldWidget.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';

class CreateUserInfo extends StatefulWidget {
  GlobalKey<FormState> globalKey;
  CreateUserInfo({required this.globalKey});

  @override
  _CreateUserInfoState createState() => _CreateUserInfoState();
}

class _CreateUserInfoState extends State<CreateUserInfo> {
  final List<DropDownVal> _DropDownValList = [
    DropDownVal(name: 'Admin', value: 1),
    DropDownVal(name: 'Shop keeper', value: 2),
    DropDownVal(name: 'Sale Man', value: 3),
    DropDownVal(name: 'Supper Admin', value: 4),
  ];
  final List<DropDownVal> _DropDownValShop = [
    DropDownVal(name: 'Select shop', value: -1),
    DropDownVal(name: 'D Ground FSD', value: 1),
    DropDownVal(name: 'Jail Road FSD', value: 2),
    DropDownVal(name: 'Jarawala Road FSD', value: 3),
    DropDownVal(name: 'Ali Abad FSD', value: 4),
  ];

  DropDownVal _DropDownVal = DropDownVal();
   late List<DropdownMenuItem<DropDownVal>> _DropDownValDropdownList;

  DropDownVal _DropDownSelectedShop = DropDownVal();
   late List<DropdownMenuItem<DropDownVal>> _DropDownListShop;

  late User user;

  @override
  void initState() {

    _DropDownValDropdownList= AppUtiles.buildDropDownValDropdown(_DropDownValList);
    _DropDownListShop = AppUtiles.buildDropDownValDropdown(_DropDownValShop);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = InheritedProvider.of<User>(context);

    final index =
        _DropDownValList.indexWhere((element) => element.value == user.roleId);
    if (index != -1) {
      _DropDownVal = _DropDownValList[index];
    } else {
      if (_DropDownValList.length > 0) _DropDownVal = _DropDownValList[0];
    }

    if (user.shop != null) {
      final indexShop = _DropDownValShop.indexWhere(
          (element) => element.value == user.shop!.id);
      if (indexShop != -1) {
        _DropDownSelectedShop = _DropDownValShop[indexShop];
      } else {
        if (_DropDownValShop.length > 0)
          _DropDownSelectedShop = _DropDownValShop[0];
      }
    } else {
      if (_DropDownValShop.length > 0)
        _DropDownSelectedShop = _DropDownValShop[0];
    }

    return Container(
      decoration: BoxDecorationShadowRectangle(),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Form(
        key: widget.globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Group Dropdown
            CustomTextSL(text: "Select Group"),
            SizedBox(height: 4),
            CustomDropdown(
              // DropDownValuesList: _DropDownValDropdownList,
              dropdownMenuItemList: _DropDownValDropdownList,
              onChanged: (DropDownVal? selectedItme) {
                setState(() {
                  user.roleId = selectedItme!.value;
                });
              },
              // selectedValue: _DropDownVal,
              value: _DropDownVal,
              isEnabled: true,
            ),
            SizedBox(height: 16),

            // Name TextBox
            TextFormFieldWidget(
              hint: "Enter Name",
              label: "Name",
              initalVal: user.name,
              onSave: (String? value) {
                setState(() {
                  user.name = value;
                });
              },
              onChange: (String value) {
                print(value);
              },
              validate: RequiredValidator(errorText: "Enter name"),
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox(height: 16),

            // Email TextBox
            TextFormFieldWidget(
              hint: "Enter Email",
              label: "Email",
              initalVal: user.email,
              onSave: (String? value) {
                setState(() {
                  user.email = value;
                });
              },
              validate: RequiredValidator(errorText: "Enter email"),
              textInputType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
            ),
            SizedBox(height: 16),

            // Commnets TextBox
            TextFormFieldWidget(
              hint: "Enter Comments",
              label: "Comments",
              initalVal: user.comment,
              onSave: (String? value) {
                setState(() {
                  user.comment = value;
                });
              },
              textCapitalization: TextCapitalization.sentences,
              textInputType: TextInputType.multiline,
              minLine: 1,
              maxLines: 4,
            ),
            SizedBox(height: 16),

            // Select Shop Dropdown
            CustomTextSL(text: "Select Shop"),
            SizedBox(height: 4),
            CustomDropdown(
              dropdownMenuItemList: _DropDownListShop,
              value: _DropDownSelectedShop,
              onChanged: (DropDownVal? selectedItme) {
                setState(() {
                  if (user.shop == null) {
                    user.shop = new Shop();
                  }
                  user.shop!.id = selectedItme!.value;
                  user.shop!.shopName = selectedItme.name;
                });
              },
              isEnabled: _DropDownListShop.length > 1 ? true : false,
            ),

            //// login id TextBox
            SizedBox(height: 16),
            TextFormFieldWidget(
              hint: "Login ID",
              label: "Login ID",
              initalVal: user.loginId,
              onSave: (String? value) {
                setState(() {
                  user.loginId = value;
                });
              },
              validate: RequiredValidator(errorText: "Enter login id"),
              textCapitalization: TextCapitalization.words,
            ),

            // ========= Password TextBox
            SizedBox(height: 16),
            TextFormFieldWidget(
              hint: "Password",
              label: "Password",
              initalVal: user.password,
              onSave: (String? value) {
                setState(() {
                  user.password = value;
                });
              },
              onChange: (value) {
                setState(() {
                  user.password = value;
                });
              },
              validate: MultiValidator([
                RequiredValidator(errorText: "Enter password"),
                MinLengthValidator(2,
                    errorText: 'Password must be at least 2 digits long'),
              ]),
              isPassword: true,
            ),

            // ========= confirm Password TextBox
            SizedBox(height: 16),
            TextFormFieldWidget(
              hint: "Confirm Password",
              label: "Confirm Password",
              initalVal: user.password,
              validate: (value) =>
                  MatchValidator(errorText: 'Passwords does not match')
                      .validateMatch(value!, user.password!),
              isPassword: true,
              onSave: null,
            ),
          ],
        ),
      ),
    );
  }
}
