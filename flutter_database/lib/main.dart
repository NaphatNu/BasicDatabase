import 'package:flutter/material.dart';
import 'package:flutter_database/models/transections.dart';
import 'package:flutter_database/provider/transection_provider.dart';
import 'package:flutter_database/screen/from_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransectionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: "แอพบัญชี"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FromScreen();
                }));
              },
            )
          ],
        ),
        body: Consumer(
          builder: (context, TransectionProvider provider, Widget? child) {
            var count = provider.transection.length;//นับจำนวนข้อมูล
            if (count<=0) {
              return Center(child: Text("ไม่พบข้อมูล",style: TextStyle(fontSize: 35),),);
            }
            else{
              return ListView.builder(
                itemCount: provider.transection.length,
                itemBuilder: (context, int index) {
                  transections data = provider.transection[index];
                  return Card(
                    margin: EdgeInsets.all(5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            child: Text(data.amount.toString()),
                          )),
                      title: Text(data.title),
                      subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
                    ),
                  );
                });
            }
            
          },
        ));
  }
}
