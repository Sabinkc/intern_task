import 'package:flutter/material.dart';
import 'book_category_view.dart';

class TabBarViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          //displays tabs in container with border
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              indicatorWeight: 0,
              indicator: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
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
                //screens to display in center based on tabs selected
                CategoryViewScreen(category: "Technology"),
                CategoryViewScreen(category: "Science"),
                CategoryViewScreen(category: "History"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
