import 'package:flutter/material.dart';
import 'package:flutter_database/models/transections.dart';
import 'package:flutter_database/provider/transection_provider.dart';
import 'package:provider/provider.dart';

class FromScreen extends StatelessWidget {
  FromScreen({super.key});
  final formKey = GlobalKey<FormState>();

  //controller
  final titleController = TextEditingController(); //รับค่าชื่อรายการ
  final amountController = TextEditingController(); //รับตัวเลขจำนวนเงิน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แบบฟอร๋มบันทึกข้อมูล"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "ชื่่อรายการ"),
                  autofocus: true,
                  controller: titleController,
                  validator: <String>(str) {
                    if (str.isEmpty) {
                      return "กรุณาป้อนชื่อรายการ";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "จำนวนเงิน"),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: <String>(str) {
                    if (str.isEmpty) {
                      return "กรุณาป้อนจำนวนเงิน";
                    }
                    if (double.parse(str) <= 0) {
                      return "กรุณาป้อนตัวเลขมากกว่า 0";
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;

                      //เตรียมข้อมูล
                      transections statement = transections(
                          title: title,
                          amount: double.parse(amount),
                          date: DateTime.now());

                      //เรียก Porvider
                      var provider = Provider.of<TransectionProvider>(context,
                          listen: false);
                      provider.addTransection(statement);

                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red;
                        }
                        return Colors.blue;
                      },
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text("เพิ่มข้อมูล"),
                )
              ],
            ),
          ),
        ));
  }
}
