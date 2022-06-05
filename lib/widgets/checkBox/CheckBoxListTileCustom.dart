import 'package:flutter/material.dart';
import 'package:payroll/modals/widgets/CheckBoxValue.dart';
import 'package:payroll/values/AppColors.dart';

class CheckBoxListTileCustom extends StatefulWidget {
  List<CheckBoxValue>? list;
  bool isDivider;
  Function  checkChangedListener;
  CheckBoxListTileCustom({ this.list, required this.checkChangedListener,  this.isDivider = true});

  @override
  _CheckBoxListTileCustomState createState() => _CheckBoxListTileCustomState();
}



class _CheckBoxListTileCustomState extends State<CheckBoxListTileCustom> {
  checkedChangeUpdate(CheckBoxValue item , int index){
    widget.checkChangedListener(item ,  index);
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.list?.length ?? 0,
      itemBuilder: (BuildContext context, int index){
        CheckBoxValue selectVal = widget.list![index];
        return  Column(
          children: [
            SizedBox(
              height: 40,
              child: CheckboxListTile(
                title: selectVal.name!=null && selectVal.name.length  > 0 ? Text(selectVal.name) : SizedBox.shrink(),
                value: selectVal.isChecked,
                onChanged: (bool? newVal) {
                  setState(() {
                    selectVal.isChecked = newVal!;
                  });
                  checkedChangeUpdate(selectVal, index);
                },
              ),
            ),

            if(widget.isDivider)
              Divider(height: 1, thickness: 1, color: AppColors.dividerColor)
          ],
        );
      },
    );


    //   Column(
    //   children:
    //
    //   widget.list
    //       .map(
    //         (t) => Column(
    //           children: [
    //             SizedBox(
    //               height: 40,
    //               child: CheckboxListTile(
    //                 title: t.name!=null && t.name.length  > 0 ? Text(t.name) : SizedBox.shrink(),
    //                 value: t.isChecked,
    //                 onChanged: (bool newVal) {
    //                   setState(() {
    //                     t.isChecked = newVal;
    //                   });
    //                   checkedChangeUpdate();
    //                 },
    //               ),
    //             ),
    //
    //             if(widget.isDivider)
    //             Divider(height: 1, thickness: 1, color: dividerColor,)
    //           ],
    //         ) ,
    //       ).toList(),
    // );
  }
}
