import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renovation_estimation_impl/common_components/common_components.dart'; // For UpArrowWidget etc.
import 'package:renovation_estimation_impl/common_components/custom_drop_down_widget.dart';
import 'package:renovation_estimation_impl/features/renovation_estimation/views/widgets/reactive_numeric_input_widget.dart';

import '../../data/models/estimate_models.dart';
import '../../logic/estimation_controller.dart';

class ItemRowWidget extends GetView<EstimationController> {
  final EstimateItem item;
  final String sectionId;
  final String groupId;

  ItemRowWidget({
    super.key,
    required this.item,
    required this.sectionId,
    required this.groupId,
  });

  Rx<double> _noteFieldHeight = 60.0.obs; // Default height

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 1. ADD THIS LINE: This "registers" the Obx to listen to the controller's state.
      // Assuming your list in the controller is named 'sections'
      final _ = controller.sections.length;

      return Container(
        margin: const EdgeInsets.fromLTRB(27, 8, 22, 0),
        padding: const EdgeInsets.fromLTRB(16, 12, 9, 12),
        decoration: BoxDecoration(
          color: item.discount ? Color(0xFFEDF5F2) : Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- LEFT SIDE ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.code,
                      style: const TextStyle(
                        color: Color(0xFF717171),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      item.description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // inside your Column children
                    item.isEditingNote.value
                        ? _buildNoteInputField(item) // The new field
                        : GestureDetector(
                            onTap: () {
                              // setState((){});
                              item.isEditingNote.value = true;
                              // controller.sections.refresh();
                            },
                            child: Text(
                              item.note.isEmpty ? "Aggiungi nota" : item.note,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        UpArrowWidget(),
                        SizedBox(width: 4),
                        DownArrowWidget(),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              /// --- RIGHT SIDE ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 356,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInputLabelColumn(
                          "Unità",
                          CustomDropdown<String>(
                            height: 30,
                            width: 54,
                            value: item.unit,
                            items: const ["AC", "KG", "M", "PZ"],
                            onChanged: (val) => controller.updateItemUnit(
                              sectionId,
                              groupId,
                              item.id,
                              val!,
                            ),
                          ),
                        ),
                        _buildInputLabelColumn(
                          "Quantità",
                          _buildQuantityField(),
                        ),
                        _buildInputLabelColumn(
                          "F. prezzo",
                          CustomDropdown<String>(
                            height: 30,
                            width: 50,
                            value: item.Fprize,
                            items: const ["F1", "F2"],
                            onChanged: (val) => controller.updateItemFprize(
                              sectionId,
                              groupId,
                              item.id,
                              val!,
                            ),
                          ),
                        ),
                        _buildInputLabelColumn(
                          "Unitario",
                          _buildNumberField(
                            width: 86,
                            value: item.unitaryPrice,
                            onChanged: (val) => controller.updateItemPrice(
                              sectionId,
                              groupId,
                              item.id,
                              val,
                            ),
                            fieldType: "unitary",
                          ),
                        ),
                        _buildInputLabelColumn(
                          "Costo",
                          Container(
                            height: 30,
                            width: 86,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: const Color(0xFFD7D7D7),
                              ),
                            ),
                            child: Text(
                              "${item.totalCost.toStringAsFixed(0)} €",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 22,
                    child: Row(
                      children: [
                        //todo:fixme
                        CustomDropdown(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                          height: 22,
                          width: 81,
                          value: "Froza AC",
                          items: const ["Preventivo", "Froza AC", "CME"],
                          onChanged: (value) {
                            // controller.updateItemPriceType(sectionId, groupId, item.id, value);
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildActionBtn("Sconta", "assets/img.png", width: 75),
                        const SizedBox(width: 11),
                        InkWell(
                          onTap: () {
                            item.isCME = !item.isCME;
                            controller.sections.refresh();
                          },
                          child: Image.asset(
                            item.isCME
                                ? "assets/cme_btn_red_active.png"
                                : "assets/cme_btn_inactive.png",
                            height: 22,
                            width: 60,
                          ),
                        ),
                        const SizedBox(width: 11),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/delete_btn.png",
                            height: 22,
                            width: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  // Helper for numeric fields (used for Price and Quantity)
  // Inside ItemRowWidget...

  Widget _buildNumberField({
    required double width,
    required double value,
    required Function(double) onChanged,
    required String fieldType,
  }) {
    return ReactiveNumericInput(
      fieldKey: "${item.id}_$fieldType", // Stable key
      width: width,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildNoteInputField(EstimateItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Obx(
              () {
                    print(item.isEditingNote);
                    print(item.code);
                    return Container(
                      height: _noteFieldHeight.value,
                      // Apply the dynamic height
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFD7D7D7)),
                      ),
                      child: TextFormField(
                        initialValue: item.note,
                        maxLines: null,
                        // Allows infinite lines as height increases
                        expands: true,
                        // Important: makes field fill the Container height
                        textAlignVertical: TextAlignVertical.top,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          border: InputBorder.none,
                          hintText: "Scrivi una nota...",
                        ),
                        onChanged: (val) => item.note = val,
                      ),
                    );
              },
            ),
            // --- THE DRAGGABLE HANDLE ---
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                // cursor: SystemMouseCursors.resizeUpDown,
                onPanUpdate: (details) {

                    _noteFieldHeight += details.delta.dy;

                    // Set constraints so it doesn't disappear or get too huge
                    if (_noteFieldHeight < 40) _noteFieldHeight.value = 40;
                    if (_noteFieldHeight > 300) _noteFieldHeight.value = 300;
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Transform.rotate(
                    angle: 0.785,
                    // Rotates the handle to look like the image (45 degrees)
                    child: Icon(
                      CupertinoIcons.resize_v ,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityField() {
    return _buildNumberField(
      fieldType: "qty",
      width: 54,
      value: item.amount,
      onChanged: (val) =>
          controller.updateItemAmount(sectionId, groupId, item.id, val),
    );
  }

  Widget _buildInputLabelColumn(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF717171),
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        child,
      ],
    );
  }

  Widget _buildActionBtn(
    String label,
    String assetPath, {
    required double width,
  }) {
    return InkWell(
      onTap: () {
        // add discound
        controller.updateItemDiscount(item);
      },
      child: Container(
        height: 22,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFD7D7D7)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // Use a placeholder if asset is missing to prevent crash
            const Icon(Icons.percent, size: 10, color: Colors.orange),
            const SizedBox(width: 7),
          ],
        ),
      ),
    );
  }

  // Note: Ensure your controller has updateItemUnit, updateItemAmount, and updateItemPrice
}
