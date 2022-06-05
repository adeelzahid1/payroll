import 'package:flutter/material.dart';
import 'package:payroll/modals/GroupCategoryRights.dart';
import '../GroupCategoryRightNotifier.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/TextField/TextFieldWidget.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';
import 'package:payroll/widgets/expansionTile/AppExpansionTile.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';

class GroupRightsSelectionWidget extends StatefulWidget {
  GroupRightsSelectionWidget({Key? key}) : super(key: key);
  @override
  _GroupRightsSelectionWidgetState createState() =>
      _GroupRightsSelectionWidgetState();
}

GroupCategoryRightsNotifier? _provider;

class _GroupRightsSelectionWidgetState
    extends State<GroupRightsSelectionWidget> {
  // List<GroupCategoryRight> data;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _provider = context.watch<GroupCategoryRightsNotifier>();
    //if( data==null)
    // List<GroupCategoryRights> data = _provider!.filterData;
    List<GroupCategoryRights> data = _provider!.MegaList;

    return Container(
        decoration: BoxDecorationShadowRectangle(),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [

            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                      hint: "Search",
                      lable: "Search",
                      initalVal: "",
                      textCapitalization: TextCapitalization.sentences,
                      onChange: (String val){
                        _provider?.onSearchTextChanged(val);
                      },
                      onSave: (_){}),
                ),
                SizedBox(width: 12),
                //Expanded()
                CustomRaisedButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppUtiles.getButtonHPadding(context)),
                    child: CustomTextSL(
                      text: "Save",
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPress: () {
                    AppUtiles.printLog("Save");
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),

            ...data.map((e) {
              return AppExpansionTile(
                  key: e.expansionTile,
                  title: Text(e.title??""),
                  children: e.children.length==0 ? [] :
                  e.children.map((menu) {
                    if(menu.children == null) {
                      return
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            height: 35,
                            child: CheckboxListTile(
                              title:  Text(menu.title??"") ,
                              value: menu.isSelected,
                              onChanged: (bool? newVal) {
                                menu.isSelected = newVal;
                              },
                            ),
                          ),
                        );
                    }
                    else{
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppExpansionTile(
                            key: menu.expansionTile,
                            title: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 0),
                              child: Text(menu.title??""),
                            ),
                            children: menu.children.length == 0 ? [] :
                            [
                              ...menu.children.map((subMenu) {
                                // if(subMenu.children.isEmpty) {
                                  return   Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 32),
                                    child: SizedBox(
                                      height: 35,
                                      child: CheckboxListTile(
                                        title:  Text(subMenu.title??""),
                                        value: subMenu.isSelected,
                                        subtitle: Text(subMenu.value.toString() ?? "00"),
                                        onChanged: (bool? newVal) {
                                          setState(() {
                                            subMenu.isSelected = newVal;
                                          });
                                        },
                                      ),
                                    ),
                                  );

                                // }
                              }).toList()
                            ]
                        ),
                      );
                    }
                  }).toList()
              );
            }).toList()
          ],
        )




      // ListView.builder(
      //   itemCount: data.length,
      //   scrollDirection: Axis.vertical,
      //   shrinkWrap: true,
      //   itemBuilder: (BuildContext context, int index) =>
      //       GroupRightsItemWidget(
      //         data[index],
      //       ),
      // )

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //
      //   ],
      // ),
    );
  }
}
