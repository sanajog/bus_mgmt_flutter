import 'dart:convert';
import 'dart:io';
import 'package:bus_management/booked/service/book_service.dart';
import 'package:bus_management/features/dash/domain/bus_api_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusDetail extends ConsumerStatefulWidget {
  const BusDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BusDetailState();
}

class _BusDetailState extends ConsumerState<BusDetail> {

  final BookService _bookService = BookService();

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

  // void _bookBus() async{
  //   try {
  //     final response = await _bookService.bookBus(context, bookId);
  //   } catch (e) {
      
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var bus = ModalRoute.of(context)!.settings.arguments as BusApiModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Bus Detail Page",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    image: _getImageProvider('${bus.image}'),
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${bus.title}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.directions_bus, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  "Type: ${bus.busType}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  "Ticket Price: \Rs.${bus.ticketPrice}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () async{
                          print('Bus id is ${bus.id}');
                          if(bus!.id != null){
                            await _bookService.bookBus(context, bus.id.toString());
                          }
                        },
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ))))
          ],
        ),
      ),
    );
  }
}
