import 'package:get/get.dart';
import '../controller/assignment_controller.dart';

class StudentAssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentAssignmentController>(
      () => StudentAssignmentController(),
    );
  }
}
