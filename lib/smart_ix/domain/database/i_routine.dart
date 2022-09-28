import 'package:smart_ix/smart_ix/domain/database/routine.dart';

///  Routine interface, to structure the routine database repository.
///  the abstract methods are implemented in the routine repository.
abstract class IRoutine {
  Stream<List<SmartRoutines>> getAllRoutine();
  Future<void> createRoutine(SmartRoutines routine, String id);

  Future<void> deleteRoutine(String id);
}
