import 'package:bus_management/features/dash/domain/bus_api_model.dart';

class BusState {
  final bool isLoading;
  final String? error;
  final List<BusApiModel>? busApiModel;

  BusState({
    required this.isLoading,
    this.error,
    this.busApiModel,
  });

  factory BusState.initial() {
    return BusState(isLoading: false, error: null, busApiModel: null);
  }

  BusState copyWith({
    bool? isLoading,
    String? error,
    List<BusApiModel>? busApiModel,
  }) {
    return BusState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      busApiModel: busApiModel ?? this.busApiModel,
    );
  }
}
