import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => userProvider.fetchUsers(),
        child: userProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: userProvider.users.length,
          itemBuilder: (context, index) {
            final user = userProvider.users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          },
        ),
      ),
    );
  }
}