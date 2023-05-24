import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

part 'panel_social_state.dart';

class PanelSocialCubit extends Cubit<PanelSocialState> {
  PanelSocialCubit(this._repository) : super(PanelSocialState());
  final Repository _repository;
  Future<void> addinstance(
      {required bool showYouTube,
      required bool showFacebook,
      required bool showInstagram,
      required bool showTwitter,
      required String youtubeLink,
      required String twitterLink,
      required String instagramLink,
      required String facebookLink}) async {
    await _repository.socialmedia(
        showYouTube: showYouTube,
        showFacebook: showFacebook,
        showInstagram: showInstagram,
        showTwitter: showTwitter,
        youtubeLink: youtubeLink,
        twitterLink: twitterLink,
        instagramLink: instagramLink,
        facebookLink: facebookLink);
  }
}
