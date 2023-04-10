import 'dart:math';

import 'package:flutter/material.dart';

class HourPicker extends StatefulWidget {
  final double? height;
  final double? width;
  final double? fontSize;
  final ValueChanged<TimeOfDay>? onChanged;
  final TimeOfDay? initialTime;

  HourPicker({
    Key? key,
    this.height = 400,
    this.width = 200,
    this.onChanged,
    this.initialTime,
    this.fontSize = 100

  }) : super(key: key);

  @override
  State<HourPicker> createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;
  bool onLongPress = false;
  final _controller = PageController(
      viewportFraction: 0.5,
      keepPage: true
  );
  double currentPage = 0.0;

  void _listener(){
    setState(() {
      currentPage = _controller.page!;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_listener);
  }

  @override
  void dispose(){
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: (){
              print("Editar teclado");
            },
            onLongPress: (){
              print("Editar ruleta");
              setState(() {
                onLongPress = !onLongPress;
              });
            },
            child: _buildWheelPicker(
              'Hour',
              List.generate(24, (i) => i),
                  (index) {
                setState(() {
                  _hour = index;
                });
              },
              _hour,
              context
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: (){
              print("Editar teclado");
            },
            onLongPress: (){
              print("Editar ruleta");
              setState(() {
                onLongPress = !onLongPress;
              });
            },
            child: _buildWheelPicker(
              'Minute',
              List.generate(60, (i) => i),
                  (index) {
                setState(() {
                  _minute = index;
                });
              },
              _minute,
              context
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWheelPicker(
      String title, List<int> items, Function(int) onChanged, int initialValue, context) {
    return onLongPress ? Container(
        height: 200,
        width: 100,
        child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              controller: PageController(viewportFraction: 0.5, keepPage: true),
              itemBuilder: (context, i){
                if(i == currentPage){
                  return Transform.scale(
                      scale: 1,
                      child: builder(items[i].toString())
                  );
                }else if(i < currentPage){
                  return Transform.scale(
                      scale: max(1 - (currentPage - i), 0.8),
                      child: builder(items[i].toString())
                  );
                }else {
                  return Transform.scale(
                      scale: max(1 - (i - currentPage), 0.8),
                      child: builder(items[i].toString())
                  );
                }},
          )
        ) :
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              controller: PageController(viewportFraction: 0.5, keepPage: true),
              itemBuilder: (_, i){
                if(i == currentPage){
                  return Transform.scale(
                      scale: 1,
                      child: builder(items[i].toString())
                  );
                }else if(i < currentPage){
                  return Transform.scale(
                      scale: max(1 - (currentPage - i), 0.8),
                      child: builder(items[i].toString())
                  );
                }else {
                  return Transform.scale(
                      scale: max(1 - (i - currentPage), 0.8),
                      child: builder(items[i].toString())
                  );
                }},
            )
        ),
      ],
    );
  }

  Widget builder(String number){
    return Container(color: Colors.red, child: Text(number),);
  }
}
