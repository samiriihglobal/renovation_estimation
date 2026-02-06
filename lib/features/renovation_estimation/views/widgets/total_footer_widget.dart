import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/estimation_controller.dart';

class TotalFooterWidget extends GetView<EstimationController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Row 1: Discount Controls
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  "Total discount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
                ),
                Spacer(),
                // Dropdown for Discount Type
                Container(
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                  child: DropdownButton<String>(
                    value: "Percentage",
                    underline: SizedBox(),
                    items: [DropdownMenuItem(value: "Percentage", child: Text("Percentage"))],
                    onChanged: (val) {},
                  ),
                ),
                SizedBox(width: 8),
                // Discount Value Input
                Container(
                  width: 60,
                  height: 35,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                  child: Center(child: Text("5%", style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                SizedBox(width: 16),
                // Buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    controller.updateDiscountPercent(5);
                  //
                  },
                  child: Text("Apply"),
                ),
                SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed: () {
                    controller.updateDiscountPercent(0);
                  },
                  child: Text("Remove"),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Row 2: The Big Green Total Bar
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Color(0xFF4A9E81), // The specific green from Figma
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Reactive Total using GetX Obx
                    Obx(() => Text(
                      "${controller.grandTotalFinal.toStringAsFixed(0)}€ + iva",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    // Small subtitle text
                    Obx(() => Text(
                      "${(controller.grandTotalFinal * 1.22).toStringAsFixed(0)}€ iva included", // Assuming 22% VAT
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                    )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}