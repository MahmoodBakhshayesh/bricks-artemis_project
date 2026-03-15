import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/controllers/base_controller.dart';
import '../flights/usecases/get_flight_details_usecase.dart';
import 'flight_details_view_state.dart';

final flightDetailsControllerProvider = Provider.autoDispose<FlightDetailsController>((ref) {
  final flightId = ref.watch(currentFlightIdProvider);
  final getFlightDetailsUsecase = GetIt.instance.get<GetFlightDetailsUsecase>();
  final controller = FlightDetailsController(ref, flightId, getFlightDetailsUsecase);

  Future.microtask(controller.init);

  ref.onDispose(() => controller.dispose());

  return controller;
}, dependencies: [currentFlightIdProvider]);

class FlightDetailsController extends BaseController {
  final String _flightId;
  final GetFlightDetailsUsecase _getFlightDetailsUsecase;

  FlightDetailsController(super.ref, this._flightId, this._getFlightDetailsUsecase);

  @override
  void init() {
    super.init();
    getFlightDetails();
  }

  Future<void> getFlightDetails() async {
    logger.i('Fetching flight details for ID: $_flightId...');
    ref.read(flightDetailsStateProvider.notifier).state = const AsyncValue.loading();
    try {
      final response = await _getFlightDetailsUsecase.exec(GetFlightDetailsRequest(_flightId));
      if (!ref.container.exists(flightDetailsStateProvider)) return;
      ref.read(flightDetailsStateProvider.notifier).state = AsyncValue.data(response.flightDetails);
    } catch (e, st) {
      logger.e('Failed to fetch flight details for ID: $_flightId', error: e, stackTrace: st);
      if (!ref.container.exists(flightDetailsStateProvider)) return;
      ref.read(flightDetailsStateProvider.notifier).state = AsyncValue.error(e, st);
    }
  }
}
