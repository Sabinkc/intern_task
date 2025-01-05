import 'package:flutter/material.dart';
import 'package:intern_app/common/constants.dart';
import 'book_category_view.dart';

class TabBarViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white, // Light background color for tab bar
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              indicatorWeight: 0,
              indicator: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.red, // Background color for the active tab
                borderRadius: BorderRadius.circular(
                    10), // Rounded corners for active tab box
              ),
              labelColor: Colors.white, // Color of the text for selected tab
              unselectedLabelColor:
                  Colors.black, // Color of the text for unselected tabs
              tabs: [
                // Tabs with a Container to align with the Box
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                            .withOpacity(0.2), // Border color for inactive tabs
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Tech"),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                            .withOpacity(0.2), // Border color for inactive tabs
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Science"),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                            .withOpacity(0.2), // Border color for inactive tabs
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("History"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                BookCategoryView(category: "Technology"),
                BookCategoryView(category: "Science"),
                BookCategoryView(category: "History"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
