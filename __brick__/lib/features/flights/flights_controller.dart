import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/controllers/base_controller.dart';
import 'flights_view_state.dart';
import 'usecases/get_flights_usecase.dart';

final flightsControllerProvider = Provider.autoDispose((ref) {
  final getFlightsUsecase = GetIt.instance.get<GetFlightsUsecase>();
  final controller = FlightsController(ref, getFlightsUsecase);
  controller.init();
  ref.onDispose(() => controller.dispose());
  return controller;
});

class FlightsController extends BaseController {
  final GetFlightsUsecase _getFlightsUsecase;
  FlightsController(super.ref, this._getFlightsUsecase);

  @override
  void init() {
    super.init();
    getFlights();
  }

  Future<void> getFlights() async {
    logger.i('Fetching flights...');
    ref.read(flightsStateProvider.notifier).state = const AsyncValue.loading();
    try {
      final response = await _getFlightsUsecase.exec(GetFlightsRequest());
      if (!ref.container.exists(flightsStateProvider)) return;
      ref.read(flightsStateProvider.notifier).state = AsyncValue.data(response.flights);
    } catch (e, st) {
      logger.e('Failed to fetch flights', error: e, stackTrace: st);
      if (!ref.container.exists(flightsStateProvider)) return;
      ref.read(flightsStateProvider.notifier).state = AsyncValue.error(e, st);
    }
  }
}
