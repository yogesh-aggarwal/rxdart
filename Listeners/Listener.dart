class Listener {
  int index_;
  Function canceler_;
  Function callback_;
  Function subscribe_;

  Listener(
      {this.index_, this.canceler_, this.subscribe_, this.callback_});

  canceler() {
    canceler_(index_);
  }

  resubscribe() {
    this.subscribe_(callback_, index_);
  }
}