import 'package:flutter/material.dart';

import '../models/patient_user.dart';
import '../widgets/add_user.dart';
import '../widgets/controller.dart';
import 'new_user.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          TextButton(
            child: const Text(
              'NewUsers',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewUserPage(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(homeController.newUsers);
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return UserForm(
                homeController: homeController,
                onSubmit: () async {
                  await homeController.addNewUser();
                  print(homeController.newUsers);
                  Navigator.pop(context);
                  homeController.nameController.clear();
                  homeController.jobController.clear();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewUserPage(),
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: homeController.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(
                "Error: $error",
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  leading: user.avatar != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            user.avatar!,
                            width: 50,
                            height: 50,
                          ),
                        )
                      : null,
                  title: Text(user.email ?? ''),
                  subtitle: Text(user.firstName ?? ''),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
