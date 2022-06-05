import 'package:flutter/material.dart';
import 'package:payroll/modals/ClaimsList.dart';

import 'package:payroll/modals/GroupCategories.dart';
import '../GroupCategoryRightNotifier.dart';
import 'package:payroll/modals/enum/ReportWithRightWithOutRight.dart';
import 'package:payroll/modals/widgets/CheckBoxValue.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/utils/AppLevelConstants.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DropDown/CustomDropDown.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';
import 'package:payroll/widgets/checkBox/CheckBoxListTileCustom.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';

class GroupRightsWidget extends StatefulWidget {
  @override
  _GroupRightsWidgetState createState() => _GroupRightsWidgetState();
}

late GroupCategoryRightsNotifier _provider ;

class _GroupRightsWidgetState extends State<GroupRightsWidget> {

  ReportWithRightWithOutRight _character = ReportWithRightWithOutRight.allRights;
  // MultiSelectController controller = new MultiSelectController();


  final List<DropDownVal> _DropDownValList = [
    DropDownVal(name: 'Admin', value: 1),
    DropDownVal(name: 'Shop keeper', value: 2),
    DropDownVal(name: 'Sale Man', value: 3),
    DropDownVal(name: 'Supper Admin', value: 4),
  ];

  //todo :: show it in categories section
  final List<GroupCategories> categories = [
    GroupCategories(name: 'Configuration', id: 1),
    GroupCategories(name: 'Configuration > Misc', id: 2),
    GroupCategories(name: 'Configuration > Misc > Home Delivery', id: 3),
    GroupCategories(name: 'Configuration > Misc > Loyality Club', id: 4),
    GroupCategories(name: 'Configuration > Misc >  s', id: 5),
    GroupCategories(name: 'Customer Club', id: 6),
    GroupCategories(name: 'Inventory Mgmt', id: 7),
    GroupCategories(name: 'Inventory Mgmt', id: 7),
    GroupCategories(name: 'Inventory Mgmt', id: 7),
    GroupCategories(name: 'Inventory Mgmt', id: 7),
    GroupCategories(name: 'Inventory Mgmt', id: 7),
  ];

  final List<CheckBoxValue> selectAllRightList = [
    new CheckBoxValue(name: "View All", isChecked: false),
    new CheckBoxValue(name: "Save All", isChecked: false),
    new CheckBoxValue(name: "Update All", isChecked: false),
    new CheckBoxValue(name: "Delete All", isChecked: false),
    new CheckBoxValue(name: "Print All", isChecked: false),
    new CheckBoxValue(name: "Export All", isChecked: false),
    new CheckBoxValue(name: "Other All", isChecked: false),
  ];

  DropDownVal _DropDownVal = DropDownVal();
  // List<DropdownMenuItem<DropDownVal>> _DropDownValDropdownList;   //
  var _DropDownValDropdownList;

