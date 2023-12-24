import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_evento/src/ui/components/button_multifunction_component.dart';
import 'package:my_evento/src/ui/components/calendar_picker.dart';
import 'package:my_evento/src/ui/components/my_behavior.dart';
import 'package:my_evento/src/ui/components/search_box_component.dart';
import 'package:my_evento/src/ui/screen_controllers/my_home_screen_controller.dart';
import 'package:my_evento/src/models/event_model.dart';
import 'package:my_evento/src/ui/screens/test.dart';
import 'package:my_evento/values/k_colors.dart';
import 'package:my_evento/values/k_icons.dart';

import '../../utils/screen_args.dart';

class MyHomeScreen extends StatefulWidget {
  final ScreenArgs? args;
  const MyHomeScreen(this.args, {super.key});

  @override
  StateMVC<MyHomeScreen> createState() => _MyHomeScreenState(this.args);
}

class _MyHomeScreenState extends StateMVC<MyHomeScreen> with TickerProviderStateMixin  {
  late MyHomeScreenController _con;
  ScreenArgs? args;
  late List<Event> events;
  bool isLoading = false;

  _MyHomeScreenState(ScreenArgs? arguments) : super (MyHomeScreenController(arguments)) {
    _con = MyHomeScreenController.con;
    args = arguments;
  }

  int _selectedIndex = 0;
  PageController pageController = PageController();
  late final TabController tabController;

  @override
  void initState(){
    _con.initScreen(arguments: args);
    tabController = TabController(length: 4, vsync: this);
    super.initState();

    refreshEvents();
  }

  Future refreshEvents() async {
    setState(() => isLoading = true);

    events = await _con.getListEvent();

    setState(() => isLoading = false);
  }

  @override
  void dispose(){
    _con.closeDataBase();

    super.dispose();
  }

