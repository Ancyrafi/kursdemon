import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kursdemo/model/model.dart';

final userID = FirebaseAuth.instance.currentUser?.uid;

class FirebaseDataSource {
  // tworzenie lekcji
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

  // pobranie lekcji
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

// KONIEC POBIERANIA I TWORZENIA SEKCJI I LEKCJI
// POBIERANIE UZYTKOWNIKA < DODAWANIE I USUWANIE
  final String admin = 'siudy@dev.pl';
  final String adminpass = '123456';
// adminstracja kodu,
// musisz podać administracje kodu
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
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: admin, password: adminpass);
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
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: admin, password: adminpass);
      }
    }
  }

// ZACZYANMY SOCIAL MEDIA USTAWIEIA I LINKI
  Future<void> socialMedia(
      {required bool showYouTube,
      required bool showFacebook,
      required bool showInstagram,
      required bool showTwitter,
      required String youtubeLink,
      required String twitterLink,
      required String instagramLink,
      required String facebookLink,
      required bool createSocial}) async {
    await FirebaseFirestore.instance.collection('socialmedia').add({
      'showYouTube': showYouTube,
      'showInstagram': showInstagram,
      'showFacebook': showFacebook,
      'showTwitter': showTwitter,
      'youtube': youtubeLink,
      'twitter': twitterLink,
      'facebook': facebookLink,
      'instagram': instagramLink,
      'createSocial': createSocial
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
            facebookLink: doc['facebook'],
            createSocial: doc['createSocial']);
      }).toList();
    });
  }

  Future<void> showYT({required bool showYT, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'showYouTube': showYT});
  }

  Future<void> showFB({required bool showfB, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'showFacebook': showfB});
  }

  Future<void> showInsta(
      {required bool showInsta, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'showInstagram': showInsta});
  }

  Future<void> showTt({required bool showTt, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'showTwitter': showTt});
  }

  Future<void> linkYT(
      {required String linkYt, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'youtube': linkYt});
  }

  Future<void> linkInsta(
      {required String linkInsta, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'instagram': linkInsta});
  }

  Future<void> linkTwitter(
      {required String linkTwitter, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'twitter': linkTwitter});
  }

  Future<void> linkFB(
      {required String linkFB, required String socialID}) async {
    await FirebaseFirestore.instance
        .collection('socialmedia')
        .doc(socialID)
        .update({'facebook': linkFB});
  }

  // koniec ustawien social mediow
  // ustawienia bloga
  Future<void> addBlogSequence(
      {required String? addBlog, required String blogTitle}) async {
    await FirebaseFirestore.instance
        .collection('blog')
        .add({'blogSection': addBlog, 'title': blogTitle});
  }

  Future<void> deleteBlogSequence({required String blogID}) async {
    await FirebaseFirestore.instance.collection('blog').doc(blogID).delete();
  }

  Future<void> editBlogSequence(
      {required String? blogText, required String blogID}) async {
    await FirebaseFirestore.instance
        .collection('blog')
        .doc(blogID)
        .update({'blogSection': blogText});
  }

  Stream<List<Blog>> getBlogText() {
    return FirebaseFirestore.instance
        .collectionGroup('blog')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Blog(
            title: doc['title'], blogText: doc['blogSection'], blogID: doc.id);
      }).toList();
    });
  }

  Future<void> logIn({required String email, required String pass}) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
  }
}
