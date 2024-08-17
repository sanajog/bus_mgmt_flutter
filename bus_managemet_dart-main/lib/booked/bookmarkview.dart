import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_management/booked/service/book_service.dart';
import 'package:bus_management/constants/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkView extends ConsumerStatefulWidget {
  const BookmarkView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends ConsumerState<BookmarkView> {
  final BookService _bookService = BookService();
  List<dynamic>? _bookedData;

  void _getBookedBus(BuildContext context) async {
    try {
      final response = await _bookService.getBookedBus(context);
      print('Booked Bus API Response $response');
      if (response != null &&
          response['success'] == true &&
          response.containsKey('books')) {
        setState(() {
          _bookedData = response['books'];
        });
      } else {
        throw Exception(
            response['message'] ?? 'Failed to fetch booked bus data');
      }
    } catch (e) {
      print('Error fetching Booked bus: $e');
      showSnackBar(
        color: Colors.red,
        message: e.toString().replaceFirst('Exception: ', ''),
        context: context,
      );
    }
  }

  @override
  void initState() {
    _getBookedBus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            'Booked Bus',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _bookedData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _bookedData!.length,
                itemBuilder: (context, index) {
                  final bookedBus = _bookedData![index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          bookedBus['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        bookedBus['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type: ${bookedBus['busType']}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Price: ${bookedBus['ticketPrice']}',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        // Handle item tap if needed
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }

}
