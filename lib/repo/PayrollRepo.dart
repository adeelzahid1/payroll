import 'dart:convert';
import 'package:network/HttpService.dart';
import 'package:payroll/configuration/Constants.dart';
import 'package:payroll/modals/AddLeaveType.dart';
import 'package:payroll/modals/AllUserNameIds.dart';
import 'package:payroll/modals/AttendanceInOut.dart';
import 'package:payroll/modals/LeaveApplication.dart';

class PayRollRepo{
// ===================================================================
// ====================================================================
// =======================    Add Leave TYPE  =========================
// ====================================================================
// ====================================================================



/////////// Get Single Leave TYPE  by ID
  Future<APIRespons> getLeaveTypeById(int?  leaveTypeId) async {
    String url = "${Constants.baseUrl}leaveType/GetById?id=$leaveTypeId";

    APIRequest request =
    new APIRequest(url: url,  method: Method.GET);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status) {
          LeaveType leaveType = LeaveType.fromJson(response["leaveType"]);
          result.data = leaveType;
        }
        else{
          result.error = true;
          result.errorMessage = response["message"];
        }
      } else {
        result.errorMessage = "Can not add  Leave Type";
      }
      return result;
    });
  }

//// Add Leave TYPE
  Future<APIRespons> addLeaveType(LeaveType leaveType) async {
    String url = "${Constants.baseUrl}leaveType/add";
    Map<String, dynamic> dataJson = leaveType.toJson();
    dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){
          LeaveType leaveType = LeaveType.fromJson(response["leaveType"]);
          result.data = leaveType;
        }else{
          result.errorMessage = "Not Added";
          result.error = true;
        }
      } else {

        result.errorMessage = "Can not add Leave Type";
      }
      return result;
    });
  }


//// Update Leave TYPE
  Future<APIRespons> updateLeaveType(LeaveType  leaveType) async {
    String url = "${Constants.baseUrl}leaveType/update?id=${leaveType.id}";
    var jsonData = jsonEncode( leaveType.toJson());
    print("Json Update Employee Allowance ... ");
    print(jsonData);
    APIRequest request =
    new APIRequest(url: url, body: jsonData, method: Method.PUT);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {

        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          // LeaveType product = LeaveType.fromJson(response["value"]);

          result.data = response["leaveType"];
          // LeaveType product = LeaveType.fromJson(response["value"]); // {"status":true,"message":"Record Updated Successfully"} No Value Found

          // result.data = product;
        }else{
          result.errorMessage = "Not Updated";
          result.error = true;
        }
      } else {
        result.errorMessage = "Can not update Shift";
      }
      return result;
    });
  }


  /// Delete Leave TYPE by id
  Future<APIRespons> deleteLeaveType(int?  leaveTypeId) async {
    String url = "${Constants.baseUrl}leaveType/delete?id=$leaveTypeId";
    APIRequest request =
    new APIRequest(url: url, method: Method.DELETE);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        print('Response after delete Leave Type :  $response');
        //   LeaveType product = new LeaveType();
        result.data = "Deleted successfully";
      } else {
        result.errorMessage = "Can not deleted Leave Type";
      }
      return result;
    });
  }

  /// Get all Leave TYPE
  Future<APIRespons> getAllLeaveTypes() async{

    String url = "${Constants.baseUrl}leaveType/getall";
    APIRequest request = new APIRequest(url: url, method: Method.GET);

    return await HttpService.instance.callService(request).then((result) {
      if(!result.error && result.data!=null){
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          List<dynamic> leaveTypeList = response["leaveTypes"];
          List<LeaveType> list = [];
          for(int i=0; i<leaveTypeList.length; i++){
            LeaveType leaveType = LeaveType.fromJson(leaveTypeList[i]);
            list.add(leaveType);
          }
          result.data = list;
        }else{
          result.errorMessage = "Error found";
          result.error = true;
        }
      }
      else{
        result.errorMessage = "leaveType not found";
      }
      return result;
    }
    ).catchError((e){
      print('Api Not Fetch ');
    });
  }




// ====================================================================
// ====================================================================
// =======================    Leave Application  ======================
// ====================================================================
// ====================================================================



  Future<APIRespons> getLeaveApplicationById(int?  leaveApplicationId) async {
    String url = "${Constants.baseUrl}leaveApplication/GetById?id=$leaveApplicationId";

    APIRequest request =
    new APIRequest(url: url,  method: Method.GET);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status) {
          LeaveApplication leaveApplication = LeaveApplication.fromJson(response["leaveApplication"]);
          result.data = leaveApplication;
        }
        else{
          result.error = true;
          result.errorMessage = response["message"];
        }
      } else {
        result.errorMessage = "Can not add  Leave Application";
      }
      return result;
    });
  }

//// Add Leave Application
  Future<APIRespons> addLeaveApplication(LeaveApplication leaveApplication) async {
    String url = "${Constants.baseUrl}leaveApplication/add";
    Map<String, dynamic> dataJson = leaveApplication.toJson();
    dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){
          LeaveApplication leaveApplication = LeaveApplication.fromJson(response["leaveApplication"]);
          result.data = leaveApplication;
        }else{
          result.errorMessage = "Not Added";
          result.error = true;
        }
      } else {
        result.errorMessage = "Can not add Leave Application";
      }
      return result;
    });
  }


