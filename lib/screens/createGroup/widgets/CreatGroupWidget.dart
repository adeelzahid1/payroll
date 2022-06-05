import 'dart:math';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:payroll/modals/Group.dart';
import 'package:payroll/modals/GroupType.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DropDown/CustomDropDown.dart';

import 'package:payroll/widgets/TextField/TextFormFieldWidget.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';

class CreateGroupWidget extends StatefulWidget {
  Function onSave;
  Group group;

  CreateGroupWidget(this.group, this.onSave);

  @override
  _CreateGroupWidgetState createState() => _CreateGroupWidgetState();
}

final List<DropDownVal> _DropDownValList = [
  DropDownVal(name: 'Select Group Type', value: -1),
  DropDownVal(name: 'Admin', value: 1),
  DropDownVal(name: 'Shop keeper', value: 2),
  DropDownVal(name: 'Sale Man', value: 3),
  DropDownVal(name: 'Supper Admin', value: 4),
];
DropDownVal _DropDownVal = DropDownVal();
late List<DropdownMenuItem<DropDownVal>> _DropDownValDropdownList; // late
// var _DropDownValDropdownList; // late

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  @override
  void initState() {
    // _DropDownValDropdownList = AppUtiles.buildDropDownValDropdown(_DropDownValList);
    _DropDownValDropdownList = AppUtiles.buildDropDownValDropdown(_DropDownValList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.group.groupType != null) {
      final index = _DropDownValList.indexWhere(
          (element) => element.value == widget.group.groupType!.id);
      if (index != -1) {
        _DropDownVal = _DropDownValList[index];
      } else {
        if (_DropDownValList.length > 0) _DropDownVal = _DropDownValList[0];
      }
    } else {
      if (_DropDownValList.length > 0) _DropDownVal = _DropDownValList[0];
    }

    GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
    bool isUpdate = widget.group.id != -1;
    return Container(
      decoration: BoxDecorationShadowRectangle(),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Form(
        key: globalKey,
        child: Column(
          children: [
            AppUtiles.isInRow(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: getNameAndGroupType()),
                      SizedBox(width: 20),
                      Expanded(child: getCommentField()),
                    ],
                  )
                : Column(
                    children: [
                      getNameAndGroupType(),

                      getCommentField(),
                    ],
                  ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppUtiles.getButtonHMarginPlatForm(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isUpdate
                      ? Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: CustomRaisedButton(
                              child: CustomTextSL(
                                text: "Clear",
                                color: Colors.white,
                              ),
                              onPress: () {
                                setState(() {
                                  widget.group = new Group();
                                });
                              },
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                      )
                      : SizedBox.shrink(),
                  Expanded(
                    child: CustomRaisedButton(
                      child: CustomTextSL(
                        text: isUpdate ? "Update" : "Save",
                        color: Colors.white,
                      ),
                      onPress: () {
                        bool isGroupTypSelected = widget.group.groupType != null &&
                            widget.group.groupType!.id != -1;
                        if (!isGroupTypSelected) {
                          AppUtiles.showSnackBar(
                              context, "Please Select Group Type");
                        }
                        if (globalKey.currentState!.validate() &&
                            isGroupTypSelected) {
                          globalKey.currentState!.save();

                          if (isUpdate) {
                            widget.onSave(true);
                          } else {
                            widget.onSave(false);
                            widget.group.id = new Random().nextInt(5000);
                          }
                        } else {
                          print("in Valid");
                        }
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget getNameAndGroupType() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWidget(
            hint: "Enter Name",
            label: "Name",
            initalVal: widget.group.name,
            onChange: (value) {
              widget.group.name = value;
            },
            onSave: (String? value) {
              setState(() {
                widget.group.name = value;
              });
            },
            validate: RequiredValidator(errorText: "Enter name"),
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(height: 16),
          CustomTextSL(text: "Select Group Type"),
          SizedBox(height: 4),
          CustomDropdown(
             dropdownMenuItemList: _DropDownValDropdownList,
            //DropDownValuesList: _DropDownValDropdownList,
            onChanged: (DropDownVal? selectedItme) {
              setState(() {
                if (widget.group.groupType == null) {
                  widget.group.groupType = new GroupType();
                }
                widget.group.groupType!.id = selectedItme!.value!;
                widget.group.groupType!.name = selectedItme.name!;
              });
            },
            value: _DropDownVal,
            // value: _DropDownVal,
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  Widget getCommentField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: TextFormFieldWidget(
        hint: "Enter Comments",
        label: "Comments",
        initalVal: widget.group.comment,
        onChange: (val) {
          widget.group.comment = val;
        },
        onSave: (String? value) {
          setState(() {
            widget.group.comment = value;
          });
        },
        textCapitalization: TextCapitalization.sentences,
        textInputType: TextInputType.multiline,
        minLine: 1,
        maxLines: 4,
      ),
    );
  }

}
