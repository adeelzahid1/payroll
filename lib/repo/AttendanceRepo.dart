import 'dart:convert';
import 'package:network/HttpService.dart';
import 'package:payroll/configuration/Constants.dart';
import 'package:payroll/modals/LeaveBalanceView.dart';
import 'package:payroll/modals/ViewAttendance.dart';
import 'package:payroll/modals/ViewAttendanceGrid.dart';

class AttendanceRepo{
  // ====================================================================
// ====================================================================
// =======================    View Attendance  ======================
// ====================================================================
// ====================================================================



  Future<APIRespons> getViewAttendanceById(int?  viewAttendanceId) async {
    String url = "${Constants.baseUrl}viewAttendance/GetById?id=$viewAttendanceId";

    APIRequest request =
    new APIRequest(url: url,  method: Method.GET);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status) {
          ViewAttendance viewAttendance = ViewAttendance.fromJson(response["viewAttendance"]);
          result.data = viewAttendance;
        }
        else{
          result.error = true;
          result.errorMessage = response["message"];
        }
      } else {
        result.errorMessage = "Can not add  View Attendance";
      }
      return result;
    });
  }

//// Add View Attendance
  Future<APIRespons> addViewAttendance(ViewAttendance viewAttendance) async {
    // String url = "${Constants.baseUrl}viewAttendance/add";
    String url = "${Constants.baseUrl}Attendance/AttendanceView";
    Map<String, dynamic> dataJson = viewAttendance.toJson();
    dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);
    return await HttpService.instance.callService(request).then((result) {
      if(!result.error && result.data!=null){
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          List<dynamic> viewAttendanceList = response["query"];
          List<ViewAttendanceGrid> list = [];
          for(int i=0; i<viewAttendanceList.length; i++){
            ViewAttendanceGrid viewAttendance = ViewAttendanceGrid.fromJson(viewAttendanceList[i]);
            list.add(viewAttendance);
          }
          result.data = list;
        }else{
          result.errorMessage = "Error found";
          result.error = true;
        }
      }
      else {

        result.errorMessage = "Can not add View Attendance";
      }
      return result;
    });
  }


//// Update  View Attendance Name
  Future<APIRespons> updateViewAttendance(ViewAttendance  viewAttendance) async {
    String url = "${Constants.baseUrl}viewAttendance/update?id=${viewAttendance.id}";
    var jsonData = jsonEncode( viewAttendance.toJson());
    print(jsonData);
    APIRequest request =
    new APIRequest(url: url, body: jsonData, method: Method.PUT);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {

        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          // ViewAttendance product = ViewAttendance.fromJson(response["value"]);

          result.data = response["viewAttendance"];
          // ViewAttendance product = ViewAttendance.fromJson(response["value"]); // {"status":true,"message":"Record Updated Successfully"} No Value Found

          // result.data = product;
        }else{
          result.errorMessage = "Not Updated";
          result.error = true;
        }
      } else {
        result.errorMessage = "Can not update";
      }
      return result;
    });
  }


  /// Delete View Attendance by id
  Future<APIRespons> deleteViewAttendance(int?  viewAttendanceId) async {
    String url = "${Constants.baseUrl}viewAttendance/delete?id=$viewAttendanceId";
    APIRequest request =
    new APIRequest(url: url, method: Method.DELETE);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        print('Response after delete View Attendance :  $response');
        //   ViewAttendance product = new ViewAttendance();
        result.data = "Deleted successfully";
      } else {
        result.errorMessage = "Can not deleted View Attendance";
      }
      return result;
    });
  }

  /// Get all View Attendances
  Future<APIRespons> getAllViewAttendances(viewAttendanceModel) async{

    // String url = "${Constants.baseUrl}viewAttendance/getall";
    // APIRequest request = new APIRequest(url: url, method: Method.GET);
    String url = "${Constants.baseUrl}Attendance/AttendanceView";
    Map<String, dynamic> dataJson = viewAttendanceModel.toJson();
    //dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);

    return await HttpService.instance.callService(request).then((result) {
      if(!result.error && result.data!=null){
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          List<dynamic> viewAttendanceList = response["attendanceView"];
          List<ViewAttendanceGrid> list = [];
          for(int i=0; i<viewAttendanceList.length; i++){
            ViewAttendanceGrid viewAttendance = ViewAttendanceGrid.fromJson(viewAttendanceList[i]);
            list.add(viewAttendance);
          }
          result.data = list;
        }else{
          result.errorMessage = "Error found";
          result.error = true;
        }
      }
      else{
        result.errorMessage = "viewAttendance not found";
      }
      return result;
    });
  }

  /// Check View Attendances
  Future<APIRespons> checkViewAttendances(viewAttendanceModel) async{

    // String url = "${Constants.baseUrl}viewAttendance/getall";
    // APIRequest request = new APIRequest(url: url, method: Method.GET);
    String url = "${Constants.baseUrl}Attendance/AttendanceView";
    Map<String, dynamic> dataJson = viewAttendanceModel.toJson();
    //dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);

    return await HttpService.instance.callService(request).then((result) {
      if(!result.error && result.data!=null){
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          List<dynamic> viewAttendanceList = response["attendanceView"];
          List<ViewAttendanceGrid> list = [];
          for(int i=0; i<viewAttendanceList.length; i++){
            ViewAttendanceGrid viewAttendance = ViewAttendanceGrid.fromJson(viewAttendanceList[i]);
            list.add(viewAttendance);
          }
          result.data = list;
        }else{
          result.errorMessage = "Error found";
          result.error = true;
        }
      }
      else{
        result.errorMessage = "viewAttendance not found";
      }
      return result;
    });
  }

  // ====================================================================
// ====================================================================
// =======================   Leave Balance View  ======================
// ====================================================================
// ====================================================================




  //// get leave balance view by id.. .
  Future<APIRespons> getLeaveBalanceViewById(int?  leaveBalanceId) async {
    String url = "${Constants.baseUrl}leaveBalance/GetById?id=$leaveBalanceId";

    APIRequest request =
    new APIRequest(url: url,  method: Method.GET);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status) {
          LeaveBalanceView leaveBalance = LeaveBalanceView.fromJson(response["leaveBalance"]);
          result.data = leaveBalance;
        }
        else{
          result.error = true;
          result.errorMessage = response["message"];
        }
      } else {
        result.errorMessage = "Can not add  View Attendance";
      }
      return result;
    });
  }
  
  
  
}