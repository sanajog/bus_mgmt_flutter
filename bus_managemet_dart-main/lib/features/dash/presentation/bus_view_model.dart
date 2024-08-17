import 'package:bus_management/features/dash/data/bus_remote_datesource.dart';
import 'package:bus_management/features/dash/presentation/bus_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final busViewModelProvider =
    StateNotifierProvider<BusViewModel, BusState>((ref) {
  return BusViewModel(ref.read(busRemoteDatasourceProvider));
});

class BusViewModel extends StateNotifier<BusState> {
  final BusRemoteDatasource busRemoteDatasource;
  BusViewModel(this.busRemoteDatasource) : super(BusState.initial());

  Future<void> getbus() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 1));
    final result = await busRemoteDatasource.getBus();
    result.fold((failure) {
      state = state.copyWith(
          isLoading: false, error: failure.error, busApiModel: null);
    }, (bus) {
      state = state.copyWith(isLoading: false, busApiModel: bus, error: null);
    });
  }

  void resetState() {
    getbus();
  }
}
