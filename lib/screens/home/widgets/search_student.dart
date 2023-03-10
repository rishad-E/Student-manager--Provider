import 'dart:io';
import 'package:flutter/material.dart';

import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';
import 'student_full_details.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              if (data.name
                  .toLowerCase()
                  .contains(query.trimRight().toLowerCase())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(ctx).push(
                          MaterialPageRoute(
                            builder: (context) => FullDetails(
                              name: data.name,
                              age: data.age,
                              phone: data.phone,
                              index: index,
                              photo: data.photo,
                              place: data.place,
                            ),
                          ),
                        );
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                    ),
                    const Divider()
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: studentList.length,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              if (data.name
                  .toLowerCase()
                  .contains(query.trimRight().toLowerCase())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(ctx).push(
                          MaterialPageRoute(
                            builder: (context) => FullDetails(
                              age: data.age,
                              place: data.place,
                              index: index,
                              name: data.name,
                              phone: data.phone,
                              photo: data.photo,
                            ),
                          ),
                        );
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                    ),
                    const Divider()
                  ],
                );
              } else {
                return const Center(
                  child: Text("data"),
                );
              }
            },
            itemCount: studentList.length,
          );
        });
  }
}
