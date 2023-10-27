import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';

class HourPickerComponent extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? fontSize;
  final ValueChanged<TimeOfDay>? onChanged;
  final TimeOfDay? initialTime;

  const HourPickerComponent({
    Key? key,
    this.height = 200,
    this.width = 400,
    this.backgroundColor,
    this.onChanged,
    this.initialTime,
    this.fontSize = 100

  }) : super(key: key);

  @override
  State<HourPickerComponent> createState() => _HourPickerComponentState();

}

class _HourPickerComponentState extends State<HourPickerComponent> with  SingleTickerProviderStateMixin{

  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;
  bool activateRoulette = false;

  List<int> hours = List.generate(24, (index) => index);
  int selectedHour = 0;
  Timer? _timer;
  bool isSpinnerVisible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  void hideSpinnerNumbers() {
    setState(() {
      isSpinnerVisible = false;
    });
  }

  void showSpinnerNumbers() {
    setState(() {
      isSpinnerVisible = true;
    });
  }

  void startTimer() {
    _timer = Timer(Duration(seconds: 5), () {
      hideSpinnerNumbers();
    });
  }

  void resetTimer() {
    _timer?.cancel();
    startTimer();
  }

  void _changeWidget() {
    setState(() {
      activateRoulette = !activateRoulette;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100)
    );
    animation = Tween<double>(begin: 1, end: 0).animate(animationController);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor
      ),
      child: Row(
        children: [

        ],
      ),
    );
  }

  Widget _buildWheelPicker(
      String title, List<int> items, Function(int) onChanged, int initialValue, context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final timeTimer = twoDigits(initialValue.remainder(60));
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
              final timeWheel = twoDigits(item.remainder(60));
              return buildItemWheelPicker(timeWheel);
            }).toList(),
          ),
        ),
      ) : buildTimer(title, timeTimer),
    );
  }

  Widget buildTimer(String title, String time){
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
            child: Center(
              child: Text(
                time,
                style: const TextStyle(fontSize: 26, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemWheelPicker(String item){
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
          item,
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}