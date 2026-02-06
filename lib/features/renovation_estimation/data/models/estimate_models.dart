// 1. The smallest unit: The individual work item
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class EstimateItem {
  String id;
  String code; // e.g., "C-AC-001"
  String description;
  String unit; // e.g., "AC"
  double amount;
  double unitaryPrice;
  String note;
  String Fprize;
  bool discount = false;
  bool isCME = false;
  RxBool isEditingNote = false.obs;


  EstimateItem({
    required this.id,
    required this.code,
    required this.description,
    this.unit = 'AC',
    this.amount = 1.0,
    this.unitaryPrice = 0.0,
    this.note = '',
    this.discount = false,
    this.isCME = false,
    required this.Fprize,
  });

  // Getter for auto-calculation
  double get totalCost => amount * unitaryPrice;

  // Easy serialization for Firebase later
  // Map<String, dynamic> toMap() { /* ... */ }
  // factory EstimateItem.fromMap(Map<String, dynamic> map) { /* ... */ }
}

// 2. The Group: e.g., "Construction site preparation"
class EstimateGroup {
  String id;
  String title;
  List<EstimateItem> items;

  EstimateGroup({required this.id, required this.title, required this.items});

  double get groupTotal => items.fold(0, (sum, item) => sum + item.totalCost);
}

// 3. The Section: e.g., "Internal work" or "Design"
class EstimateSection {
  String id;
  String title;
  String Fprize; // e.g., "F1", "F3"
  List<EstimateGroup> groups;

  EstimateSection({
    required this.id,
    required this.title,
    this.Fprize = 'F1',
    required this.groups
  });

  double get sectionTotal => groups.fold(0, (sum, group) => sum + group.groupTotal);
}