import 'package:bus_management/features/dash/presentation/dashboardview.dart';
import 'package:bus_management/features/home/pages/profileview.dart';
import 'package:bus_management/booked/bookmarkview.dart';
import 'package:flutter/material.dart';

class HomeState {
  final List<Widget> lstWidget;
  final int index;

  HomeState({
    required this.lstWidget,
    required this.index,
  });

  factory HomeState.initial() {
    return HomeState(
        lstWidget: [DashboardView(), BookmarkView(), ProfileView()], index: 0);
  }

  //Copy with function
  HomeState copywith({int? index}) {
    return HomeState(lstWidget: lstWidget, index: index ?? this.index);
  }
}
