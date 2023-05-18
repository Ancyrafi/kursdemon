import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kursdemo/model/model.dart';

final userID = FirebaseAuth.instance.currentUser?.uid;

class FirebaseDataSource {
  Future<void> createLesson(
      {required String lessonTitle,
      required String sublessonTitle,
      required String videoLink}) async {
    DocumentReference lessonColection = await FirebaseFirestore.instance
        .collection('lesson')
        .add({'lessonTitle': lessonTitle});
    await lessonColection
        .collection('section')
        .add({'sublessonTitle': sublessonTitle, 'videoLink': videoLink});
  }

  Future<String> creaLesson({required String lessonTitle}) async {
    DocumentReference lessonReference = await FirebaseFirestore.instance
        .collection('lesson')
        .add({'lessonTitle': lessonTitle});

    return lessonReference.id;
  }

  Future<void> createSection(
      {required String sublessonTitle,
      required String videoLink,
      required String lessonId}) async {
    // używamy identyfikatora lekcji zamiast tytułu
    await FirebaseFirestore.instance
        .collection('lesson')
        .doc(lessonId)
        .collection('section')
        .add({'sublessonTitle': sublessonTitle, 'videoLink': videoLink});
  }

  // Stream<List<Lesson>> getLesson() {
  //   return FirebaseFirestore.instance
  //       .collectionGroup('lesson')
  //       .snapshots()
  //       .map((querySnapshot) {
  //     return querySnapshot.docs.map((doc) {
  //       return Lesson(
  //         title: doc['lessonTitle'],
  //         lessonID: doc.id,
  //       );
  //     }).toList();
  //   });
  // }

  Stream<List<Lesson>> getLesson() {
    return FirebaseFirestore.instance
        .collection('lesson')
        .snapshots()
        .asyncMap((querySnapshot) async {
      return await Future.wait(querySnapshot.docs.map((doc) async {
        List<Section> sections = await getSection(lessonID: doc.id).first;
        return Lesson(
          title: doc['lessonTitle'],
          lessonID: doc.id,
          sections: sections,
        );
      }).toList());
    });
  }

//   Stream<List<Section>> getSection({required String lessonID,}) {
//     return FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userID)
//         .collection('lesson')
//         .doc(lessonID)
//         .collection('section')
//         .snapshots()
//         .map((querySnapshot) {
//       return querySnapshot.docs.map((doc) {
//         return Section(
//             title: doc['sublessonTitle'],
//             link: doc['videoLink'],
//             sectionID: doc.id);
//       }).toList();
//     });
//   }
// }
  Stream<List<Section>> getSection({required String lessonID}) {
    return FirebaseFirestore.instance
        .collection('lesson')
        .doc(lessonID)
        .collection('section')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Section(
            title: doc['sublessonTitle'],
            link: doc['videoLink'],
            sectionID: doc.id);
      }).toList();
    });
  }
}
