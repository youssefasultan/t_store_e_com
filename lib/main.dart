import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store_e_com/app.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // widget binding
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  //init local storage
  await GetStorage.init();
  // await native splash
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  // init firebase & auth repo
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthRepo()));
  runApp(const App());
}
