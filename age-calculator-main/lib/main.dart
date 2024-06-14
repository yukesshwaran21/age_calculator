import 'package:flutter/material.dart';

void main() {
  runApp(AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 22.0),
          bodyText2: TextStyle(fontSize: 20.0),
          headline6: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: AgeCalculatorScreen(),
    );
  }
}

class AgeCalculatorScreen extends StatefulWidget {
  @override
  _AgeCalculatorScreenState createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  int? _years;
  int? _months;
  int? _days;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _calculateAge(pickedDate);
      });
    }
  }

  void _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    int days = today.day - birthDate.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(today.year, today.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    setState(() {
      _years = years;
      _months = months;
      _days = days;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green, // Change background color here
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Age Calculator',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter your name',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  ),
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 20),
                Text(
                  _selectedDate == null
                      ? 'Please select your birth date'
                      : 'Selected Date: ${_selectedDate!.toLocal()}'
                          .split(' ')[0],
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _pickDate,
                  child: Text(
                    'Select Birth Date',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _years == null
                      ? ''
                      : '${_nameController.text}, you are $_years years, $_months months, and $_days days old',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
