
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll/InheritedWidget/InheritedWidget.dart';
import 'package:payroll/modals/User.dart';
import 'package:payroll/modals/widgets/CheckBoxValue.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:payroll/widgets/checkBox/CheckBoxListTileCustom.dart';
import 'package:payroll/widgets/datePicker/CustomDatePicker.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';

class UserRightsWidget extends StatefulWidget {
  @override
  _UserRightsWidgetState createState() => _UserRightsWidgetState();
}

class _UserRightsWidgetState extends State<UserRightsWidget> {
  @override
  Widget build(BuildContext context) {
    User user = InheritedProvider.of<User>(context);

    final List<CheckBoxValue> userRights = [
      new CheckBoxValue(
          name: "Enable View Cost Price", isChecked: user.enableViewCostPrice),
      new CheckBoxValue(
          name: "Apply Adjustment", isChecked: user.applyAdjustment),
      new CheckBoxValue(
          name: "Apply Open Adjustment", isChecked: user.applyOpenAdjustment),
      new CheckBoxValue(
          name: "Show Secondary Cost", isChecked: user.showSecondaryCost),
      new CheckBoxValue(
          name: "Hide stock in Help Window", isChecked: user.hideStockInHelp),
      new CheckBoxValue(
          name: "Allow Release Download", isChecked: user.allowReleaseDownload),
      new CheckBoxValue(
          name: "Allow POS Discount", isChecked: user.allowPOSDiscount),
      new CheckBoxValue(
          name: "Allow POS Price Editing",
          isChecked: user.allowPOSPriceEditing),
    ];

    return Container(
      decoration: BoxDecorationShadowRectangle(),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Date TextBox with Custome Heading
              CustomTextSL(text: "End Date"),
              SizedBox(width: 2),
              Checkbox(
                onChanged: (bool? value) {
                  setState(() {
                    user.isEndDate = value!;
                    user.endDate = AppUtiles.getCurrentDate();
                  });
                },
                value: user.isEndDate,
              ),
            ],
          ),
          CustomDatePicker(
            isEnable: user.isEndDate,
            onDone: (date) {
              setState(() {
                user.endDate = AppUtiles.dateToString(date);
              });
              print("Date selected $date");
            },
          ),

          // End Date TextBox with Custome Heading

          // >> ============================== <<
          //>>  Custom CheckBox List Group  <<

          CheckBoxListTileCustom(
            list: userRights,
            isDivider: true,
            checkChangedListener: (CheckBoxValue item, int index) {
              setState(() {
                user.enableViewCostPrice = userRights[0].isChecked;
                user.applyAdjustment = userRights[1].isChecked;
                user.applyOpenAdjustment = userRights[2].isChecked;
                user.showSecondaryCost = userRights[3].isChecked;
                user.hideStockInHelp = userRights[4].isChecked;
                user.allowReleaseDownload = userRights[5].isChecked;
                user.allowPOSDiscount = userRights[6].isChecked;
                user.allowPOSPriceEditing = userRights[7].isChecked;
              });
            },
          ),
        ],
      ),
    );
  }
}
