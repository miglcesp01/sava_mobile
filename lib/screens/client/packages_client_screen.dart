// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../widgets/sava_package_widget.dart';

class PackagesClientScreen extends StatefulWidget {
  const PackagesClientScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PackagesClientScreen> createState() => _PackagesClientScreenState();
}

class _PackagesClientScreenState extends State<PackagesClientScreen> {
  final packages = [];

  void addPackage(int newId) {
    setState(() {
      packages.add("Paquete");
    });
  }

  void deletePackage(int newId) {
    setState(() {
      packages.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Card(
            color: Color.fromARGB(255, 177, 206, 229),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Ingrese su código",
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 15, 96, 162)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // color: Color.fromARGB(255, 58, 113, 158),
                          border: Border.all(
                            color: Color.fromARGB(255, 6, 37, 62),
                            width: 3,
                          )),
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(),
                        ),
                        Icon(Icons.search)
                      ]),
                    ),
                  )
                ],
              ),
            )),
        Container(
            child: packages.isNotEmpty
                ? Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.yellow)),
                        onPressed: () {},
                        child: Text(
                          "Enviar Paquetes (${packages.length})",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
                : null),
        Text(
          "Paquetes enviados",
          style:
              TextStyle(fontSize: 30, color: Color.fromARGB(255, 22, 102, 168)),
        ),
        SavaPackageWidget(
          addPackage: addPackage,
          removePackage: deletePackage,
          needCheck: true,
        ),
        SavaPackageWidget(
          addPackage: addPackage,
          removePackage: deletePackage,
          needCheck: true,
        ),
        SavaPackageWidget(
          addPackage: addPackage,
          removePackage: deletePackage,
          needCheck: true,
        ),
      ]),
    );
  }
}
