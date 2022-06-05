import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?> onChanged;
  final T value;
  final bool isEnabled;
  CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            color: isEnabled ? Colors.transparent : Colors.grey.withAlpha(100)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            itemHeight: 50.0,
            style: TextStyle(
                fontSize: 15.0,
                color: isEnabled ? Colors.black : Colors.grey[700]),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            value: value,
          ),
        ),
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:payroll/modals/widgets/DropDownValue.dart';
//
// import '../TypeOfFunctions.dart';
//
// class CustomDropdown<T> extends StatefulWidget {
//   List<DropDownVal>? DropDownValuesList;
//   dynamic? selectedValue;
//   final ValueChanged<DropDownVal?> onChanged;
//   List<DropdownMenuItem<DropDownVal>> dropdownMenuItemList = [];
//   DropDownVal? value = null;
//   bool isEnabled;
//
//   CustomDropdown({
//     required this.onChanged,
//     Key? key,
//     this.DropDownValuesList,
//     this.selectedValue,
//     this.isEnabled = true,
//   }) : super(key: key);
//
//   @override
//   _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
// }
//
// class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
//   void dropdownValues() {
//     widget.dropdownMenuItemList =
//         buildDropDownValDropdown(widget.DropDownValuesList);
//     if (widget.selectedValue != null && widget.DropDownValuesList != null) {
//       final index = widget.DropDownValuesList!
//           .indexWhere((element) => element.value == widget.selectedValue);
//       if (index != -1) {
//         widget.value = widget.DropDownValuesList![index];
//       } else {
//         if (widget.DropDownValuesList!.length > 0)
//           widget.value = widget.DropDownValuesList![0];
//       }
//     } else {
//       if (widget.DropDownValuesList != null &&
//           widget.DropDownValuesList!.length > 0)
//         widget.value = widget.DropDownValuesList![0];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.dropdownMenuItemList == null ||
//         widget.dropdownMenuItemList.isEmpty) dropdownValues();
//     return IgnorePointer(
//       ignoring: !widget.isEnabled,
//       child: Container(
//         constraints: BoxConstraints(minHeight: 30),
//         padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//             border: Border.all(
//               color: Colors.black54,
//               width: 1,
//             ),
//             color: widget.isEnabled
//                 ? Colors.transparent
//                 : Colors.grey.withAlpha(100)),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton(
//             //isExpanded: true,
//             //itemHeight: 50.0,
//             style: TextStyle(
//                 fontSize: 15.0,
//                 color: widget.isEnabled ? Colors.black : Colors.grey[700]),
//             items: widget.dropdownMenuItemList,
//             onChanged: (DropDownVal? val) {
//               setState(() {
//                 widget.selectedValue = val!.value;
//                 widget.value = val;
//               });
//               widget.onChanged(val);
//             },
//             value: widget.value,
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<DropdownMenuItem<DropDownVal>> buildDropDownValDropdown(
//       List? DropDownValList) {
//     List<DropdownMenuItem<DropDownVal>> items = [];
//     if (DropDownValList != null) {
//       for (DropDownVal dropDownVal in DropDownValList) {
//         items.add(DropdownMenuItem(
//           value: dropDownVal,
//           child: Text(dropDownVal.name!),
//         ));
//       }
//     }
//     return items;
//   }
// }
//
//
