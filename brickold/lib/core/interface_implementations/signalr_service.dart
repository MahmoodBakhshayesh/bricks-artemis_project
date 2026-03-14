import 'dart:developer';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection _hubConnection;
  HubConnectionState get hubConnectionStatus => _hubConnection.state ?? HubConnectionState.Disconnected;

  SignalRService(
      {required String url,
      void Function({Exception? e})? onClose,
      void Function(String, void Function(List<Object?>?))? handler}) {
    _hubConnection = HubConnectionBuilder().withUrl(url).build();
    _hubConnection.onclose(({error}) {
      if (onClose != null) {
        onClose(e: error);
      } else {
        log(error.toString());
      }
    });
  }

  Future<void> connect() async {
    try {
      await _hubConnection.start();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> send({required String methodName, List<Object>? data}) async {
    try {
      return _hubConnection.send(methodName, args: data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Object> call({required String methodName, List<Object>? data}) async {
    try {
      return _hubConnection.invoke(methodName, args: data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void addHandler(String method, void Function(List<Object?>? data) handler) {
    _hubConnection.on(method, handler);

  }
}
