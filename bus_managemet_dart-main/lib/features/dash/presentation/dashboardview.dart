import 'dart:convert';
import 'dart:io';
import 'package:bus_management/features/dash/presentation/bus_view_model.dart';
import 'package:bus_management/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

final _heightGap = SizedBox(height: 20);
final _widthGap = SizedBox(width: 20);

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(busViewModelProvider.notifier).getbus();
    });
    super.initState();
  }

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('data:image')) {
      return MemoryImage(base64Decode(imageUrl.split(',').last));
    } else if (imageUrl.isNotEmpty) {
      return FileImage(File(imageUrl));
    } else {
      return AssetImage('assets/images/logo.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final busState = ref.watch(busViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 300),
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text('Bus Management System')
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 80,
                    child: Image.asset(
                      'assets/busregister.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 160),
            child: Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome Here!',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                          Icon(
                            Icons.bus_alert,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    _heightGap,
                    Text(
                      'Move From One City to Another',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Row(
                      children: [
                        Text(
                          'View Bus Here',
                          style: TextStyle(color: Colors.green),
                        ),
                        _widthGap,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(40, 30),
                              backgroundColor: Colors.green),
                          onPressed: () {
                            ref
                                .read(busViewModelProvider.notifier)
                                .resetState();
                          },
                          child: Text(
                            'Load Bus',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 310, right: 10, left: 10),
            child: Center(
              child: Container(
                child: busState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : busState.error != null
                        ? Center(child: Text(busState.error!))
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: busState.busApiModel?.length ?? 0,
                            itemBuilder: (context, index) {
                              final bus = busState.busApiModel![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.busDetailRoute,
                                      arguments: bus);
                                },
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          image: DecorationImage(
                                            image: _getImageProvider(
                                                '${bus.image}'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${bus.title}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text('Type: ${bus.busType}'),
                                            Text('Price: ${bus.ticketPrice}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
