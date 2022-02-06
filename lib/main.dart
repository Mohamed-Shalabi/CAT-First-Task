import 'package:first_task/modules/auth/auth_provider.dart';
import 'package:first_task/routes.dart';
import 'package:first_task/shared/cache_helper.dart';
import 'package:first_task/shared/dial_codes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dialCodes = countries.map((e) => e['dial_code'] ?? '').toList();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerator.loginScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}