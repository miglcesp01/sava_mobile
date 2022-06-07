import 'package:flutter/material.dart';
import 'package:sava_mobile/constants/routes.constants.dart';

void main() {
  runApp(const SavaExpressApp());
}

class SavaExpressApp extends StatelessWidget {
  const SavaExpressApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: PagesRoutes.routes,
      title: 'SavaExpress'
    );
  }
}