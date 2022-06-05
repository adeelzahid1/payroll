import 'dart:convert';
import 'package:network/HttpService.dart';
import 'package:payroll/configuration/Constants.dart';
import 'package:payroll/jsondata/JsonData.dart';
import 'package:payroll/modals/ClaimsList.dart';
import 'package:payroll/modals/Role.dart';


class RolesClaimsRepo {
  //======================= ONLY CLAIMS ====================
  //======================= ONLY CLAIMS ====================
  //======================= ONLY CLAIMS ====================

  /////////// Get Single ROLE  by ID
  Future<APIRespons> getRoleById(String? roleId) async {
    String url = "${Constants.baseUrl}role/GetById?id=$roleId";

    APIRequest request = new APIRequest(url: url, method: Method.GET);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if (status) {
          Role role = Role.fromJson(response["role"]);
          result.data = role;
        } else {
          result.error = true;
          result.errorMessage = response["message"];
        }
      } else {
        result.errorMessage = "Can not add  ROLE";
      }
      return result;
    });
  }

//// Add ROLE
  Future<APIRespons> addRole(Role role) async {
    String url = "${Constants.baseUrl}role/add";
    Map<String, dynamic> dataJson = role.toJson();
    dataJson.remove("id");
    var jsonData = jsonEncode(dataJson);

    APIRequest request =
        new APIRequest(url: url, body: jsonData, method: Method.POST);
    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if (status) {
          Role role = Role.fromJson(response["role"]);
          result.data = role;
        } else {
          result.errorMessage = "Not Added";
          result.error = true;
        }
      } else {
        result.errorMessage = "Can not add ROLE";
      }
      return result;
    });
  }

// //// Update ROLE
//   Future<APIRespons> updateRole(Role role) async {
//     String url = "${Constants.baseUrl}role/update?id=${role.id}";
//     var jsonData = jsonEncode(role.toJson());
//     print("Json Update ROLE ... ");
//     print(jsonData);
//     APIRequest request =
//         new APIRequest(url: url, body: jsonData, method: Method.PUT);
//     return await HttpService.instance.callService(request).then((result) {
//       if (!result.error && result.data != null) {
//         var response = jsonDecode(result.data.toString());
//         bool status = response["status"];
//         if (status) {
//           // Role product = Role.fromJson(response["value"]);
//
//           result.data = response["role"];
//           // Role product = Role.fromJson(response["value"]); // {"status":true,"message":"Record Updated Successfully"} No Value Found
//
//           // result.data = product;
//         } else {
//           result.errorMessage = "Not Updated";
//           result.error = true;
//         }
//       } else {
//         result.errorMessage = "Can not update Shift";
//       }
//       return result;
//     });
//   }
//
//   /// Delete ROLE by id
//   Future<APIRespons> deleteRole(int? roleId) async {
//     String url = "${Constants.baseUrl}role/delete?id=$roleId";
//     APIRequest request = new APIRequest(url: url, method: Method.DELETE);
//     return await HttpService.instance.callService(request).then((result) {
//       if (!result.error && result.data != null) {
//         var response = jsonDecode(result.data.toString());
//         print('Response after delete ROLE :  $response');
//         //   Role product = new Role();
//         result.data = "Deleted successfully";
//       } else {
//         result.errorMessage = "Can not deleted ROLE";
//       }
//       return result;
//     });
//   }

  /// Get all ROLE
  Future<APIRespons> getAllRoles() async {
    String url = "${Constants.baseUrl}role/getall";
    APIRequest request = new APIRequest(url: url, method: Method.GET);

    return await HttpService.instance.callService(request).then((result) {
      if (!result.error && result.data != null) {
        var response = jsonDecode(result.data.toString());
        bool status = response["status"];
        if (status) {
          List<dynamic> roleList = response["roles"];
          List<Role> list = [];
          for (int i = 0; i < roleList.length; i++) {
            Role role = Role.fromJson(roleList[i]);
            list.add(role);
          }
          result.data = list;
        } else {
          result.errorMessage = "Error found";
          result.error = true;
        }
      } else {
        result.errorMessage = "role not found";
      }
      return result;
    }).catchError((e) {
      print('Api Not Fetch ');
    });
  }

//======================= ROLES CLAIMS MODIFICATION ====================
//======================= ROLES CLAIMS MODIFICATION ====================
//======================= ROLES CLAIMS MODIFICATION ====================

  /// Get all ROLE
  Future<APIRespons> getAllClaims() async {
    String url = "${Constants.baseUrl}UserClaims/GetClaimjson";
    APIRequest request = new APIRequest(url: url, method: Method.GET);

    APIRespons respons = new APIRespons();
    respons.statusCode = 200;
    var response = jsonDecode(JsonData.getAllClaims());
    bool status = response["status"];
    if (status) {
      ClaimsList claimsdsd = ClaimsList.fromJson(response);

      respons.data = claimsdsd as ClaimsList;
    }

    return respons;


  //   return await HttpService.instance.callService(request).then((result) {
  //     if (!result.error && result.data != null) {
  //       var response = jsonDecode(result.data.toString());
  //       bool status = response["status"];
  //       if (status) {
  //         ClaimsList claimsdsd = ClaimsList.fromJson(response);
  //
  //         result.data = claimsdsd as ClaimsList;
  //       } else {
  //         result.errorMessage = "Error found";
  //         result.error = true;
  //       }
  //     } else {
  //       result.errorMessage = "role not found";
  //     }
  //     return result;
  //   });
  }






}
