import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering/models/quiz.dart';
import 'package:software_engineering/models/result.dart';
import 'package:software_engineering/models/user.dart';

const String USERS_COLLECTION_REF = "users";
const String RESULT_COLLECTION_REF = "result";
const String QUIZ_COLLECTION_REF = "quiz";

FirebaseAuth firebaseAuth = FirebaseAuth.instance;


class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _usersRef;
  late final CollectionReference _resultRef;
  late final CollectionReference _quizRef;

  String currentUserUID = FirebaseAuth.instance.currentUser?.uid ?? '';

  FirestoreService() {
    databaseService();
    // if (firebaseAuth.currentUser != null) {}
  }

  databaseService() {
    _usersRef = _firestore.collection(USERS_COLLECTION_REF).withConverter<Users>(
      fromFirestore: (snapshots, _) => Users.fromJson(snapshots.data()!),
      toFirestore: (users, _) => users.toJson()
    );

    _resultRef = _firestore.collection(RESULT_COLLECTION_REF).withConverter<Result>(
      fromFirestore: (snapshot, _) => Result.fromJson(snapshot.data()!),
      toFirestore: (result, _) => result.toJson()
    );

    _quizRef = _firestore.collection(QUIZ_COLLECTION_REF).withConverter<Quiz>(
        fromFirestore: (snapshot, _) => Quiz.fromJson(snapshot.data()!),
        toFirestore: (quiz, _) => quiz.toJson()
    );
  }

  Stream<QuerySnapshot> getUsers() {
    return _usersRef.snapshots();
  }

  Stream<QuerySnapshot> getQuiz() {
    return _quizRef.snapshots();
  }

  Stream<QuerySnapshot> getCurrentUserResult() {
    return _resultRef.where('token', isEqualTo: currentUserUID).snapshots();
  }

  Stream<QuerySnapshot> getCurrentUserQuiz() {
    return _quizRef.where('token', isEqualTo: currentUserUID).snapshots();
  }

  Stream<QuerySnapshot> getCurrentUser() {
    return _usersRef.where('token', isEqualTo: currentUserUID).snapshots();
  }
  
  Stream<QuerySnapshot> getTargetQuizResult(String quizId) {
    return _resultRef.where('quizId', isEqualTo: quizId).snapshots();
  }

  Stream<QuerySnapshot> getTargetQuiz(String token) {
    return _quizRef.where(FieldPath.documentId, isEqualTo: token).snapshots();
  }

  Future<void> addUsers(Users users) async {
    await _usersRef.add(users);
  }

  void addResult(Result result) async {
    await _resultRef.add(result);
  }

  void addQuiz(Quiz quiz) async {
    await _quizRef.add(quiz);
  }

}