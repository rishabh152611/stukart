// app_state.dart
class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() => _instance;

  AppState._internal();

  final List<Map<String, String>> wishlist = [];
  final List<Map<String, String>> cart = [];
}
