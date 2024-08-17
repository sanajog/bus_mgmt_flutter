import 'dart:convert';
import 'package:bus_management/features/dash/data/failure.dart';
import 'package:bus_management/features/dash/domain/bus_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final busRemoteDatasourceProvider = Provider<BusRemoteDatasource>((ref) {
  return BusRemoteDatasource();
});

class BusRemoteDatasource {
  final storage = FlutterSecureStorage();

  Future<Either<Failure, List<BusApiModel>>> getBus() async {
    try {
      final url = 'http://10.0.2.2:5500/api/getallbus';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          final List<dynamic> busListJson = responseData['getAllBus'];
          final List<BusApiModel> busList =
              busListJson.map((json) => BusApiModel.fromJson(json)).toList();
          return Right(busList);
        } else {
          return Left(Failure(error: responseData['message']));
        }
      } else {
        return Left(Failure(
          error: 'Failed to fetch data',
          statusCode: response.statusCode.toString(),
        ));
      }
    } catch (e) {
      return Left(Failure(
        error: 'An error occurred: $e',
      ));
    }
  }
}
