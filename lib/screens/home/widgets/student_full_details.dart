import 'dart:io';
import 'package:flutter/material.dart';

import 'edit_student.dart';

class FullDetails extends StatelessWidget {
  const FullDetails(
      {Key? key,
      required this.name,
      required this.age,
      required this.phone,
      required this.place,
      required this.photo,
      required this.index})
      : super(
          key: key,
        );
  final String name;
  final String age;
  final String phone;
  final String place;
  final String photo;
  final int index;

  @override
  Widget build(BuildContext context) {
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
            'Full Details Of Student',
          ),
          centerTitle: true,
          toolbarHeight: 70,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EditStudent(
                        age: age,
                        place: place,
                        index: index,
                        name: name,
                        phone: phone,
                        image: photo,
                        photo: '',
                      )),
            );
          },
          icon: const Icon(
            Icons.edit,
          ),
          backgroundColor: Colors.green,
          label: const Text(
            'Edit',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    right: 30,
                  ),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: FileImage(
                      File(photo),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Text(
                  "Full Name: $name",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Age: $age",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Phone Number: $phone",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "place: $place",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
