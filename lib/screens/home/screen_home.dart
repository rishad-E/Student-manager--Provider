import 'package:flutter/material.dart';

import '../../db/functions/db_functions.dart';
import 'widgets/add_student.dart';
import 'widgets/list_student.dart';
import 'widgets/search_student.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          title: const Text(
            'Student Database',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              tooltip: 'Search',
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
          toolbarHeight: 70,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: FloatingActionButton.extended(
            icon: const Icon(
              Icons.add,
            ),
            backgroundColor: Colors.green,
            label: const Text(
              'Add Student',
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  AddStudent(),
                ),
              );
            },
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: ListStudent(),
        ),
      ),
    );
  }
}
