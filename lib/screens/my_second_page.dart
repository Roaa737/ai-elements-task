import 'package:ai_elements_app/screens/my_third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MySecondPage extends StatefulWidget {
  final int numberOfFields;
  final String typeOfFields;

  const MySecondPage(
      {Key? key, required this.numberOfFields, required this.typeOfFields})
      : super(key: key);

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  List<DateTime> dates = [];
  final List<TextEditingController> _textOfFieldsController = [];
  final List<TextEditingController> _numbersOfFieldsController = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
                children: generateWidgets()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) =>
                MyThirdPage(listOfData: convertDataToStrings()),
          );
          Navigator.of(context).push(route);
        },
        child: const Text("Save"),
      ),
    );
  }

  // We use this function to generate the widgets inside
  // second page to display it on the second screen.
  List<Widget> generateWidgets() {
    List<Widget> widgets = [];
    for (var i = 0; i < widget.numberOfFields; i++) {
      dates.add(DateTime.now());
    }
    for (var i = 0; i < widget.numberOfFields; i++) {
      _textOfFieldsController.add(TextEditingController());
    }
    for (var i = 0; i < widget.numberOfFields; i++) {
      _numbersOfFieldsController.add(TextEditingController());
    }
    for (var i = 0; i < widget.numberOfFields; i++) {
      if (widget.typeOfFields == "Date") {
        widgets.add(
          Column(
            children: [
              Center(
                child:
                    Text('${dates[i].year}/${dates[i].month}/${dates[i].day}'),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dates[i],
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    );

                    //if 'Cancel' => null
                    if (newDate == null) return;

                    //if 'Ok' => null
                    setState(() => dates[i] = newDate);
                  },
                  child: const FittedBox(
                    child: Text("Select Date"),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      if (widget.typeOfFields == "Text") {
        widgets.add(SizedBox(
          height: 200,
          child: TextField(
            controller: _textOfFieldsController[i],
            decoration: const InputDecoration(labelText: "Enter your number"),
          ),
        ));
      }
      if (widget.typeOfFields == "Numbers") {
        widgets.add(SizedBox(
          height: 200,
          child: TextField(
            controller: _numbersOfFieldsController[i],
            decoration: const InputDecoration(labelText: "Enter your number"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
        ));
      }
    }
    return widgets;
  }

  // We use this function to convert the user input data
  // to strings data to use it in the third page to
  // display input data on the third screen.
  List<String> convertDataToStrings() {
    List<String> result = [];
    if (widget.typeOfFields == "Date") {
      for (var i = 0; i < widget.numberOfFields; i++) {
        result.add('${dates[i].year}/${dates[i].month}/${dates[i].day}');
      }
    } else if (widget.typeOfFields == "Text") {
      for (var i = 0; i < widget.numberOfFields; i++) {
        result.add(_textOfFieldsController[i].text);
      }
    } else {
      for (var i = 0; i < widget.numberOfFields; i++) {
        result.add(_numbersOfFieldsController[i].text);
      }
    }
    return result;
  }
}
