
import 'package:auth/auth/configuration/Constants.dart';
import 'package:auth/auth/routes/AuthPageNotFound.dart';
import 'package:auth/auth/screens/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:payroll/modals/GroupCategoryRights.dart';
import 'package:payroll/screens/addAttendanceInOut/AddAttendanceInOut.dart';
import 'package:payroll/screens/assignRole/AssignRole.dart';
import 'package:payroll/screens/createGroup/CreateGroupScreen.dart';
import 'package:payroll/screens/groupType/GroupReportScreen.dart';
import 'package:payroll/screens/groupType/GroupRightsScreen.dart';
import 'package:payroll/screens/leaveApplication/LeaveApplicationList.dart';
import 'package:payroll/screens/leaveApplication/addLeaveApplication/AddLeaveApplication.dart';
import 'package:payroll/screens/leaveBalance/LeaveBalanceView.dart';
import 'package:payroll/screens/leaveType/LeaveTypeList.dart';
import 'package:payroll/screens/leaveType/addLeaveType/AddLeaveType.dart';
import 'package:payroll/screens/mainScreen/MainScreenPayroll.dart';
import 'package:payroll/screens/splash/PayRollSplashScreen.dart';
import 'package:payroll/screens/users/CreateUserScreen.dart';
import 'package:payroll/screens/users/UsersScreen.dart';
import 'package:payroll/screens/viewAttendance/ViewAttendanceList.dart';
import '../screens/viewAttendance/addViewAttendance/AddViewAttendance.dart';
import 'PayRollAppPagesConstants.dart';

class PayrollRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PayRollAppPagesConstants.splashPayRollPageRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => PayRollSplashScreen(),
          settings: settings,
        );
        break;

      case PayRollAppPagesConstants.loginPayRollPageRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
        break;
      case PayRollAppPagesConstants.mainScreenPayRoll:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => MainScreenPayroll(),
          settings: settings,
        );
        break;

      case PayRollAppPagesConstants.createUserRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => CreateUserScreen(),
          settings: settings,
        );
        break;

      case PayRollAppPagesConstants.usersRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => UsersScreen(),
          settings: settings,
        );
        break;

      case PayRollAppPagesConstants.createGroupRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => CreateGroupScreen(),
          settings: settings,
        );
        break;

      case PayRollAppPagesConstants.groupRightsRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => GroupRightsScreen(),
          settings: settings,
        );
        break;
      case PayRollAppPagesConstants.groupReportRoute: //todo : need to be fixed there
        List<GroupCategoryRights>? list = settings.arguments as List<GroupCategoryRights>?;
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => GroupReportScreen(list!),
          settings: settings,
        );
        break;


      // ====================== Leave Type  =======
      case PayRollAppPagesConstants.addLeaveTypeWidget:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => AddLeaveTypeWidget(),
          settings: settings,
        );
        break;

      case PayRollAppPagesConstants.leaveTypeScreen:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => LeaveTypeScreen(),
          settings: settings,
        );
        break;



        // ====================== Leave Application  =======
        case PayRollAppPagesConstants.addLeaveApplicationWidget:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => AddLeaveApplicationWidget(),
          settings: settings,
        );
        break;

        case PayRollAppPagesConstants.leaveApplicationScreen:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => LeaveApplicationScreen(),
          settings: settings,
        );
        break;


        // =========================  AddAttendanceInOutWidget ===
        case PayRollAppPagesConstants.addAttendanceInOutWidget:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => AddAttendanceInOutWidget(),
          settings: settings,
        );
        break;


        // ============ view Attendance Screen
      case PayRollAppPagesConstants.addViewAttendanceWidget:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => AddViewAttendanceWidget(), //todo  :: change it .
          settings: settings,
        );
        break;

        case PayRollAppPagesConstants.viewAttendanceGridScreen:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => ViewAttendanceGridScreen(),
          settings: settings,
        );
        break;

        case PayRollAppPagesConstants.leaveBalanceViewWidget:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => AddLeaveBalanceViewWidget(),
          settings: settings,
        );
        break;

        case PayRollAppPagesConstants.assignRoleWidget:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => AssignRoleWidget(),
          settings: settings,
        );
        break;



      default:
        {
          RouteSettings routeSettings = RouteSettings(name: Constants.PAGE_NOT_FOUND);
          return MaterialPageRoute(
              builder: (context) => AuthPageNotFound(settings.name),
              settings: routeSettings);
        }
    }
  }
}

/// A MaterialPageRoute without any transition animations.
class _NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    bool maintainState = true,
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) : super(
          builder: builder,
          maintainState: maintainState,
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return new FadeTransition(opacity: animation, child: child);
    //  return new RotationTransition(
    //      turns: animation,
    //      child: new ScaleTransition(
    //        scale: animation,
    //        child: new FadeTransition(
    //          opacity: animation,
    //          child: child,
    //        ),
    //      ));

    // return child;    // not animation
  }
}
