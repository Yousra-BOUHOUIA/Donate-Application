import 'package:bloc/bloc.dart';

class FooterCubit extends Cubit<int> {
  FooterCubit() : super(0); 

  void changeTab(int index) => emit(index);
}