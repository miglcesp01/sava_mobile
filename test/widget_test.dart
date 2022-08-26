// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sava_mobile/main.dart';
import 'package:sava_mobile/providers/user_provider.dart';
import 'package:sava_mobile/providers/warehouse_package_provider.dart';
import 'package:sava_mobile/screens/screens.dart';
import 'package:sava_mobile/widgets/widgets.dart';
import 'dart:math';

void main() {
  test("Login return status 200 when client exists", () async {
    final login =
        await UserProvider.loginUser("cmeneses@espol.edu.ec", "Carlos");

    expect(login['status'], 200);
  });

  test("Register return status 200 and right message", () async {
    var rng = Random();
    final String mail = "miguel${rng.nextInt(1000000)}@espol";
    final register =
        await UserProvider.createUser("034234234", mail, "miguel@espol");

    expect(register['status'], 200);
    expect(register['message'], "Creacion completa");
  });

  test("Obtencion de paquetes exitosa", () async {
    final login =
        await UserProvider.loginUser("cmeneses@espol.edu.ec", "Carlos");
    final token = login['payload']['token'];

    final paquetes = await WarehousePackageProvider.getSavaPackages(token);
    print(paquetes.runtimeType);
    expect(paquetes.runtimeType, List<dynamic>);
  });

  test("Obtener paquetes en bodega", () async {
    final login =
        await UserProvider.loginUser("cmeneses@espol.edu.ec", "Carlos");
    final token = login['payload']['token'];

    final paquetes = await WarehousePackageProvider.getWarehousePackages(token);
    print(paquetes.runtimeType);
    expect(paquetes.runtimeType, List<dynamic>);
  });
}