//// Update  Leave Application Name
  Future<APIRespons> updateLeaveApplication(LeaveApplication  leaveApplication) async {
    String url = "${Constants.baseUrl}leaveApplication/update?id=${leaveApplication.id}";
    var jsonData = jsonEncode( leaveApplication.toJson());
    print("Json Update Employee Allowance ... ");
    print(jsonData);
    APIRequest request =
    new APIRequest(url: url, body: jsonData, method: Method.PUT);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {

        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          // LeaveApplication product = LeaveApplication.fromJson(response["value"]);

          result.data = response["leaveApplication"];
          // LeaveApplication product = LeaveApplication.fromJson(response["value"]); // {"status":true,"message":"Record Updated Successfully"} No Value Found

          // result.data = product;
        }else{
          result.errorMessage = "Not Updated";
          result.error = true;
        }
      } else {
        result.errorMessage = "Can not update Shift";
      }
      return result;
    });
  }


  // Delete Leave Application by id
  Future<APIRespons> deleteLeaveApplication(LeaveApplication leaveApplication) async {
      String url = "${Constants.baseUrl}leaveApplication/accept";
      Map<String, dynamic> dataJson = leaveApplication.toJson();
      //dataJson.remove("id");
      var jsonData = jsonEncode(dataJson);

      APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.DELETE);
      return await HttpService.instance.callService(request).then((result) {
        if (!result.error && result.data != null) {
          var response = jsonDecode(result.data.toString());
          print('Response after delete Leave Application :  $response');
          bool status = response["status"];
          if(status){
            // LeaveApplication leaveApplication = LeaveApplication.fromJson(response["message"]);
            var message = response["message"];
            result.data = message;
          }else{
            result.errorMessage = "Not Added";
            result.error = true;
          }
          //   LeaveApplication product = new LeaveApplication();
         // result.data = "Deleted successfully";
        } else {
          result.errorMessage = "Operation Failed";
        }
        return result;
      });
    }

  // Delete Leave Application by id
  Future<APIRespons> rejectLeaveApplication(LeaveApplication leaveApplication) async {
    String url = "${Constants.baseUrl}leaveApplication/reject";
    Map<String, dynamic> dataJson = leaveApplication.toJson();
    //dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.DELETE);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        print('Response after delete Leave Application :  $response');
        bool status = response["status"];
        if(status){
          // LeaveApplication leaveApplication = LeaveApplication.fromJson(response["message"]);
          var message = response["message"];
          result.data = message;
        }else{
          result.errorMessage = "Not Added";
          result.error = true;
        }
        //   LeaveApplication product = new LeaveApplication();
        // result.data = "Deleted successfully";
      } else {
        result.errorMessage = "Operation Failed";
      }
      return result;
    });
  }

  // Future<APIRespons> deleteLeaveApplication(int?  leaveApplicationId) async {
  //   String url = "${Constants.baseUrl}leaveApplication/delete?id=$leaveApplicationId";
  //   APIRequest request =
  //   new APIRequest(url: url, method: Method.DELETE);
  //   return await HttpService.instance.callService(request).then((result) {
  //     if (!result.error && result.data != null) {
  //       var response = jsonDecode(result.data.toString());
  //       print('Response after delete Leave Application :  $response');
  //       //   LeaveApplication product = new LeaveApplication();
  //       result.data = "Deleted successfully";
  //     } else {
  //       result.errorMessage = "Can not deleted Leave Application";
  //     }
  //     return result;
  //   });
  // }

  /// Get all Leave Applications
  Future<APIRespons> getAllLeaveApplications() async{

    String url = "${Constants.baseUrl}leaveApplication/getall";
    APIRequest request = new APIRequest(url: url, method: Method.GET);

    return await HttpService.instance.callService(request).then((result) {
      if(!result.error && result.data!=null){
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          List<dynamic> leaveApplicationList = response["leaveApplications"];
          List<LeaveApplication> list = [];
          for(int i=0; i<leaveApplicationList.length; i++){
            LeaveApplication leaveApplication = LeaveApplication.fromJson(leaveApplicationList[i]);
            list.add(leaveApplication);
          }
          result.data = list;
        }else{
          result.errorMessage = "Error found";
          result.error = true;
        }
      }
      else{
        result.errorMessage = "leaveApplication not found";
      }
      return result;
    }
    ).catchError((e){
      print('Api Not Fetch ');
    });
  }


  /// Get all User Name and ID's  // Leave Application
  Future<APIRespons> getAllUserNameId() async{
    String url = "${Constants.baseUrl}account/getidname";
    APIRequest request = new APIRequest(url: url, method: Method.GET);

    return await HttpService.instance.callService(request).then((result) {
      if(!result.error && result.data!=null){
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          List<dynamic> leaveApplicationList = response["getlist"];
          List<AllUserNameId> list = [];
          for(int i=0; i<leaveApplicationList.length; i++){
            AllUserNameId leaveApplication = AllUserNameId.fromJson(leaveApplicationList[i]);
            list.add(leaveApplication);
          }
          result.data = list;
        }else{
          result.errorMessage = "Error found";
          result.error = true;
        }
      }
      else{
        result.errorMessage = "leaveApplication not found";
      }
      return result;
    }
    ).catchError((e){
      print('Api Not Fetch ');
    });
  }


