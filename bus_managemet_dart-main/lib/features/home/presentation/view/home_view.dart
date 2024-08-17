import 'package:bus_management/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeviewmodelProvider);
    return Scaffold(
      body: homeState.lstWidget[homeState.index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        selectedFontSize: 12,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 40),
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        elevation: 6,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Booked bus'),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user), label: 'Profile'),
        ],
        currentIndex: homeState.index,
        onTap: (index) {
          ref.read(homeviewmodelProvider.notifier).changeIndex(index);
        },
      ),
    );
  }
}
