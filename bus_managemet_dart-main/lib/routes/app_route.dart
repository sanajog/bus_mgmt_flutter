import 'package:bus_management/features/auth/presentation/view/signinview.dart';
import 'package:bus_management/features/auth/presentation/view/signupview.dart';
import 'package:bus_management/features/dash/presentation/bus_detail.dart';
import 'package:bus_management/features/dash/presentation/dashboardview.dart';
import 'package:bus_management/features/home/presentation/view/home_view.dart';

class AppRoute{
  AppRoute._();

  static const String signupviewRoute = '/signupviewRoute';
  static const String signinRoute = '/signinRoute';
  static const String homeRoute = '/homeRoute';
  static const String dashboardRoute = '/dashboardRoute';
  static const String busDetailRoute = '/busDetailRoute';

  
  static getApplicationROute(){
    return {
      signupviewRoute: (context) => const SignupView(),
      signinRoute: (context) => const SignInView(),
      homeRoute: (context) =>  HomeView(),
      dashboardRoute: (context) => const DashboardView(),
      busDetailRoute: (context) => const BusDetail(),
    };
  }


}