// ====================================================================
// ====================================================================
// =======================    AttendanceInOut  ======================
// ====================================================================
// ====================================================================


/////////// Get Single AttendanceInOut by ID
  Future<APIRespons> getAttendanceInOutById(int?  attendanceInOut) async {
    String url = "${Constants.baseUrl}attendance/GetById?id=$attendanceInOut";

    APIRequest request =
    new APIRequest(url: url,  method: Method.GET);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status) {
          AttendanceInOut leaveApplication = AttendanceInOut.fromJson(response["attendance"]);
          result.data = leaveApplication;
        }
        else{
          result.error = true;
          result.errorMessage = response["message"];
        }
      } else {
        result.errorMessage = "Can not add  Attendance";
      }
      return result;
    });
  }

//// Add AttendanceInOut
  Future<APIRespons> addAttendanceInOut(AttendanceInOut leaveApplication) async {
    String url = "${Constants.baseUrl}attendance/inTime";
    Map<String, dynamic> dataJson = leaveApplication.toJson();
    dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){
          AttendanceInOut leaveApplication = AttendanceInOut.fromJson(response["attendance"]);
          result.data = leaveApplication;
        }else{
          result.errorMessage = "Not Added";
          result.error = true;
        }
      } else {

        result.errorMessage = "Can not add AttendanceInOut";
      }
      return result;
    });
  }

  Future<APIRespons> updateAttendanceInOut(AttendanceInOut attendance) async {
    String url = "${Constants.baseUrl}attendance/outTime?id=${attendance.employeeId}";
    Map<String, dynamic> dataJson = attendance.toJson();
    dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request = new APIRequest(url: url, body: jsonData, method: Method.POST);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){
          // AttendanceInOut leaveApplication = AttendanceInOut.fromJson(response["attendance"]);
          result.data = response["message"];
        }else{
          result.errorMessage = "Not Added";
          result.error = true;
        }
      } else {

        result.errorMessage = "Unable to save Attendance OUT";
      }
      return result;
    });
  }


//// Update  AttendanceInOut Name
//   Future<APIRespons> updateAttendanceInOut(AttendanceInOut  leaveApplication) async {
//     String url = "${Constants.baseUrl}attendance/update?id=${leaveApplication.id}";
//     var jsonData = jsonEncode( leaveApplication.toJson());
//     print(jsonData);
//     APIRequest request =
//     new APIRequest(url: url, body: jsonData, method: Method.PUT);
//     return await HttpService.instance.callService(request).then((result) {
//       if (!result.error && result.data != null) {
//
//         var response = jsonDecode(result.data.toString());
//         bool status = response["status"];
//         if(status){
//
//           // AttendanceInOut product = AttendanceInOut.fromJson(response["value"]);
//
//           result.data = response["attendance"];
//           // AttendanceInOut product = AttendanceInOut.fromJson(response["value"]); // {"status":true,"message":"Record Updated Successfully"} No Value Found
//
//           // result.data = product;
//         }else{
//           result.errorMessage = "Not Updated";
//           result.error = true;
//         }
//       } else {
//         result.errorMessage = "Can not update Shift";
//       }
//       return result;
//     });
//   }


  /// Delete AttendanceInOut by id
  Future<APIRespons> deleteAttendanceInOut(int?  attendanceInOut) async {
    String url = "${Constants.baseUrl}attendance/delete?id=$attendanceInOut";
    APIRequest request =
    new APIRequest(url: url, method: Method.DELETE);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        print('Response after delete attendance :  $response');
        //   AttendanceInOut product = new AttendanceInOut();
        result.data = "Deleted successfully";
      } else {
        result.errorMessage = "Can not deleted Attendance";
      }
      return result;
    });
  }

  /// Get all AttendanceInOuts
  Future<APIRespons> getAllAttendanceInOuts() async{

    String url = "${Constants.baseUrl}attendance/getall";
    APIRequest request = new APIRequest(url: url, method: Method.GET);

    return await HttpService.instance.callService(request).then((result) {
      if(!result.error && result.data!=null){
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if(status){

          List<dynamic> leaveApplicationList = response["leaveApplications"];
          List<AttendanceInOut> list = [];
          for(int i=0; i<leaveApplicationList.length; i++){
            AttendanceInOut leaveApplication = AttendanceInOut.fromJson(leaveApplicationList[i]);
            list.add(leaveApplication);
          }
          result.data = list;
        }else{
          result.errorMessage = "Error found";
          result.error = true;
        }
      }
      else{
        result.errorMessage = "leaveApplication not found";
      }
      return result;
    }
    ).catchError((e){
      print('Api Not Fetch ');
    });
  }
}
