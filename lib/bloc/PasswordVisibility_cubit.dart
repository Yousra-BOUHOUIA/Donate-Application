import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true); 

  void togglePasswordVisibility() {
    emit(!state);
  }
}
