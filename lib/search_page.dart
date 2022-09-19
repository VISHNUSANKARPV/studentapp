import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:students/database/functions/db_functions.dart';
import 'package:students/database/model/data_model.dart';
import 'package:students/profile.dart';

// ignore: non_constant_identifier_names
// ValueNotifier<List<studentModel>> Temp = ValueNotifier([]);

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({Key? key}) : super(key: key);
  // final searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        title: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 244, 245),
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            onTap: () {
              FunctionsController()
                  .searchingAdd(FunctionsController().listofStudent);
            },
            onChanged: (String? value) {
              if (value == null || value.isEmpty) {
                FunctionsController()
                    .searchingAdd(FunctionsController().listofStudent);
              } else {
                for (studentModel i in FunctionsController().listofStudent) {
                  if (i.name.toLowerCase().contains(value.toLowerCase())) {
                     FunctionsController().searchdata.add(i);
                  }
                }
              }
           
            },
            // controller: searchcontroller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search',
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<FunctionsController>(
              init: FunctionsController(),
              builder: (controller) {
                return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = controller.searchdata[index];
                    return ListTile(
                      title: Text(data.name),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (ctx) => profile_screen(
                        //           data: data,
                        //         )));
                        Get.to(profile_screen(data: data,));
                      },
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: controller.searchdata.length,
                );
              })),
    );
  }
}
