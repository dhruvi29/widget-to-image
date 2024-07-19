import 'package:flutter/material.dart';


class MyTable extends StatefulWidget {
  const MyTable({super.key});

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {

var x =  List.generate(7, (_) =>  List.generate(3, (_)=>TextEditingController() ));

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    x[0][0].text = '31-Jun';
    x[1][0].text = "01-Jul";
    x[2][0].text = "02-Jul";
    x[3][0].text = "03-Jul";
    x[4][0].text = "04-Jul";
    x[5][0].text = "05-Jul";
    x[6][0].text = "06-Jul";
  }
  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                    margin: const EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    color: const Color.fromARGB(100, 104, 58, 183),
                    child: Table(
                      border: TableBorder.all(color: Colors.black12),
                      children: List.generate(7, (i)=> TableRow(
                        children: List.generate(3, (j)=> Container(
                          margin: const EdgeInsets.all(3),
                          height: 20,
                          child: TextField(
                            decoration: const InputDecoration(border: InputBorder.none,),
                            controller: x[i][j],
                          ),
                        ))
                      ))
                      
                    ),
                  ),
                ),
              ),
            ]));
  }
}