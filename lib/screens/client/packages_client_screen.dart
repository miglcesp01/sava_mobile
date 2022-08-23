// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/warehouse_package_provider.dart';
import '../../widgets/warehouse_package_widget.dart';

class PackagesClientScreen extends StatefulWidget {
  const PackagesClientScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PackagesClientScreen> createState() => _PackagesClientScreenState();
}

class _PackagesClientScreenState extends State<PackagesClientScreen> {
  dynamic packages = [];
  dynamic packages_availables = [];

  void addPackage(String newId) {
    setState(() {
      packages.add(newId);
    });
  }

  void deletePackage(String newId) {
    setState(() {
      packages.remove(newId);
    });
  }

  //Shared Preferences
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      dynamic response =
          await WarehousePackageProvider.getWarehousePackages(token!);
      packages_availables = response;
      setState(() {});
    });
  }

  //Search Controller
  final TextEditingController searchController = new TextEditingController();

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
                          child: TextFormField(
                            controller: searchController,
                            onSaved: (value) {
                              searchController.text = value!;
                            },
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.search),
                          onTap: () {
                            String texto = searchController.text;
                            packages_availables = packages_availables
                                .where((dynamic v) =>
                                    v['tracking_number'].contains(texto)
                                        ? true
                                        : false)
                                .toList();
                            setState(() {});
                          },
                        ),
                        searchController.text.isNotEmpty
                            ? IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () async {
                                  prefs = await SharedPreferences.getInstance();
                                  String? token = prefs.getString('token');
                                  packages_availables =
                                      await WarehousePackageProvider
                                          .getWarehousePackages(token!);
                                  searchController.text = "";
                                  setState(() {});
                                },
                                icon: Icon(Icons.close))
                            : Container()
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
                        onPressed: () async {
                          var response =
                              await WarehousePackageProvider.createSavaPackages(
                                  packages);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Paquete creado correctamente')));
                          Navigator.popAndPushNamed(context, "home_client");
                        },
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
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: packages_availables.length,
            itemBuilder: (BuildContext ctxt, int index) {
              print(packages_availables[index]);
              return WarehousePackageWidget(
                tracking_number: packages_availables[index]["tracking_number"],
                details: packages_availables[index],
                addPackage: addPackage,
                removePackage: deletePackage,
                needCheck: true,
              );
            }),
      ]),
    );
  }
}
