// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sava_mobile/widgets/sava_package_detail_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

typedef void IntCallback(int id);

class SavaPackageWidget extends StatefulWidget {
  bool needCheck = true;
  final IntCallback addPackage;
  final IntCallback removePackage;
  SavaPackageWidget(
      {Key? key,
      required this.addPackage,
      required this.needCheck,
      required this.removePackage})
      : super(key: key);

  @override
  State<SavaPackageWidget> createState() => _SavaPackageWidgetState();
}

class _SavaPackageWidgetState extends State<SavaPackageWidget> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        color:
            _value == true ? Color.fromARGB(255, 177, 193, 205) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(15),
        elevation: 10,

        // Dentro de esta propiedad usamos ClipRRect
        child: ClipRRect(
          // Los bordes del contenido del card se cortan usando BorderRadius
          borderRadius: BorderRadius.circular(15),

          // EL widget hijo que será recortado segun la propiedad anterior
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Paquete",
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 40, 133, 210)),
                      ),
                    ),
                    Container(
                      child: widget.needCheck == true
                          ? Checkbox(
                              value: _value,
                              onChanged: (value) {
                                if (value!) {
                                  widget.addPackage(3);
                                } else {
                                  widget.removePackage(3);
                                }

                                setState(() {
                                  _value = value;
                                });
                              })
                          : null,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "10203044",
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 115, 123, 130)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: StepProgressIndicator(
                  totalSteps: 10,
                  currentStep: 6,
                  selectedColor: Color.fromARGB(255, 254, 229, 5),
                  unselectedColor: Color.fromARGB(255, 190, 189, 189),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "En bodega de Miami",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 80, 159, 222)),
                    )),
                    IconButton(
                      icon: Icon(Icons.keyboard_double_arrow_right),
                      color: Color.fromARGB(255, 15, 96, 162),
                      onPressed: () async {
                        await showTextDialog(context,
                            numeroRastreo: "123123213",
                            posicionActual: "Miami",
                            peso: "3.5 lb",
                            precio: "33",
                            fecha: "18-06-2022");
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
