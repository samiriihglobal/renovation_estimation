import 'package:get/get.dart';

// Import your Controller and Repository
import '../data/repository/estimation_repository_local.dart';
import '../logic/estimation_controller.dart';
// import '../data/repository/local_estimation_repository.dart'; // Implementation

class EstimationBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Inject the Repository first (Data Layer)
    // We bind the Interface (EstimationRepository) to the Implementation (LocalEstimationRepository)
    // This makes swapping to Firestore later extremely easy (just change this one line).
    Get.lazyPut<EstimationRepository>(() => LocalEstimationRepository());

    // 2. Inject the Controller (Logic Layer)
    // Get.find() automatically grabs the Repository we just injected above.
    Get.lazyPut<EstimationController>(() => EstimationController(Get.find()));
  }
}