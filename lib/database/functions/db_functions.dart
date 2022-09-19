import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../model/data_model.dart';

// ValueNotifier<List<studentModel>> studentListNotifier = ValueNotifier([]);

class FunctionsController extends GetxController {
  List<studentModel> searchdata = [];
  List<studentModel> listofStudent = [];

  void searchingAdd(List<studentModel> searchlist) {
    searchdata.clear();
    searchdata.addAll(searchlist);
    update();
  }

  Future<void> addStudent(studentModel value) async {
    final studentDB = await Hive.openBox<studentModel>('student_db');
    final _id = await studentDB.add(value);
    value.id = _id;
    studentDB.put(value.id, value);
    listofStudent.clear();
    // studentListNotifier.value.add(value);
    listofStudent.addAll(studentDB.values);
    getAllStudents();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<studentModel>('student_db');
    listofStudent.clear();
    listofStudent.addAll(studentDB.values);
    update();
  }

  Future<void> deleteStudent(int id) async {
    final studentDB = await Hive.openBox<studentModel>('student_db');
    await studentDB.delete(id);
    getAllStudents();
  }

  Future<void> updatestudent(int? id, studentModel value) async {
    final studentDB = await Hive.openBox<studentModel>('student_db');
    await studentDB.put(id, value);
    getAllStudents();
  }
}

String img = '';

// imageadd(XFile? pickimage) async {
//   if (pickimage == null) {
//     return;
//   } else {
//     final bytes = File(pickimage.path).readAsBytesSync();
//     img = base64Encode(bytes);
//     return img;
//   }
// }
// File? image;
class Controller extends GetxController {
  pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      //  File image = File(pickedImage.path);
      update();
      final bytes = File(pickedImage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }
  }
}
