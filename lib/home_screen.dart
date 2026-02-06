import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:renovation_estimation_impl/common_components/top_bar_component.dart';
import 'package:renovation_estimation_impl/features/renovation_estimation/views/estimation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sidebar Placeholder
          Container(
            width: 247,
            child: const Center(child: Text("Sidebar")),
          ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                const TopBarComponent(), // Fixed Top Bar


                Divider(color: Colors.grey),

                /// Via Valgioie 60
                Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    Text(
                      "Via Valgioie 6o",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Scrollable Area for the Estimation
                Expanded(
                  child: Container(
                    color: Color(0xFFF9F9F9),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          EstimationScreen(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}