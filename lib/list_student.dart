import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:students/profile.dart';

import 'database/functions/db_functions.dart';


class ListStudent extends StatelessWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black87,
        body: GetBuilder<FunctionsController>(
            init: FunctionsController(),
            builder: (Controller) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = Controller.listofStudent[index];
                  return ListTile(
                    // hoverColor: Colors.black,
                    tileColor: const Color.fromARGB(255, 133, 162, 163),
                    title: Text(
                      data.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      data.age,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (ctx) => profile_screen(
                      //           data: data,
                      //         )));
                      Get.offAll(profile_screen(data: data,));
                    },
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(data.image.toString())),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        if (data.id != null) {
                          await Controller.deleteStudent(data.id!);
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: Controller.listofStudent.length,
              );
            }),
      );
  }
}
