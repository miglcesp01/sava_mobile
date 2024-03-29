// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/warehouse_package_provider.dart';
import '../../widgets/sava_package_widget.dart';
import '../../widgets/warehouse_package_widget.dart';

class SavaPackagesClientScreen extends StatefulWidget {
  const SavaPackagesClientScreen({Key? key}) : super(key: key);

  @override
  State<SavaPackagesClientScreen> createState() =>
      _SavaPackagesClientScreenState();
}

class _SavaPackagesClientScreenState extends State<SavaPackagesClientScreen> {
  dynamic packages = [];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //loading
  bool _isLoading = false;

  //Shared Preferences
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(milliseconds: 500), () async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      dynamic response = await WarehousePackageProvider.getSavaPackages(token!);
      packages = response;
      setState(() {
        _isLoading = false;
      });
    });
  }

  //search controller
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
                            onSaved: (String? value) {
                              searchController.text = value!;
                            },
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.search),
                          onTap: () {
                            String texto = searchController.text;
                            packages = packages
                                .where((dynamic v) =>
                                    v['sava_code'].contains(texto)
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
                                  packages = await WarehousePackageProvider
                                      .getSavaPackages(token!);
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
        Text(
          "Paquetes Sava",
          style:
              TextStyle(fontSize: 30, color: Color.fromARGB(255, 22, 102, 168)),
        ),
        _isLoading
            ? CircularProgressIndicator()
            : packages.length == 0
                ? Column(
                    children: const [
                      ImageIcon(
                        AssetImage("assets/entrega-rapida.png"),
                        size: 200,
                      ),
                      Text(
                        "No se encontraron paquetes",
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: packages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SavaPackageWidget(details: packages[index]);
                    })
      ]),
    );
  }
}
