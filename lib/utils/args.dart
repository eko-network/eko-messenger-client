class Args {
  static Args? _instance;
  final List<String> arguments;
  Args._internal(this.arguments);

  static void init(List<String> args) {
    if (_instance != null) {
      throw StateError('Args is already initialized');
    }
    _instance = Args._internal(args);
  }

  static Args get instance {
    if (_instance == null) {
      throw StateError(
        'Args must be initialized before use. Call Args.init() first.',
      );
    }
    return _instance!;
  }
}