  void onTaped(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: KTransparent,
        leading: leading(),
        actions: [
          actions()
        ],
        //centerTitle: false,
        title: titlePage(),
        backgroundColor: KPrimary,
      ),
      body: body(context),
      bottomNavigationBar: BottomNavigationBar(
        items: barItems(),
        backgroundColor: KWhite,
        selectedIconTheme: const IconThemeData(color: KSecondary, size: 30),
        unselectedIconTheme: IconThemeData(color: KSecondary.withOpacity(0.4)),
        currentIndex: _selectedIndex,
        onTap: onTaped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget tapBarNotUse(){
    return TabBar(tabs: const [
      Tab(icon: Icon(Icons.home),),
      Tab(icon: Icon(Icons.calendar_month),),
      Tab(icon: Icon(Icons.add),),
      Tab(icon: Icon(Icons.person),),
    ],
      controller: TabController(length: 4, vsync: this),
      indicator: const BoxDecoration(
          border: Border(top: BorderSide(color: KSecondary, width: 2.0))
      ),
      onTap: onTaped,
    );
  }

  List<BottomNavigationBarItem> barItems(){
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: ''
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: ''
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: ''
      )
    ];
  }

  Widget leading(){
    return IconButton(
        onPressed: (){},
        icon: const Icon(KOptions),
        tooltip: ('Opciones')
    );
  }

  Widget actions(){
    return IconButton(
      onPressed: (){},
      icon: const Icon(KNotifications),
      tooltip: ('Notificaciones'),
    );
  }

  Widget body(context){
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          isLoading ? const Center(child: CircularProgressIndicator())
              : eventListHome(),
          calendar(),
          myEventList(context),
          Container(color: KRed,)
        ],
      ),
    );
  }

  void onPageChanged(int _index){
    return setState(() {
      _selectedIndex = _index;
    });
  }

  Widget titlePage(){
    return IndexedStack(
      index: _selectedIndex,
      children: const [
        Center(child: Text('Inicio')),
        Center(child: Text('Calendario de eventos')),
        Center(child: Text('Tus eventos')),
        Center(child: Text('Tu perfil'))
      ],
    );
  }

  Widget home(){
    return Container();
  }

  Widget eventListHome(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SearchBox(
              placeHolder: 'Buscar',
              textStyle: const TextStyle(
                color: KGrey4,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Mas populares', style: TextStyle(fontSize: 20, color: KGrey2),)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: eventList(),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text('Por Categoria', style: TextStyle(fontSize: 20, color: KGrey2),),
                Expanded(child: SizedBox()),
                GestureDetector(
                    onTap: (){},
                    child: Text('Ver todo', style: TextStyle(fontSize: 16, color: KPrimary),)
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                eventsCategory(KMusic, 'Musica'),
                eventsCategory(KTech, 'Tech'),
                eventsCategory(KSports, 'Deportes'),
                eventsCategory(KFashion, 'Moda'),
                eventsCategory(KCulture, 'Cultura'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Mas recientes', style: TextStyle(fontSize: 20, color: KGrey2),)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: eventList(),
          ),
        ],
      ),
    );
  }

  Widget eventList(){
    return Container(
      height: 200,
      width: 600,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(height: 10,),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: itemBuilder,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget eventsCategory(IconData icon, String text){
    return Container(
      child: Column(
        children: [
          Container(
              height: 50,
              width: 50,
              child: Icon(icon, color: KBackgroundColor,),
              decoration: BoxDecoration(color: KPrimary, borderRadius: BorderRadius.circular(10)),
          ),
          Text(text, style: TextStyle(fontSize: 16, color: KGrey2)),
        ],
      ),
    );
  }

  Widget myEventList(context){
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          newEvent(context),
          const SizedBox(height: 20),
          isLoading ? const Center(child: CircularProgressIndicator())
              :
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: itemBuilder,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
            ),
          )
        ],
      ),
    );
  }

  Widget calendar(){
    late int? daySelected = 0;
    return Container(
        color: KWhite,
        child: CalendarPicker(
          daysWithBorder: false,
          nameDaysWithBorder: false,
          fontWeightOfNameDay: FontWeight.w500,
          fontWeightOfDay: FontWeight.normal,
          fontWeightOfMonth: FontWeight.w500,
          onDaySelected: (date){
            setState(() {
              daySelected = date.day;
              print(daySelected);
            });
          },
        )
    );
  }

  Widget newEvent(context){
    return ButtonMultifunction(
      text: const Text('Nuevo evento', style: TextStyle(
          color: KWhite,
          fontWeight: FontWeight.bold,
          fontSize: 16),
      ),
      icon: const Icon(
        Icons.add,
        color: KWhite,
      ),
      onTap: (){
        _con.onPressedCreateEvent(context);
        },
      withIcon: true,
      withBorder: true,
      width: 200,
    );
  }

  Widget itemBuilder(BuildContext context, int index){
    return InkWell(
      onTap: (){
        _con.onPressedEvent(context, index, events);
      },
      child: Container(
        height: 200,
        width: 400,
        color: KWhite,
        child: Stack(
          children: [
            imageItemBuilder(index),
            informationItemBuilder(index)
          ],
        ),
      ),
    );
  }

  Widget imageItemBuilder(int index){
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('${_con.getListEvent()[index].image}'),
              fit: BoxFit.cover)
          )
      ),
    );
  }

  Widget informationItemBuilder(int index){
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: title(index),
        ),
        Expanded(
          flex: 1,
          child: dateHourAndLocalization(index),
        )
      ],
    );
  }

  Widget title(int index){
    return Row(
      children: [
        const Expanded(flex: 14, child: SizedBox()),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(flex: 3,
                  child: Text('${_con.getListEvent()[index].eventTitle}',
                      style: const TextStyle(
                          fontSize: 18,
                          color: KDefault_Text,
                          fontWeight: FontWeight.w500))),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  Widget dateHourAndLocalization(int index){
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(flex: 20 , child: Text('${_con.getListEvent()[index].date.day.toString()}'
                      '/${_con.getListEvent()[index].date.month.toString()}'
                      ' de ${_con.getListEvent()[index].startHour}'
                      ' a ${_con.getListEvent()[index].endHour}',
                      style: const TextStyle(fontSize: 16, color: KDefault_Text))),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(flex: 20, child: Text('${_con.getListEvent()[index].localization}', style: const TextStyle(fontSize: 16, color: KDefault_Text))),
                  const Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
        const Expanded(flex: 2, child: SizedBox())
      ],
    );
  }

}

//Para ver los eventos de una persona necesito completar en el event model una id del propio usuario para luego buscar en
// la tabla de la base de datos los eventos que tengan la misma id para mostrarlos en la otra pantalla
//Expanded(flex: 1, child: Text(_con.getListEvent()[index].date.day.toString(), style: const TextStyle(fontSize: 16),)),
//Expanded(flex: 1, child: Text('/ ${_con.getListEvent()[index].date.month.toString()}', style: const TextStyle(fontSize: 16),)),
//const Expanded(flex: 1, child: Text('de',  style: TextStyle(fontSize: 16))),
//Expanded(flex: 2, child: Text('${_con.getListEvent()[index].startHour}', style: const TextStyle(fontSize: 16))),
//const Expanded(flex: 1, child: Text('a', style: TextStyle(fontSize: 16))),
//Expanded(flex: 2, child: Text('${_con.getListEvent()[index].endHour}', style: const TextStyle(fontSize: 16))),