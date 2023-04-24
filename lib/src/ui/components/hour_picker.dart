import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';

class HourPicker extends StatefulWidget {
  final double? height;
  final double? width;
  final double? fontSize;
  final ValueChanged<TimeOfDay>? onChanged;
  final TimeOfDay? initialTime;

  const HourPicker({
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

class _HourPickerState extends State<HourPicker> with SingleTickerProviderStateMixin{
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;

  bool activateWidget = true;
  bool activateRoulette = false;
  bool activateKeyboard = false;

  double opacityRoulette = 0.0;
  double opacityTimer = 1.0;

  late AnimationController animationController;
  late Animation<double> animation;

  final _controller = PageController(
      viewportFraction: 0.5,
      keepPage: true
  );
  double currentPage = 0.0;

  void _changeWidget() {
    setState(() {
      activateRoulette = !activateRoulette;
    });
  }

  void _listener(){
    setState(() {
      currentPage = _controller.page!;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_listener);
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100)
    );
    animation = Tween<double>(begin: 1, end: 0).animate(animationController);
  }

  @override
  void dispose(){
    _controller.removeListener(_listener);
    animationController.dispose();
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
          borderRadius: const BorderRadius.all(Radius.circular(10))
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
                  activateWidget ? _changeWidget() : null;
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
                  if(activateWidget){
                    _changeWidget();
                  }
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
              const SizedBox(),
              !activateKeyboard ? buttonTouchOurKeyboard(Icons.keyboard) : buttonTouchOurKeyboard(Icons.swipe)
            ],
          )
        ],
      ),
    );
  }

  Widget buttonTouchOurKeyboard(IconData icon){
    return IconButton(
        onPressed: (){
          setState(() {
            print("Editar teclado");
            activateWidget = false;
            activateRoulette = false;
            activateKeyboard = !activateKeyboard;
            !activateKeyboard ? activateWidget = true : null;
          });
        },
        icon: Icon(icon, color: const Color(0xff231142),));
  }

  Widget _buildWheelPicker(
      String title, List<int> items, Function(int) onChanged, int initialValue, context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: activateRoulette ? SizedBox(
        height: 130,
        width: 100,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListWheelScrollView(
            itemExtent: 50,
            onSelectedItemChanged: onChanged,
            physics: const FixedExtentScrollPhysics(),
            useMagnifier: true,
            magnification: 1.2,
            squeeze: 1.5,
            diameterRatio: 1,
            perspective: 0.0001,
            offAxisFraction: 0,
            clipBehavior: Clip.none,
            overAndUnderCenterOpacity: 0.5,
            renderChildrenOutsideViewport: true,
            children: items.map((item) {
              return buildItemWheelPicker(item);
            }).toList(),
          ),
        ),
      ) : buildTimer(title),
    );
  }

  Widget buildTimer(String title){
    return FadeTransition(
        opacity: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black)
              ),
              child: Center(child: Text('${_hour}', style: const TextStyle(fontSize: 26, color: Colors.black),),),
            ),
          ],
        ),
    );
  }

  Widget buildItemWheelPicker(int item){
    return Container(
      width: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.black
          )
      ),
      child: Center(
        child: Text(
          item.toString(),
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }

  Widget builder(String number){
    return Container(color: Colors.red, child: Text(number),);
  }
}
