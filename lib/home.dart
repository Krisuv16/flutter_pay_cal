import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController hourTextField = TextEditingController();
  final TextEditingController workedTextField = TextEditingController();

  var regularPay = "";
  var overTimePay = "";
  var totalPaid = "";
  var taxPay = "";

  String name = "Krisuv Bohara";
  String studentId = "301274636";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firstSegment(),
            dataSegment(context),
            personalInfo(context),
          ],
        ),
      ),
    );
  }

  Align personalInfo(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Name : $name"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Student ID : $studentId"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align dataSegment(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Report",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Regular Pay $regularPay",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "OverTime Pay $overTimePay",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total Pay $totalPaid",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Tax $taxPay",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column firstSegment() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: workedTextField,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (v) {
              if (v == "") {
                return "Empty ";
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            maxLength: 4,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                counterText: "",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: "Enter Worked Hours"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: hourTextField,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v == "") {
                return "Empty ";
              }
              return null;
            },
            maxLength: 4,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            decoration: InputDecoration(
                counterText: "",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: "Enter Hourly Rate"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var hours = double.parse(workedTextField.text);
                    double hourPay = double.parse(hourTextField.text);
                    if (hours >= 40) {
                      double overTime = hours - 40.00;
                      double totalPay =
                          ((overTime) * (hourPay) * 1.5 + (40 * hourPay))
                              .roundToDouble();

                      double tax = totalPay * 0.18;

                      regularPay = totalPay.toString();
                      overTimePay = (overTime * hourPay).toString();
                      totalPaid = overTime != 0.0
                          ? regularPay
                          : (totalPay + double.parse(overTimePay)).toString();
                      taxPay = tax.toString();
                      setState(() {});
                    } else {
                      double totalPay = ((hours) * (hourPay)).roundToDouble();

                      double tax = totalPay * 0.18;

                      regularPay = totalPay.toString();
                      taxPay = tax.toString();
                      totalPaid = regularPay.toString();

                      setState(() {});
                    }
                  }
                },
                child: const Text("Calculate")),
            ElevatedButton(
                onPressed: () {
                  hourTextField.clear();
                  workedTextField.clear();
                  regularPay = "";
                  overTimePay = "";
                  totalPaid = "";
                  taxPay = "";
                  setState(() {});
                },
                child: const Text("  Clear  ")),
          ],
        ),
      ],
    );
  }
}
