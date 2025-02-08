import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddDonationCubit extends Cubit<AddDonationState> {
  

  AddDonationCubit() : super(AddDonationInitial());

  XFile? _selectedImage;
  String? _selectedColor;
  String? _selectedCondition;

  XFile? get selectedImage => _selectedImage;
  String? get selectedColor => _selectedColor;
  String? get selectedCondition => _selectedCondition;


  void setSelectedColor(String? color) {
    _selectedColor = color;
    emit(AddDonationColorSelected(color)); // Emit a new state
  }

  void setSelectedCondition(String? condition) {
    _selectedCondition = condition;
    emit(AddDonationConditionSelected(condition)); // Emit a new state
  }

  void resetForm() {
    _selectedImage = null;
    _selectedColor = null;
    _selectedCondition = null;
    emit(AddDonationInitial()); // Emit the initial state
  }
}

// Define the states
abstract class AddDonationState {}

class AddDonationInitial extends AddDonationState {}

class AddDonationImagePicked extends AddDonationState {
  final XFile image;

  AddDonationImagePicked(this.image);
}

class AddDonationColorSelected extends AddDonationState {
  final String? color;

  AddDonationColorSelected(this.color);
}

class AddDonationConditionSelected extends AddDonationState {
  final String? condition;

  AddDonationConditionSelected(this.condition);
}