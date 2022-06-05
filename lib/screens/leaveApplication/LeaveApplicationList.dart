import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/modals/LeaveApplication.dart';

import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/leaveApplication/LeaveApplicationDataNotifier.dart';
import 'package:payroll/screens/leaveApplication/addLeaveApplication/AddLeaveApplicationDataNotifier.dart';
import 'package:payroll/screens/leaveApplication/dataTableSource/LeaveApplicationDataTableSource.dart';


import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DataTable/CustomPaginatedTable.dart';
import 'package:payroll/widgets/TextField/TextFormFieldWidget.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:payroll/widgets/buttons/ClickableButton.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';


class LeaveApplicationScreen extends StatefulWidget {
  @override
  _LeaveApplicationScreenState createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Applications "),
        // actions: [
        //   RoundIconButton(icon: Icons.add, onPress: (){}, fillColor: Colors.lightBlue),
        // ],
      ),
      body: ChangeNotifierProvider<LeaveApplicationDataNotifier>(
        create: (_) => LeaveApplicationDataNotifier(),
        child: _InternalWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeProvider.themeData().primaryColor,
        tooltip: "Add New Leave Application",
        child: Icon(Icons.add, color: themeProvider.themeMode().textColorOnPrimary),
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(
              context, PayRollAppPagesConstants.addLeaveApplicationWidget, arguments: null);
          if (result != null) {
            LeaveApplication updatedLeaveApplication = result as LeaveApplication;
            _provider.addUpdateLeaveApplication(updatedLeaveApplication, false);
          }
        },
      ),
    );
  }
}

late LeaveApplicationDataNotifier _provider;

class _InternalWidget extends StatefulWidget {
  @override
  __InternalWidgetState createState() => __InternalWidgetState();
}

class __InternalWidgetState extends State<_InternalWidget> {
  //TextEditingController _reasonText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LeaveApplicationDataNotifier _provider = context.watch<LeaveApplicationDataNotifier>();
   // AddLeaveApplicationDataNotifier leaveAppVM = context.watch<AddLeaveApplicationDataNotifier>();
    List<LeaveApplication> _model = _provider.filterData;

    final _dtSource = LeaveApplicationDataTableSource(
      departmentData: _model,

      onRowSelect: (index) async {
        dynamic result = await Navigator.pushNamed(
            context, PayRollAppPagesConstants.addLeaveApplicationWidget, arguments: _model[index].id);

        if (result != null) {
          LeaveApplication updatedLeaveApplication = result as LeaveApplication;
          _provider.addUpdateLeaveApplication(updatedLeaveApplication, true);
        }
      },
      onAccept: (int index) {
        AppUtiles.showDialogBoxSingleAction(
          context: context,
          title: "Confirmation",
          content: "Are you sure you want to Accept this request.",
          btnText: "Accept",
          function: () {
            _provider.acceptItemName(_model[index]).then((value) => {
              if (!value.error)
                // { AppUtiles.showSnackBar(context, "${value.data}"), }
                { AppUtiles.showSnackBar(context, "Request Accepted and Removed"), }
              else
                {AppUtiles.showSnackBar(context, "Error.")}
            });
          },
        );
      },

      onReject: (int index, bool isRejected){
        print("$index :  $isRejected");
        print("Reject Button Click");
        print(_model[index].reason);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 220,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //SizedBox(height: 10.0),
                        Center(
                          child: CustomTextSL(
                            textAlign: TextAlign.center,
                            text: "REASON",color: Colors.lightBlue,fontWeight: FontWeight.w500,size: 28.0,letterSpacing: 1.1,),
                        ),
                        //SizedBox(height: 10.0),
                        Form(
                          key: _provider.formKey,
                          autovalidate: _provider.autoValidate,
                          child: TextFormFieldWidget(
                            controller: _provider.reasonText,
                            minLine: 4,
                            maxLines: 4,
                            hint: "Leave Reject Reason",
                            label: "Reason",
                            onSave: (String? value)=> _provider.onSaveReason(value!),
                            //onChange: (String? text){_reasonText.text = text!;},
                            validate: _provider.validateReason,

                            // onSave: (String? value) => leaveAppVM.onSaveReason(value!),
                          ),
                        ),SizedBox(height: 13.0),

                        // RaisedButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     "Save",
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   color: const Color(0xFF1BC0C5),
                        // ),
                        ClickAbleButton(text: 'SUBMIT', color: Colors.blueAccent,width: 140, padding: 20,
                          onTap: () {
                          if(_provider.formKey.currentState!.validate()){
                            _provider.formKey.currentState!.save();
                            // _provider.checkdata(index);
                            _provider.rejectItemName(index).then((value) => {
                              if (!value.error)
                                { AppUtiles.showSnackBar(context, "Request Accepted and Removed"),
                                  _provider.reasonText.text = "",
                                }
                              else
                                {AppUtiles.showSnackBar(context, "Error.")}
                            });
                            Navigator.pop(context);

                            }
                          }
                          // onTap: (){
                          // print("dialog reject button click");
                          // _model[index].reason = _reasonText.text;
                          // _provider.rejectItemName(_model[index]).then((value) => {
                          //   if (!value.error)
                          //   // { AppUtiles.showSnackBar(context, "${value.data}"), }
                          //     { AppUtiles.showSnackBar(context, "Request Accepted and Removed"), }
                          //   else
                          //     {AppUtiles.showSnackBar(context, "Error.")}
                          // });
                          // Navigator.pop(context);
                          // },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }








    );

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecorationShadowRectangle(),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: CustomPaginatedTable(
          actions: <IconButton>[
            IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.save),
              tooltip: "Save File",
              onPressed: () {
                //_provider.fetchData();
                // _showSBar(context, DataTableConstants.refresh);
              },
            ),
            IconButton(
              splashColor: Colors.transparent,
              tooltip: "Print",
              icon: const Icon(Icons.print),
              onPressed: () {
                //_provider.fetchData();
                // _showSBar(context, DataTableConstants.refresh);
              },
            ),
          ],
          dataColumns: LeaveApplicationDataTableSource.colGen(_dtSource, _provider),
          header: TextField(
            onChanged: (value) {
              _provider.onSearchTextChanged(value);
            },
            decoration:
            InputDecoration(hintText: "Search Name", labelText: "Search"),
          ),
          onRowChanged: (index) => _provider.rowsPerPage = index!,
          rowsPerPage: _provider.rowsPerPage,
          //rowsPerPage: 20,
          showActions: true,
          source: _dtSource,
          sortColumnIndex: _provider.sortColumnIndex,
          sortColumnAsc: _provider.sortAscending,
        ),
      ),
    );
  }

  @override
  void dispose() {
   _provider.reasonText.dispose();
    super.dispose();
  }
}
