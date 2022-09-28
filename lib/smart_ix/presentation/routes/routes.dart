import 'package:flutter/material.dart';

import 'package:smart_ix/smart_ix/application/authentication/auth_bloc/app_bloc.dart';

import 'package:smart_ix/smart_ix/presentation/view/authentication/sign_up/view.dart';
import 'package:smart_ix/smart_ix/presentation/view/home/home.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AppStatus.authenticated:
      return [CentralWidget.page()];

    case AppStatus.unauthenticated:
      return [SignupPage.page()];
  }
}
