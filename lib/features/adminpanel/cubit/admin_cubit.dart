import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this._repository)
      : super(
          AdminState(
            save: false,
            errormsg: '',
          ),
        );
  final Repository _repository;
  Future<void> createLesson(
      {required String lessonTitle,
      required String sublessonTitle,
      required String videoLink}) async {
    try {
      await _repository.createLesson(
          lessonTitle: lessonTitle,
          sublessonTitle: sublessonTitle,
          videoLink: videoLink);
      emit(
        AdminState(save: true, errormsg: ''),
      );
    } catch (error) {
      emit(AdminState(save: false, errormsg: error.toString()));
    }
  }
}
