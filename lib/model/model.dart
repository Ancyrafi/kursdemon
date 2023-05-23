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
      required this.userID});
  final String name;
  final String surname;
  final String email;
  final String pass;
  final String userID;
}
