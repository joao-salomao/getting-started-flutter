import 'dart:async';

class SimpleBloc<T> {
  final StreamController _streamController = StreamController<T>();
  Stream<T> get stream => _streamController.stream;
  
  void add(T item) {
    _streamController.add(item);
  }

  void addError(Object error) {
    if (!_streamController.isClosed) {
      _streamController.addError(error);
    }
  }
  
  void closeStream() {
    _streamController.close();
  }
}