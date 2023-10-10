import 'package:flutter/material.dart';
import 'package:form_exapmle/models/user.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key, required this.userInfo});

  User userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        centerTitle: true,
      ),
      body: Card(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Name: ${userInfo.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text('About: ${userInfo.about}'),
              leading: const Icon(Icons.person),
              trailing: Text('Country: ${userInfo.country}'),
            ),
            ListTile(
              title: Text(
                'Phone: ${userInfo.phone}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(Icons.phone),
            ),
            ListTile(
              title: Text(
                'Email: ${userInfo.email.isEmpty ? 'Not specified' : userInfo.email}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }
}
