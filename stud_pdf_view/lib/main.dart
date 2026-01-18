import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/assignment_bindings.dart';
import 'view/assignment_list_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StudentAssignmentBinding(),
      home: const AssignmentListView(),
    );
  }
}
