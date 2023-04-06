import 'package:flutter/material.dart';

import '../../constants/color_constatnts.dart';

class FamilyAndFriendsScreen extends StatelessWidget {
  FamilyAndFriendsScreen({super.key});

  final List people = [
    {"title": "خالد أحمد", "body": "صديق ", "image": "photo.png"},
    {"title": "خالد أحمد", "body": "صديق ", "image": "photo.png"},
    {"title": "خالد أحمد", "body": "صديق ", "image": "photo.png"},
    {"title": "خالد أحمد", "body": "صديق ", "image": "photo.png"},
    {"title": "خالد أحمد", "body": "صديق ", "image": "photo.png"},
    {"title": "خالد أحمد", "body": "صديق ", "image": "photo.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 70.0,
          ),
          Column(
            children: [
              SizedBox(
                height: 500.0,
                child: ListView.builder(
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: Key("$index"),
                          child: (listpeople(
                            people: people[index],
                          )));
                    }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(155.0, 60.0),
                      shadowColor: AppColors.lightGrey,
                      backgroundColor: AppColors.mintGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.group_add_sharp,
                      size: 20,
                      color: AppColors.white,
                    ),
                    label: const Text(
                      ' إضافة شخص  ',
                      style: TextStyle(color: AppColors.white, fontSize: 13),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class listpeople extends StatelessWidget {
  final people;
  listpeople({this.people});
  @override
  Widget build(BuildContext context) {
    var myController;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: const Color.fromARGB(255, 244, 244, 244),
        child: SizedBox(
          height: 70.0,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.mintGreen,
                    child: Icon(
                      Icons.person,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: ListTile(
                      title: Text("${people['title']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${people['body']}"),
                        ],
                      ),
                    ),
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
