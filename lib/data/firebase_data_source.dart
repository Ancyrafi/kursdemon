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
  }

  Stream<List<UserList>> getUser() {
    return FirebaseFirestore.instance
        .collectionGroup('users')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UserList(
            name: doc['username'],
            surname: doc['surname'],
            email: doc['email'],
            pass: doc['pass'],
            documentID: doc.id,
            userID: doc['userID']);
      }).toList();
    });
  }

  Future<void> deleteUser(
      {required String userID,
      required String documentID,
      required String email,
      required String pass}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.uid == userID) {
        await user.delete();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentID)
            .delete();
      }
    }
  }

  Future<void> socialMedia(
      {required bool showYouTube,
      required bool showFacebook,
      required bool showInstagram,
      required bool showTwitter,
      required String youtubeLink,
      required String twitterLink,
      required String instagramLink,
      required String facebookLink}) async {
    await FirebaseFirestore.instance.collection('socialmedia').add({
      'showYouTube': showYouTube,
      'showInstagram': showInstagram,
      'showFacebook': showFacebook,
      'showTwitter': showTwitter,
      'youtube': youtubeLink,
      'twitter': twitterLink,
      'facebook': facebookLink,
      'instagram': instagramLink
    });
  }

  Stream<List<SocialMedia>> getSocialMedia() {
    return FirebaseFirestore.instance
        .collection('socialmedia')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return SocialMedia(
            showYouTube: doc['showYouTube'],
            showFacebook: doc['showFacebook'],
            showInstagram: doc['showInstagram'],
            showTwitter: doc['showTwitter'],
            socialID: doc.id,
            youtubeLink: doc['youtube'],
            instagramLink: doc['instagram'],
            twitterLink: doc['twitter'],
            facebookLink: doc['facebook']);
      }).toList();
    });
  }
}
