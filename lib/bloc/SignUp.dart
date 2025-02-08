import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<Map<String, dynamic>> {
  SignupCubit() : super({
    "isUser": true,
    "isPasswordVisible": false, 
    "isConfirmPasswordVisible": false ,  
    "uploadedFilePath": null,
  });

  void togglePasswordVisibility() {
    emit({...state, "isPasswordVisible": !state["isPasswordVisible"]});
  }
  void toggleConfirmPasswordVisibility() {
    emit({...state, "isConfirmPasswordVisible": !state["isConfirmPasswordVisible"]});
  }

 void switchUserType(bool isUser) {
  
  emit({...state, "isUser": isUser});
 
}

  void uploadFile(String filePath) {
  print('Uploading file: $filePath');  // Debugging line
  emit({...state, "uploadedFilePath": filePath});
}

}
