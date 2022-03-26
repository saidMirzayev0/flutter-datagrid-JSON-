import 'package:dashboard/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: getProductDataSource(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? SfDataGrid(source: snapshot.data, columns: getColumns())
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
        },
      ),
    ));
  }

  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await generateProductList();
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridTextColumn(
          columnName: 'Tracking number',
          width: 200,
          label: Container(
              padding: EdgeInsets.only(right: 50.0),
              alignment: Alignment.centerRight,
              child: Text('Tracking number',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'Name Surname',
          width: 200,
          label: Container(
              padding: EdgeInsets.only(right: 50.0),
              alignment: Alignment.centerRight,
              child: Text('Name Surname',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'Email',
          width: 200,
          label: Container(
              padding: EdgeInsets.only(right: 80.0),
              alignment: Alignment.centerRight,
              child:
                  Text('Email', overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'Phone',
          width: 200,
          label: Container(
              padding: EdgeInsets.only(right: 50.0),
              alignment: Alignment.centerRight,
              child:
                  Text('Phone', overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'Address',
          width: 300,
          label: Container(
              padding: EdgeInsets.only(right: 100.0),
              alignment: Alignment.centerRight,
              child: Text('Address',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'Total',
          width: 200,
          label: Container(
              padding: EdgeInsets.only(right: 70.0),
              alignment: Alignment.centerRight,
              child:
                  Text('Total', overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'Currency',
          width: 200,
          label: Container(
              padding: EdgeInsets.only(right: 70.0),
              alignment: Alignment.centerRight,
              child: Text('Currency',
                  overflow: TextOverflow.clip, softWrap: true))),
    ];
  }

  Future<List<Product>> generateProductList() async {
    var response = await http.get(Uri.parse('YOUR API URL'));
    var decodedProducts =
        json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> productList = await decodedProducts
        .map<Product>((json) => Product.fromJson(json))
        .toList();
    return productList;
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Product> productList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 50.0),
        child: Text(
          row.getCells()[0].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 40.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 30.0),
        child: Text(
          row.getCells()[2].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 70.0),
        child: Text(
          row.getCells()[3].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 50.0),
        child: Text(
          row.getCells()[4].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 90.0),
        child: Text(
          row.getCells()[5].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 80.0),
        child: Text(
          row.getCells()[6].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'tracking_number', value: dataGridRow.tracking_number),
        DataGridCell<String>(
            columnName: 'name_surname', value: dataGridRow.name_surname),
        DataGridCell<String>(columnName: 'email', value: dataGridRow.email),
        DataGridCell<String>(columnName: 'phone', value: dataGridRow.phone),
        DataGridCell<String>(columnName: 'address', value: dataGridRow.address),
        DataGridCell<String>(columnName: 'total', value: dataGridRow.total),
        DataGridCell<String>(
            columnName: 'currency', value: dataGridRow.currency),
      ]);
    }).toList(growable: false);
  }
}
