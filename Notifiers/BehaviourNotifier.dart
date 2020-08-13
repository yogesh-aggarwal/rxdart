import '../Listeners/Listener.dart';

class BehaviourNotifier {
  List<Function> _listeners = [];
  dynamic _value;

  BehaviourNotifier([this._value = null]) {}

  dynamic subscribe(Function _callback) {
    _listeners.add(_callback);
    _callback(_value);
    return Listener(
      index_: _listeners.length - 1,
      canceler_: _cancel,
      subscribe_: _resubscribe,
      callback_: _callback,
    );
  }

  dynamic _resubscribe(Function _callback, int index) {
    _listeners[index] = _callback;
    _callback(_value);
  }

  _cancel(int _index) {
    _listeners[_index] = null;
  }

  void notify(dynamic data) {
    _value = data;
    _listeners.forEach((Function _callback) {
      if (_callback != null) {
        _callback(data);
      }
    });
  }
}

/// Demo
void main() {
  var notifier = BehaviourNotifier();

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

  listner_1.resubscribe();
}
