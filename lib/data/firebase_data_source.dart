import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kursdemo/model/model.dart';

final userID = FirebaseAuth.instance.currentUser?.uid;

class FirebaseDataSource {
  Future<String> createLesson({required String lessonTitle}) async {
    DocumentReference lessonReference = await FirebaseFirestore.instance
        .collection('lesson')
        .add({'lessonTitle': lessonTitle});

    return lessonReference.id;
  }

  Future<void> deleteLesson({required String lessonId}) async {
    await FirebaseFirestore.instance
        .collection('lesson')
        .doc(lessonId)
        .delete();
  }

  Future<void> deletSection(
      {required String lessonid, required String sectionid}) async {
    await FirebaseFirestore.instance
        .collection('lesson')
        .doc(lessonid)
        .collection('section')
        .doc(sectionid)
        .delete();
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

  Future<void> addUser(
      {required String name,
      required String surname,
      required String email,
      required String pass}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      final User? user = userCredential.user;
      if (user != null) {
        final userName = '$name $surname';
        await user.updateDisplayName(userName);
        await user.reload();
        await FirebaseFirestore.instance.collection('users').add(
          {
            'username': name,
            'surname': surname,
            'email': email,
            'pass': pass,
            'userID': user.uid
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }
}
