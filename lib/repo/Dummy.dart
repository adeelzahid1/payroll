import 'dart:convert';

import 'package:network/HttpService.dart';
import 'package:payroll/configuration/Constants.dart';
import 'package:payroll/modals/AttendanceInOut.dart';
import 'package:payroll/modals/LeaveBalanceView.dart';

class Dummy{

  // ====================================================================
// ====================================================================
// =======================    View Attendance  ======================
// ====================================================================
// ====================================================================




//// Add leave balance view
  Future<APIRespons> addLeaveBalanceView(LeaveBalanceView leaveBalance) async {
    String url = "${Constants.baseUrl}leaveBalance/add";
    Map<String, dynamic> dataJson = leaveBalance.toJson();
    dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){
          LeaveBalanceView leaveBalance = LeaveBalanceView.fromJson(response["leaveBalance"]);
          result.data = leaveBalance;
        }else{
          result.errorMessage = "Not Added";
          result.error = true;
        }
      } else {

        result.errorMessage = "Can not add View Attendance";
      }
      return result;
    });
  }

}
