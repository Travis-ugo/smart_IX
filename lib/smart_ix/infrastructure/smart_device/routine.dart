import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ix/smart_ix/domain/database/i_routine.dart';
import 'package:smart_ix/smart_ix/domain/database/routine.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// https://firebase.google.com/docs/firestore/quickstart
/// Firestore is a flexible, scalable NoSQL cloud database to store and sync data
class RoutineRepository implements IRoutine {
  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  RoutineRepository({
    FirebaseFirestore? firebaseFirestore,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  /// createRoutine function creates a new user collection if it does'nt
  /// already exists on the cloud store, with can be retrieved.

  @override
  Future<void> createRoutine(SmartRoutines smartRoutine, String id) {
    return _firebaseFirestore
        .collection('smart_Ix_users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('routines')
        .doc(id)
        .set((smartRoutine.smartRoutineToJson(smartRoutine)));
  }

  /// deleteRoutine function deletes existing routine from the cloud store,
  /// using the userId, and the routine id to remove specific routines from
  /// the database.

  @override
  Future<void> deleteRoutine(String id) {
    return _firebaseFirestore
        .collection('smart_Ix_users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('routines')
        .doc(id)
        .delete();
  }

  /// getAllRoutines is a stream function with continually listens for new update on the
  /// database, if a new document has been created, updated or deleted from the data base.
  @override
  Stream<List<SmartRoutines>> getAllRoutine() {
    return _firebaseFirestore
        .collection('smart_Ix_users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('routines')
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => SmartRoutines.fromJson(doc),
            )
            .toList();
      },
    );
  }
}
