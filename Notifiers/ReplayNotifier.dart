import '../Listeners/Listener.dart';

class ReplayNotifier {
  List<Function> _listeners = [];
  List<dynamic> _value = [];

  ReplayNotifier() {}

  dynamic subscribe(Function _callback) {
    _listeners.add(_callback);

    _value.forEach((dynamic value) {
      _callback(value);
    });

    return Listener(
      index_: _listeners.length - 1,
      canceler_: _cancel,
      subscribe_: _resubscribe,
      callback_: _callback,
    );
  }

  dynamic _resubscribe(Function _callback, int index) {
    _listeners[index] = _callback;

    _value.forEach((dynamic value) {
      _callback(value);
    });
  }

  _cancel(int _index) {
    _listeners[_index] = null;
  }

  void notify(dynamic data) {
    _value.add(data);
    _listeners.forEach((Function _callback) {
      if (_callback != null) {
        _callback(data);
      }
    });
  }
}

/// Demo
void main() {
  var notifier = ReplayNotifier();

  Listener listner_1 = notifier.subscribe((data) {
    print("Recieved: $data in listener 1");
  });

  Listener listner_2 = notifier.subscribe((data) {
    print("Recieved: $data in listener 2");
  });

  notifier.notify({"name": "Yogesh"});

  listner_1.canceler();

  notifier.notify({"name": "Richa"});

  listner_2.canceler();
}
