import 'package:flutter/material.dart';

class MyHomeDemoOne extends StatefulWidget {
  const MyHomeDemoOne({Key? key}) : super(key: key);

  @override
  State<MyHomeDemoOne> createState() => _MyHomeDemoOneState();
}

class _MyHomeDemoOneState extends State<MyHomeDemoOne> {
  int index = 0;
  bool selectedOneButton = false;
  bool selectedSecondButton = false;
  bool selectedThreeButton = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: pageTitle(),
          ),
          bottomNavigationBar: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.cloud_outlined),
                ),
                Tab(
                  icon: Icon(Icons.beach_access_sharp),
                ),
                Tab(
                  icon: Icon(Icons.brightness_5_sharp),
                ),
              ],
            onTap: pageTaped,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 0.1,
            labelColor: Colors.red,
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: Text("It's cloudy here"),
              ),
              Center(
                child: Text("It's rainy here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
            physics: ScrollPhysics(

            ),
          ),
        )
    );
  }

  void pageTaped(int _index){
    return setState(() {
      index = _index;
    });
  }

  Widget pageTitle(){
    return IndexedStack(
      index: index,
      children: [
        Text("It's cloudy here"),
        Text("It's rainy here"),
        Text("It's sunny here"),
      ],
    );
  }
}
