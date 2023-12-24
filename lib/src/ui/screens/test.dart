import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }


  appBar(){
    return AppBar(
    );
  }

  body(){
    return PageView(
      children: [
        // Página 1
        Container(
          color: Colors.blue,
          child: Center(
            child: Text('Contenido de la Página 1'),
          ),
        ),

        // Página 2 con ListView.builder horizontal
        Container(
          color: Colors.green,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                color: Colors.orange,
                margin: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Elemento $index'),
                ),
              );
            },
          ),
        ),

        // Página 3
        Container(
          color: Colors.red,
          child: Center(
            child: Text('Contenido de la Página 3'),
          ),
        ),
      ],
    );
  }
}
