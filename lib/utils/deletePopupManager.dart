class DeletePopupManager {
  static final DeletePopupManager _instance = DeletePopupManager._internal();

  // Factory constructor for returning the singleton instance
  factory DeletePopupManager() => _instance;

  // Private constructor for internal instantiation
  DeletePopupManager._internal();

  // Callback for triggering state changes
  Function(bool)? _onLoadingChanged;

  // Method to set the callback
  void setOnLoadingChanged(Function(bool)? callback) {
    _onLoadingChanged = callback;
  }

  // Static method to start the loader
  static void playLoader() {
    if (_instance._onLoadingChanged != null) {
      _instance._onLoadingChanged!(true);
    }
  }

  // Static method to stop the loader
  static void stopLoader() {
    if (_instance._onLoadingChanged != null) {
      _instance._onLoadingChanged!(false);
    }
  }
}