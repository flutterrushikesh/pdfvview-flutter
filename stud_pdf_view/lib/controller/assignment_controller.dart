import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/assignment_model.dart';

class StudentAssignmentController extends GetxController {
  RxList<AssignmentModel> assignments = <AssignmentModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssignments();
  }

  void fetchAssignments() {
    FirebaseFirestore.instance
        .collection('assignments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          assignments.value = snapshot.docs
              .map((doc) => AssignmentModel.fromFirestore(doc.id, doc.data()))
              .toList();

          isLoading.value = false;
        });
  }
}