  @override
  void initState() {
    _DropDownValDropdownList =
        AppUtiles.buildDropDownValDropdown(_DropDownValList);
    if (_DropDownValList.length > 0) _DropDownVal = _DropDownValList[0];

    // controller.disableEditingWhenNoneSelected = true;  //multi select item is non null safety
    // controller.set(categories.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _provider = context.watch<GroupCategoryRightsNotifier>();


    return GestureDetector(
      onTap: (){
        AppUtiles.hideKeyBoard(context);
      },
      child: Container(
        decoration: BoxDecorationShadowRectangle(),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Group selection
            getGroups(context),
            SizedBox(height: 12),
            CustomTextSL(text: "Form Categories"),
            SizedBox(height: 6),
            getCategoriesList(context),
            SizedBox(height: 26),
            CollapesAndExpendButton(),
            SizedBox(height: 26),
            selectAllRights(),
            SizedBox(height: 26),
            generateReport(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget getGroups(context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextSL(text: "Select Group"),
              SizedBox(height: 4),
              CustomDropdown(
                // DropDownValuesList: _DropDownValDropdownList,
                dropdownMenuItemList: _DropDownValDropdownList,
                onChanged: (DropDownVal? selectedItem) {
                  print(selectedItem!.value);
                  setState(() {
                    _DropDownVal = selectedItem;
                  });
                },
                // selectedValue: _DropDownVal,
                value: _DropDownVal,
                isEnabled: true,
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextSL(text: "Duplicated Categories", maxLine: 1),
              SizedBox(height: 4),
              CustomRaisedButton(
                child: CustomTextSL(text: "Delete"),
                onPress: () {
                  print("Delete Click");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getCategoriesList(context) {
    return Container(
      height: 200,
      decoration: BoxDecorationShadowRectangle(),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListView.builder(
        itemCount: _provider.moduleList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
           // key: UniqueKey(),
            child: InkWell(
              hoverColor: Colors.black26,
              onTap: (){
                print(_provider.moduleList[index].name);

                // String moduleName = _provider.moduleList[index].name;
                // Map <String, List<ClaimValues>>? moduoleCalims  = _provider.objClaim?.claimsList?[moduleName];
                // List<String> headNames = moduoleCalims!.keys.toList();
                //
                // moduoleCalims.forEach((key, value) {
                //     print("$key ");
                //     value.forEach((element) {
                //       print("${element.name} : ${element.isSelected} : ${element.value} ");
                //     });
                // });
                //print(moduoleCalims);
                },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                  child: Text(_provider.moduleList[index].name)),
            ),);
          // return InkWell(
          //   hoverColor: Colors.black38,
          //
          //   // child: MultiSelectItem(
          //   //   isSelecting: controller.isSelecting,
          //   //   onSelected: () {
          //   //     setState(() {
          //   //       controller.toggle(index);
          //   //     });
          //   //   },
          //     return Container(
          //         padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          //         margin: EdgeInsets.symmetric(vertical: 2),
          //         // decoration: controller.isSelected(index)
          //         //     ? new BoxDecoration(color: Colors.grey[300])
          //         //     : new BoxDecoration(),
          //         child: InkWell(
          //             onTap: (){print(categories[index].name);},
          //             child: Text(categories[index].name)),
          // );
          //   //
          //   // ),
          //   splashColor: Colors.blue,
          //   onTap: () {},
          // );
        },
      ),
    );
  }

  Widget CollapesAndExpendButton() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppUtiles.getButtonHMarginPlatFormHalfScreen(context)),
      child: Row(
        children: [
          Expanded(
            child: CustomRaisedButton(
              child: Align(
                alignment: Alignment.center,
                child: CustomTextSL(
                  size: 13.0,
                  text: "Expend/Collapes to 1st Level",
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),
              onPress: () {
                _provider.expendCollapesFisrtLevel();
                AppUtiles.printLog("Expend/Collapes to 1st Level");
              },
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 26),
          Expanded(
            child: CustomRaisedButton(
              child: CustomTextSL(
                text: "Expend/Collapes to 2nd Level",
                color: Colors.white,
                size: 13.0,
                textAlign: TextAlign.center,
              ),
              onPress: () {
              //  setState(() {
                  _provider.expendCollapesSecondLevel();
              //  });

                AppUtiles.printLog("Expend/Collapes to 2nd Level");
              },
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget selectAllRights() {
    return Container(
      decoration: BoxDecorationShadowRectangle(),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: CheckBoxListTileCustom(
          list: selectAllRightList,
          isDivider: true,
          checkChangedListener: (CheckBoxValue item , int index) {
            //selectAllRightList.forEach((element) { print(element.name);});
            //AppUtiles.printLog(selectAllRightList.toString());

            if(index==0) {
              _provider.updateViewAll(item.isChecked,);
            }else if(index==1){
              _provider.updateSaveAll(item.isChecked);
            }else if(index==2){
              _provider.updateUpdateAll(item.isChecked);
            }
            else if(index==3){
              _provider.updateDeleteAll(item.isChecked);
            }
            else if(index==4){
              _provider.updatePrintAll(item.isChecked);
            }
            else if(index==5){
              _provider.updateExprotToExcelCSVAll(item.isChecked);
            } else if(index==6){
              _provider.updateAllOthers(item.isChecked);
            }
          }),
    );
  }

  Widget generateReport() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CustomTextSL(
              text: "Generate Report",
              color: Colors.white,
              size: 13,
              textAlign: TextAlign.center,
            ),
          ),
          onPress: () {
            Navigator.pushNamed(context, AppLevelConstants.groupReportRoute , arguments: _provider.filterData );
            AppUtiles.printLog("Generate Report $_character");
          },
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Radio(
                  value: ReportWithRightWithOutRight.allRights,
                  groupValue: _character,
                  onChanged: (ReportWithRightWithOutRight? value) {
                    AppUtiles.printLog("All right");
                    setState(() {
                      _character = value!;
                    });
                  },
                ),
                CustomTextSL(text: "All Rights", size: 12,)
              ],
            ),
            Row(
              children: [
                Radio(
                  value: ReportWithRightWithOutRight.withOutRights,
                  groupValue: _character,
                  onChanged: (ReportWithRightWithOutRight? value) {
                    AppUtiles.printLog("with out right");
                    setState(() {
                      _character = value!;
                    });
                  },
                ),
                CustomTextSL(text: "Without Rights", size: 12,)

              ],
            ),
          ],
        )
      ],
    );
  }
}
