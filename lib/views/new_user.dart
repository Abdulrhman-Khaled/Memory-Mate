import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/new_user.dart';
import '../widgets/add_user.dart';
import '../widgets/controller.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  HomeController homeController = HomeController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
      ),
      body: ListView.builder(
        itemCount: homeController.newUsers.length,
        itemBuilder: (context, index) {
          final NewUser user = homeController.newUsers[index];
          return ListTile(
              onLongPress: () async {
                await homeController.deleteNewUser(index).then((value) {
                  setState(() {});
                }).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User Deleted Successfully'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                });
              },
              onTap: () {
                homeController.nameController.text = user.name!;
                homeController.jobController.text = user.job!;
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return UserForm(
                      homeController: homeController,
                      isUpdate: true,
                      onSubmit: () async {
                        await homeController
                            .updateUser(
                          index,
                          homeController.nameController.text,
                          homeController.jobController.text,
                        )
                            .then((value) {
                          Navigator.pop(context);
                          setState(() {});
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Updated Successfully'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              title: Text(user.name!),
              subtitle: Text(user.job!),
              trailing: user.updatedAt != null
                  ? Text(DateFormat().format(DateTime.parse(user.updatedAt!)))
                  : Text(DateFormat().format(DateTime.parse(user.createdAt!))));
        },
      ),
    );
  }
}
