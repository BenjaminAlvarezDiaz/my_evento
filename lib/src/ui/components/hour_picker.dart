import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';

class HourPicker extends StatefulWidget {
  final double? height;
  final double? width;
  final double? fontSize;
  final ValueChanged<TimeOfDay>? onChanged;
  final TimeOfDay? initialTime;

  HourPicker({
    Key? key,
    this.height = 200,
    this.width = 400,
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
  double opacity = 0.0;
  bool activateRoulette = false;
  bool activateKeyboard = false;
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
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xff7F0432),
            width: 2
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      height: widget.height,
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: widget.width!/6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){
                  print("Editar ruleta");
                  setState(() {
                    if(!activateKeyboard){
                      activateRoulette = !activateRoulette;
                    }
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
              const SizedBox(width: 20),
              InkWell(
                onTap: (){
                  print("Editar ruleta");
                  setState(() {
                    if(!activateKeyboard){
                      activateRoulette = !activateRoulette;
                    }
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
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              IconButton(
                  onPressed: (){
                    setState(() {
                      print("Editar teclado");
                      activateRoulette = false;
                      activateKeyboard = !activateKeyboard;
                    });
                  },
                  icon: const Icon(Icons.keyboard, color: Color(0xff231142),))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWheelPicker(
      String title, List<int> items, Function(int) onChanged, int initialValue, context) {
    return activateRoulette ? Container(
      height: 130,
      width: 100,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListWheelScrollView(
          itemExtent: 50,
          onSelectedItemChanged: onChanged,
          physics: FixedExtentScrollPhysics(),
          useMagnifier: true,
          magnification: 1.2,
          squeeze: 1.5,
          diameterRatio: 1,
          perspective: 0.0001,
          offAxisFraction: 0,
          clipBehavior: Clip.none,
          overAndUnderCenterOpacity: 0.8,
          renderChildrenOutsideViewport: true,
          children: items.map((item) {
            return Container(
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black)
              ),
              child: Center(
                child: Text(
                  item.toString(),
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ) :
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: Colors.black)
            ),
          child: Center(child: Text('${_hour}', style: TextStyle(fontSize: 26),),),
        ),
      ],
    );
  }

  Widget buildRoulette(String title, List<int> items, Function(int) onChanged, int initialValue, context){
    return activateRoulette ? Container(
      height: 120,
      width: 100,
      child: ListWheelScrollView(
        itemExtent: 50,
        onSelectedItemChanged: onChanged,
        physics: FixedExtentScrollPhysics(),
        useMagnifier: true,
        magnification: 1.2,
        squeeze: 1.5,
        diameterRatio: 1,
        perspective: 0.0001,
        offAxisFraction: 0,
        clipBehavior: Clip.none,
        overAndUnderCenterOpacity: 0.8,
        renderChildrenOutsideViewport: true,
        children: items.map((item) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                item.toString(),
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
          );
        }).toList(),
      ),
    ) :
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: 3,
          duration: Duration(milliseconds: 2000),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: Center(child: Text('${_hour}'),),
        ),
      ],
    );
  }

  Widget roulette(){
    return Container();
  }
  Widget timer(){
    return Positioned(child: Container());
  }

  Widget builder(String number){
    return Container(color: Colors.red, child: Text(number),);
  }
}
