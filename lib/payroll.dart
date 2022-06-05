library payroll;

import 'package:auth/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:payroll/repo/AttendanceRepo.dart';
import 'package:payroll/repo/PayrollRepo.dart';
import 'package:payroll/repo/RolesClaimsRepo.dart';

import 'configuration/Constants.dart';

/// A Calculator.
class PayRoll {
  /// Returns [value] plus 1.
  static void initAuth(String pBaseUrl) {   //initAuth replaced with initPayRoll
    Constants.baseUrl = pBaseUrl;
    Auth.initAuth(pBaseUrl);
    if (!GetIt.I.isRegistered<PayRollRepo>()) {
      GetIt.I.registerLazySingleton(() {
        return PayRollRepo();
      });
    }

    if (!GetIt.I.isRegistered<AttendanceRepo>()) {
      GetIt.I.registerLazySingleton(() {
        return AttendanceRepo();
      });
    }

    if (!GetIt.I.isRegistered<RolesClaimsRepo>()) {
      GetIt.I.registerLazySingleton(() {
        return RolesClaimsRepo();
      });
    }


    // if( !GetIt.I.isRegistered<AuthRepo>())
    // {
    //   GetIt.I.registerLazySingleton(() {
    //     return AuthRepo();
    //   });
    // }


    // static void setUrl(String pBaseUrl) {
    //   Constants.baseUrl = pBaseUrl;
    // }
  }
}