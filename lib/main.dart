import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_ix/smart_ix/infrastructure/authentication/firebase_auth.dart';
import 'package:smart_ix/smart_ix/infrastructure/smart_device/routine.dart';
import 'package:smart_ix/smart_ix/infrastructure/weather/weather.dart';

import 'smart_ix/presentation/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  final routineRepository = RoutineRepository();
  final metaAPiClient = MetaAPiClient();

  await authenticationRepository.user.first;
  runApp(App(
    authenticationRepository: authenticationRepository,
    metaAPiClient: metaAPiClient,
    routineRepository: routineRepository,
  ));
}
