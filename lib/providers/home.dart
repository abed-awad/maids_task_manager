import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/connectors/data.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/styles/color.dart';

class HomeController extends ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  List<TodoModel> todos = [];

  int totalTodos = 0;
  int skip = 0;
  final limit = 10;
  bool hasMore = true;
  bool isLoading = false;

  final dataConnector = DataConnector();

  void refreshData() async {
    isLoading = false;
    hasMore = true;
    skip = 0;
    todos = [];

    getData();
  }

  void getData() async {
    if (isLoading || !hasMore) return;
    _setLoading(true);
    final data = await dataConnector.getAllTodos(
      skip,
      limit,
    );
    _setLoading(false);

    skip += limit;
    totalTodos = data.total;
    todos.addAll(data.todos);

    if (data.todos.length < limit) {
      _setHasMore(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setHasMore(bool value) {
    hasMore = value;
    notifyListeners();
  }

  Future<bool> showExitDialog(BuildContext ctx) async {
    return await showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text(
          "Are you sure",
          style: TextStyle(
            color: ColorsStyle.blackColor,
            fontSize: 16.sp,
          ),
        ),
        content: Text(
          "You want to exit from this app?",
          style: TextStyle(
            color: ColorsStyle.blackColor,
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop(false);
            },
            child: Text(
              "No",
              style: TextStyle(
                color: ColorsStyle.primaryColor,
                fontSize: 12.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              "Exit",
              style: TextStyle(
                color: ColorsStyle.primaryColor,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ) as bool;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
