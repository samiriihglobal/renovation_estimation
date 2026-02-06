import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:renovation_estimation_impl/common_components/custom_button.dart';
import 'package:renovation_estimation_impl/common_components/custom_drop_down_widget.dart';

import '../data/models/estimate_models.dart';
import '../data/repository/estimation_repository_local.dart';
import 'add_section_controller.dart';

class EstimationController extends GetxController {

  final EstimationRepository repository;

  EstimationController(this.repository);

  // The main state: A list of sections
  var sections = <EstimateSection>[].obs;

  // Footer state
  var discountPercent = 5.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    var data = await repository.getEstimationData();
    sections.assignAll(data);
  }

  // --- Actions ---
  void showaddSection() {
    final addController = Get.put(AddSectionController());

    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: 325,
            width: 650,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(
                  () => Column(
                children: [
                  // Title
                  const Text(
                    "Aggiungi Voce",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Category + Subcategory
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Seleziona categoria"),
                            const SizedBox(height: 6),
                            CustomDropdown<String>(
                              height: 45,
                              width: double.infinity,
                              value: addController.selectedCategory.value,
                              items: addController.categories,
                              onChanged: (val) {
                                addController.selectedSubCategory.value = "";
                                addController.selectedActivity.value = null;
                                addController.updateCategory(val!);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Seleziona sottocategoria"),
                            const SizedBox(height: 6),
                            CustomDropdown<String>(
                              height: 45,
                              width: double.infinity,
                              value: addController.selectedSubCategory.value,
                              items: addController.subCategories,
                              onChanged: (val) =>
                                  addController.updateSubCategory(val!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Activity
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Seleziona attività"),
                  ),
                  const SizedBox(height: 6),
                  CustomDropdown<String>(
                    height: 45,
                    width: double.infinity,
                    value:
                    addController.selectedActivity.value?['activity'] ?? "",
                    items: addController.activities
                        .map((e) => e['activity'] as String)
                        .toList(),
                    onChanged: (val) {
                      final match = addController.activities.firstWhere(
                            (a) => a['activity'] == val,
                      );
                      addController.selectedActivity.value = match;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Manual entry row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("oppure"),
                      const SizedBox(width: 10),
                      CustomButton(
                        height: 30,
                        width: 150,
                        text: "Aggiungi manuale",
                        backgroundColor: Colors.grey.shade300,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        onTap: () {
                          Get.snackbar(
                            "Manual Entry",
                            "todo manual entry",
                          );
                        },
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Submit
                  CustomButton(
                    height: 35,
                    width: 130,
                    text: "Inserisci voce",
                    onTap: () {
                      final selectedData =
                          addController.selectedCategory.value;

                      if (selectedData != null) {
                        addNewItemFromMap(selectedData);
                      }

                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).then((_) => Get.delete<AddSectionController>());
  }


  void addNewItemFromMap(selectedData){

    AddSectionController addController = Get.find();
    print(addController.selectedCategory.value);
    print(addController.selectedSubCategory.value);
    print(addController.selectedActivity.value);

    EstimateSection newSection = EstimateSection(
      title: addController.selectedCategory.value,
      id: "newId",
      groups:<EstimateGroup>[
        EstimateGroup(id: "newId", title: addController.selectedSubCategory.value, items: <EstimateItem>[
          EstimateItem(
            id: "newId",
            description: addController.selectedActivity.value?['activity'], code: addController.selectedActivity.value?['code'],
            unit: addController.selectedActivity.value?['um'],
            amount: 1,unitaryPrice:  addController.selectedActivity.value?['f1'], Fprize: 'F1',
          ),
        ]),
      ],
      Fprize: "F1"
    );

    sections.add(newSection);
  }

  // Update an item's value (e.g., user types in "Amount" textfield)
  void updateItemAmount(
    String sectionId,
    String groupId,
    String itemId,
    double newAmount,
  ) {
    // Find the item
    var section = sections.firstWhere((s) => s.id == sectionId);
    var group = section.groups.firstWhere((g) => g.id == groupId);
    var item = group.items.firstWhere((i) => i.id == itemId);

    // Update value
    item.amount = newAmount;

    // Trigger UI refresh
    sections.refresh();
  }

  // --- Calculations ---

  double get grandTotalRaw {
    return sections.fold(0.0, (sum, section) => sum + section.sectionTotal);
  }

  double get discountAmount => grandTotalRaw * (discountPercent.value / 100);

  double get grandTotalFinal => grandTotalRaw - discountAmount;

  void updateItemPrice(
    String sectionId,
    String groupId,
    String itemId,
    double newPrice,
  ) {
    // Find the item
    final section = sections.firstWhere((s) => s.id == sectionId);
    final group = section.groups.firstWhere((g) => g.id == groupId);
    final item = group.items.firstWhere((i) => i.id == itemId);

    // Update value
    item.unitaryPrice = newPrice;

    // Force GetX to update the UI
    sections.refresh();
  }

  void updateItemUnit(
    String sectionId,
    String groupId,
    String itemId,
    String newUnit,
  ) {
    final section = sections.firstWhere((s) => s.id == sectionId);
    final group = section.groups.firstWhere((g) => g.id == groupId);
    final item = group.items.firstWhere((i) => i.id == itemId);

    item.unit = newUnit;
    sections.refresh();
  }

  void updateItemFprize(
    String sectionId,
    String groupId,
    String itemId,
    String newFprize,
  ) {
    final section = sections.firstWhere((s) => s.id == sectionId);
    final group = section.groups.firstWhere((g) => g.id == groupId);
    final item = group.items.firstWhere((i) => i.id == itemId);

    item.Fprize = newFprize;
    sections.refresh();
  }

  void updateDiscountPercent(double newPercent) {
    discountPercent.value = newPercent;
  }

  void updateItemDiscount(EstimateItem item){
    print(item.discount);
    item.discount = !item.discount;
    sections.refresh();
  }
}
