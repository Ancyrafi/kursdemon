import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

import '../../../../model/model.dart';

part 'panel_social_state.dart';

class PanelSocialCubit extends Cubit<PanelSocialState> {
  PanelSocialCubit(this._repository)
      : super(PanelSocialState(socialmedia: [], check: false));
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> addinstance(
      {required bool showYouTube,
      required bool showFacebook,
      required bool showInstagram,
      required bool showTwitter,
      required String youtubeLink,
      required String twitterLink,
      required String instagramLink,
      required bool createSocial,
      required String facebookLink}) async {
    await _repository.socialmedia(
        createSocial: createSocial,
        showYouTube: showYouTube,
        showFacebook: showFacebook,
        showInstagram: showInstagram,
        showTwitter: showTwitter,
        youtubeLink: youtubeLink,
        twitterLink: twitterLink,
        instagramLink: instagramLink,
        facebookLink: facebookLink);
  }

  Future<void> start() async {
    _streamSubscription = _repository.getSocialMedia().listen(
      (socialmedia) {
        if (socialmedia.isEmpty) {
          emit(PanelSocialState(
            check: true,
            socialmedia: [],
          ));
        } else {
          emit(PanelSocialState(socialmedia: socialmedia, check: false));
        }
      },
    )..onError((error) {
        emit(PanelSocialState(socialmedia: [], check: false));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
