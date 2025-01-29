import 'dart:async';

class LoginCubit {
  
  bool _isPasswordObscured = true;
  final _rememberMeController = StreamController<bool>();
  final _obscurePasswordController = StreamController<bool>.broadcast();

  Sink<bool> get rememberMeSink => _rememberMeController.sink;
  Sink<bool> get obscurePasswordSink => _obscurePasswordController.sink;

  Stream<bool> get rememberMeStream => _rememberMeController.stream;
  Stream<bool> get obscurePasswordStream => _obscurePasswordController.stream;

  void dispose() {
    _rememberMeController.close();
    _obscurePasswordController.close();
  }

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured; 
    _obscurePasswordController.sink.add(_isPasswordObscured); 
  }
}
