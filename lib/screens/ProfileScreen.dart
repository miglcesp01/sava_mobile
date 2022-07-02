// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new

import 'package:flutter/material.dart';
import 'package:sava_mobile/widgets/text_dialog_widget.dart';

import '../models/dosage_model.dart';
import '../utils/create_cell.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late Widget mediosTable;

  //DataTable columns
  final columns = ["Medio", "Valor"];
  //DataTable rows
  List<MedioContacto> rows = [
    new MedioContacto(medio: "Telefono", valor: "099999889")
  ];

  void addRow() {
    if (rows.isEmpty) {
      rows.add(MedioContacto(medio: "", valor: ""));
    }
    setState(() {});
  }

  void deleteRow() {
    if (rows.isNotEmpty) {
      rows.removeLast();
    }
    setState(() {});
  }

  void limpiarTabla() {
    rows.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints(minHeight: 200),
                alignment: Alignment.center,
                child: Icon(Icons.person, size: 200),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.orange)),
            SizedBox(height: 50),
            Row(children: [
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4),
                  child: Text('Correo: ', style: TextStyle(fontSize: 20))),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Text("miguel@espol.edu.ec",
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis),
              )
            ]),
            SizedBox(height: 20),
            Row(children: [
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4),
                  child: Text('Direccion: ', style: TextStyle(fontSize: 20))),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Text("Espol, Guayaquil",
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis),
              )
            ]),
            buildDataTable(),
          ],
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return DataTable(
      columnSpacing: 60,
      columns: getColumns(),
      rows: getRows(),
    );
  }

  List<DataColumn> getColumns() {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows() => rows.map((MedioContacto medio) {
        final cells = [
          medio.medio,
          medio.valor,
        ];

        return DataRow(
          cells: CellMedioTable.modelBuilder(cells, (index, cell) {
            const showEditIcon = true;

            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                switch (index) {
                  case 0:
                    editMedio(medio);
                    break;
                  case 1:
                    editValue(medio);
                    break;
                }
              },
            );
          }),
        );
      }).toList();

  Future editMedio(MedioContacto editDosage) async {
    var lowerWeight = await showTextDialog(
      context,
      title: 'Editar Medio',
      value: editDosage.medio,
    );
    if (lowerWeight == '') lowerWeight = "0";

    setState(() => rows = rows.map((dosage) {
          final isEditedDosage = dosage == editDosage;

          return isEditedDosage ? dosage.copy(medio: lowerWeight) : dosage;
        }).toList());
  }

  Future editValue(MedioContacto editDosage) async {
    var higherWeight = await showTextDialog(
      context,
      title: 'Editar Valor',
      value: editDosage.valor,
    );
    if (higherWeight == '') higherWeight = "0";

    setState(() => rows = rows.map((dosage) {
          final isEditedDosage = dosage == editDosage;

          return isEditedDosage ? dosage.copy(valor: higherWeight) : dosage;
        }).toList());
  }
}
