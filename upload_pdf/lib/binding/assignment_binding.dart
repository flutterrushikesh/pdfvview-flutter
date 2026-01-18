import 'package:get/get.dart';
import 'package:upload_pdf/controller/login_controller.dart';
import '../controller/assignment_controller.dart';

class AssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignmentController>(() => AssignmentController());
    Get.lazyPut(() => LoginController());
  }
}
