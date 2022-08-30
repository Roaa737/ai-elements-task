import 'package:ai_elements_app/screens/my_second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = "Text";
  final _textController = TextEditingController();
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Text"),value: "Text"),
      const DropdownMenuItem(child: Text("Numbers"),value: "Numbers"),
      const DropdownMenuItem(child: Text("Date"),value: "Date"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Roaa"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Here the First input field
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(labelText: "Enter your number"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                    // Here the Second input field
                    DropdownButton(
                      value: selectedValue,
                      onChanged: (String? newValue){
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                        items: dropdownItems,
                    ),
                    RaisedButton(
                      onPressed: () {
                        // Navigate to second page
                        var route = MaterialPageRoute(
                            builder: (BuildContext context) => MySecondPage(numberOfFields: int.parse(_textController.text), typeOfFields: selectedValue,));
                        Navigator.of(context).push(route);
                      },
                      child: const Text('Next'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}