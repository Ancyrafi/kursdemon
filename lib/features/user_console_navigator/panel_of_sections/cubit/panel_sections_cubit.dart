import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

part 'panel_sections_state.dart';

class PanelSectionsCubit extends Cubit<PanelSectionsState> {
  PanelSectionsCubit(this._repository)
      : super(PanelSectionsState(delete: false));
  final Repository _repository;
  Future<void> deleteSections(
      {required String sectionID, required String lessonID}) async {
    await _repository.deleteSection(lessonID: lessonID, sectionID: sectionID);
    emit(PanelSectionsState(delete: true));
  }
}
