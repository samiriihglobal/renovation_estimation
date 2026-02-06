import 'package:get/get.dart';

import '../data/providers/activities_for_estimate_provider.dart';

class AddSectionController extends GetxController {
  // Observables for the popup state only
  var selectedCategory = "".obs;
  var selectedSubCategory = "".obs;
  var selectedActivity = Rxn<Map>();

  var categories = <String>[].obs;
  var subCategories = <String>[].obs;
  var activities = <Map>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize first category
    categories.value = activitiesForEstimate.keys.toList();
    // if (categories.isNotEmpty) {
    //   updateCategory(categories.first);
    // }
  }

  void updateCategory(String category) {
    selectedSubCategory.value = "";
    selectedCategory.value = category;
    var subMap = activitiesForEstimate[category] ?? {};
    subCategories.value = subMap.keys.toList();

    // if (subCategories.isNotEmpty) {
    //   updateSubCategory(subCategories.first);
    // }
  }

  void updateSubCategory(String sub) {
    selectedActivity.value = null;
    selectedSubCategory.value = sub;
    var list = activitiesForEstimate[selectedCategory.value]?[sub] ?? [];
    activities.value = List<Map>.from(list);

    // if (activities.isNotEmpty) {
    //   selectedActivity.value = activities.first;
    // }
  }
}