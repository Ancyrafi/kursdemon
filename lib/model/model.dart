class Lesson {
  Lesson({
    required this.title,
    required this.lessonID,
    required this.sections,
  });
  final String title;
  final String lessonID;
  final List<Section> sections;
}

class Section {
  Section({
    required this.title,
    required this.link,
    required this.sectionID,
  });
  final String title;
  final String link;
  final String sectionID;
}

class UserList {
  UserList(
      {required this.name,
      required this.surname,
      required this.email,
      required this.pass,
      required this.documentID,
      required this.userID});
  final String name;
  final String surname;
  final String email;
  final String pass;
  final String userID;
  final String documentID;
}

class SocialMedia {
  SocialMedia(
      {required this.showYouTube,
      required this.showFacebook,
      required this.showInstagram,
      required this.showTwitter,
      required this.socialID,
      required this.facebookLink,
      required this.instagramLink,
      required this.twitterLink,
      required this.youtubeLink,
      required this.createSocial});
  final bool showYouTube;
  final bool showFacebook;
  final bool showInstagram;
  final bool showTwitter;
  final String socialID;
  final String youtubeLink;
  final String twitterLink;
  final String instagramLink;
  final String facebookLink;
  final bool createSocial;
}

class Blog {
  Blog({required this.title, required this.blogText, required this.blogID});
  final String title;
  final String blogText;
  final String blogID;
}
