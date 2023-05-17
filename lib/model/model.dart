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
