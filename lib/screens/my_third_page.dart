import 'package:flutter/material.dart';

class MyThirdPage extends StatefulWidget {
  final List<String> listOfData;
  const MyThirdPage({Key? key, required this.listOfData}) : super(key: key);

  @override
  _MyThirdPageState createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: printAllData(),
        )
      ),
    );
  }
  // We use this function to print the user input data on the third screen
  List<Widget> printAllData(){
    List<Widget> widgets = [];
    for (var i = 0; i < widget.listOfData.length; i++){
      widgets.add(
          SizedBox(
            height: 50,
            child: Center(
                child: Text(widget.listOfData[i])
            )),
          );
    }
    return widgets;
  }
}
