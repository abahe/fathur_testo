import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'views/login_page.dart';
import 'views/dashboard_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider Demo',
      home: FutureBuilder(
        future: Provider.of<AuthProvider>(context, listen: false).checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<AuthProvider>(
              builder: (context, auth, _) {
                return auth.isLoggedIn ? DashboardPage() : LoginPage();
              },
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}