import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCampaignCubit extends Cubit<CreateCampaignState> {
  CreateCampaignCubit() : super(CreateCampaignInitial());

  String? _selectedType;
  String? _dueDate;
  String? _title;
  String? _location;
  String? _resources;
  String? _description;

  String? get selectedType => _selectedType;
  String? get dueDate => _dueDate;
  String? get title => _title;
  String? get location => _location;
  String? get resources => _resources;
  String? get description => _description;

  void setSelectedType(String? type) {
    _selectedType = type;
    emit(CreateCampaignTypeSelected(type));
  }

  void setDueDate(String? date) {
    _dueDate = date;
    emit(CreateCampaignDueDateSet(date));
  }

  void setTitle(String? title) {
    _title = title;
    emit(CreateCampaignTitleSet(title));
  }

  void setLocation(String? location) {
    _location = location;
    emit(CreateCampaignLocationSet(location));
  }

  void setResources(String? resources) {
    _resources = resources;
    emit(CreateCampaignResourcesSet(resources));
  }

  void setDescription(String? description) {
    _description = description;
    emit(CreateCampaignDescriptionSet(description));
  }

  void resetForm() {
    _selectedType = null;
    _dueDate = null;
    _title = null;
    _location = null;
    _resources = null;
    _description = null;
    emit(CreateCampaignInitial());
  }
}

// Define states
abstract class CreateCampaignState {}

class CreateCampaignInitial extends CreateCampaignState {}

class CreateCampaignTypeSelected extends CreateCampaignState {
  final String? type;
  CreateCampaignTypeSelected(this.type);
}

class CreateCampaignDueDateSet extends CreateCampaignState {
  final String? dueDate;
  CreateCampaignDueDateSet(this.dueDate);
}

class CreateCampaignTitleSet extends CreateCampaignState {
  final String? title;
  CreateCampaignTitleSet(this.title);
}

class CreateCampaignLocationSet extends CreateCampaignState {
  final String? location;
  CreateCampaignLocationSet(this.location);
}

class CreateCampaignResourcesSet extends CreateCampaignState {
  final String? resources;
  CreateCampaignResourcesSet(this.resources);
}

class CreateCampaignDescriptionSet extends CreateCampaignState {
  final String? description;
  CreateCampaignDescriptionSet(this.description);
}
