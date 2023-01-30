import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_database/provider/student_provider.dart';
import 'package:provider/provider.dart';
import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';

class AddStudent extends StatelessWidget {
   AddStudent({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  bool imageAlert = false;



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentsImageProvider =
        Provider.of<StudentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      studentsImageProvider.image=null;
    });
    log("rebuilt");
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        backgroundColor: Colors.green,
        title: const Text('Fill The Details'),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<StudentProvider>(
                    builder: (context, value, child) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: value.image?.path == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.black38,
                                  radius: 60,
                                  child: Icon(
                                    Icons.image,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(value.image!.path),
                                  ),
                                  radius: 60,
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, elevation: 10),
                        onPressed: () {
                          Provider.of<StudentProvider>(context, listen: false)
                              .getPhoto();
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        label: const Text(
                          'Add An Image',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixText: 'Age',
                    ),
                    validator: (
                      value,
                    ) {
                      if (value == null || value.isEmpty) {
                        return 'Required Age ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone Number';
                      } else if (value.length != 10) {
                        return 'Require valid Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _placeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixText: 'Place',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Require Place ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          studentsImageProvider.image != null) {
                        onAddStudentButtonClicked(context);
                        Navigator.of(context).pop();
                      } else {
                        imageAlert = true;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, elevation: 10),
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final phone = _phoneNumberController.text.trim();
    final place = _placeController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        phone.isEmpty ||
        place.isEmpty ||
        Provider.of<StudentProvider>(context, listen: false)
            .image!
            .path
            .isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Sucessfully  Added Student.. "),
        ),
      );
    }

    final student = StudentModel(
      name: name,
      age: age,
      phone: phone,
      place: place,
      photo: Provider.of<StudentProvider>(context,listen: false).image!.path,
    );
    addStudent(student);
  }
}
