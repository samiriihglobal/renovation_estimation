import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renovation_estimation_impl/constants.dart';
import 'package:renovation_estimation_impl/features/renovation_estimation/views/widgets/section_widget.dart';
import 'package:renovation_estimation_impl/features/renovation_estimation/views/widgets/total_footer_widget.dart';

import '../logic/estimation_controller.dart';

class EstimationScreen extends GetView<EstimationController> {
  @override
  Widget build(BuildContext context) {
    // We use a Column here because it's being placed inside HomeScreen's Column
    return Container(
      decoration: boxDecoration,
      margin: EdgeInsets.fromLTRB(38, 19, 31, 0),
      child: Column(
        children: [
          /// header
          _header(),

          // List of Sections
          Obx(() => ListView.builder(
            shrinkWrap: true, // Crucial: tells ListView to only take needed space
            physics: const NeverScrollableScrollPhysics(), // Let the parent scroll
            itemCount: controller.sections.length,
            itemBuilder: (context, index) {
              return SectionWidget(section: controller.sections[index]);
            },
          )),
          // Footer
          TotalFooterWidget(),
        ],
      ),
    );
  }


  /// HEADER
  Widget _header() {
    return Container(
      margin: EdgeInsets.fromLTRB(26, 19, 23, 0),
      height: 35,
      child: Row(
        children: [
          const Text(
            "Preventivo ristrutturazione",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              // controller.
              controller.showaddSection();
            },
            child: Container(
              height: 35,
              width: 135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color(0xFF489B79),
              ),
              child: const Center(
                child: Text(
                  "Aggiungi voce",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}