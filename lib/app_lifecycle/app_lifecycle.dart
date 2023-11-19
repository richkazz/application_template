import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  const AppLifecycleObserver({required this.child, super.key});

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with LoggerMixin<_AppLifecycleObserverState> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    // Pass all the callbacks for the transitions you want to listen to
    _listener = AppLifecycleListener(
      onDetach: _onDetach,
      onHide: _onHide,
      onInactive: _onInactive,
      onPause: _onPause,
      onRestart: _onRestart,
      onResume: _onResume,
      onShow: _onShow,
      onStateChange: _onStateChanged,
    );
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

  void _onDetach() => logInformation('onDetach');

  void _onHide() => logInformation('onHide');

  void _onInactive() => logInformation('onInactive');

  void _onPause() => logInformation('onPause');

  void _onRestart() => logInformation('onRestart');

  void _onResume() => logInformation('onResume');

  void _onShow() => logInformation('onShow');

  void _onStateChanged(AppLifecycleState state) {
    // Track state changes
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
