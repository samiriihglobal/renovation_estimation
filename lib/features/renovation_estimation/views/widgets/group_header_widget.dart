import 'package:flutter/material.dart';

import '../../data/models/estimate_models.dart';
import 'item_row_widget.dart';
// Import your ItemRowWidget and models

class GroupHeaderWidget extends StatelessWidget {
  final EstimateGroup group;
  final String sectionId;

  const GroupHeaderWidget({Key? key, required this.group, required this.sectionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group Title Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // Up/Down arrows for sorting items
                Icon(Icons.arrow_upward, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Icon(Icons.arrow_downward, size: 16, color: Colors.grey),
                SizedBox(width: 12),
                Text(
                  group.title, // "Construction site preparation"
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ],
            ),
          ),

          // List of actual items inside this group
          ...group.items.map((item) {
            return ItemRowWidget(
                item: item,
                sectionId: sectionId,
                groupId: group.id
            );
          }).toList(),
        ],
      ),
    );
  }
}