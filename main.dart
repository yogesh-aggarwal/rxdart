class Listener {
  int index_;
  Function canceler_;
  
  Listener({this.index_, this.canceler_});
   
  canceler() {
    canceler_(index_);
  }

}

class Notifier {
  List<Function> _listeners = [];
  
  dynamic subscribe(Function _callback) {
    _listeners.add(_callback);
    return Listener(index_: _listeners.length - 1, canceler_: _cancel);
  }
  
  _cancel(int _index) {
    _listeners[_index] = null;
  }
  
  void notify(data) {
    _listeners.forEach((Function _callback) {
      if (_callback != null) {
        _callback(data);
      }
    });
  }
}

void main() {
  var notifier = Notifier();
  
  Listener listner_1 =  notifier.subscribe((data) {
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
