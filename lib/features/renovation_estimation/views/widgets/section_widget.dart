import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renovation_estimation_impl/common_components/common_components.dart';
import 'package:renovation_estimation_impl/common_components/custom_drop_down_widget.dart';
import 'package:renovation_estimation_impl/constants.dart';

import '../../data/models/estimate_models.dart';
import 'group_header_widget.dart';
// Import your controller and models here

class SectionWidget extends StatelessWidget {
  final EstimateSection section;

  // We don't need GetView here, but we might need access to controller for specific updates
  const SectionWidget({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationlite,
      margin: EdgeInsets.fromLTRB(27, 14, 22, 0),

      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        initiallyExpanded: false,
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Custom Leading Arrows (Up/Down box)
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UpArrowWidget(),
            SizedBox(width: 4),
            DownArrowWidget(),

          ],
        ),
        title: Text(
          section.title, // "Internal Work"
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF489B79)),
        ),
        // The Right Side: Dropdown + Total Price
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Forza fascia",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 11,),
            CustomDropdown(height: 35,width: 112,value: "F1", items: ["F1","F2","F3"], onChanged: (val){
            }),
            SizedBox(width: 225),
            // Dynamic Total for the Section
            Text(
              "${section.sectionTotal.toStringAsFixed(0)}€",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Icon(Icons.keyboard_arrow_down), // Expansion arrow
          ],
        ),
        children: section.groups.map((group) {
          return GroupHeaderWidget(group: group, sectionId: section.id);
        }).toList(),

      ),
    );
  }
}