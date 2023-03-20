import 'package:my_evento/src/interfaces/idata_access.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_evento/src/models/event_model.dart';

class EventDataBase implements IDataAccess{
  static final EventDataBase instance = EventDataBase._init();

  static Database? _database;
  EventDataBase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('event.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';



    await db.execute('''
    CREATE TABLE $tableEvents(
    ${EventFields.id} $idType,
    ${EventFields.eventTitle} $textType,
    ${EventFields.image} $textType,
    ${EventFields.date} $textType,
    ${EventFields.startHour} $textType,
    ${EventFields.endHour} $textType,
    ${EventFields.localization} $textType,
    ${EventFields.description} $textType
    )
    ''');
  }

  Future<Event> create(Event event) async {
    final db = await instance.database;

    final id = await db.insert(tableEvents, event.toJson());
    return event.copy(id: id);
  }

  Future <Event> readEvent(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableEvents,
      columns: EventFields.values,
      where: '${EventFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty){
      return Event.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future <List<Event>> readAllEvents() async {
    final db = await instance.database;

    final orderBy = '${EventFields.date} ASC';

    final result = await db.query(tableEvents, orderBy: orderBy);

    return result.map((json) => Event.fromJson(json)).toList();
  }

  Future <int> update(Event event) async {
    final db = await instance.database;
    
    return db.update(
        tableEvents,
        event.toJson(),
        where: '${EventFields.id} = ?',
        whereArgs: [event.id],
    );
  }

  Future <int> delete(int id) async {
    final db = await instance.database;
    
    return db.delete(
        tableEvents,
        where: '${EventFields.id} = ?',
        whereArgs: [id],
    );
  }


  Future close() async {
    final db = await instance.database;

    db.close();
  }

  @override
  getDateEvent() {
    return ;
  }

  @override
  getDescriptionEvent() {
    return ;
  }

  @override
  getHourEvent() {
    return ;
  }

  @override
  getImageEvent() {
    return ;
  }

  @override
  getLocalization() {
    return ;
  }

  @override
  getLocalizationInMap() {
    return ;
  }

  /*@override
  getTitleEvent(){
    int index = 1;
    return readEvent(index);
  }*/

  @override
  Future<List<Event>> getListEvent() {
    return readAllEvents();
  }

  @override
  setDateEvent(String newDate) {
    return ;
  }

  @override
  setDescriptionEvent(String newDescription) {
    return ;
  }

  @override
  setHourEvent(String newHour) {
    return ;
  }

  @override
  setImageEvent(String newImage) {
    return ;
  }

  @override
  setLocalization(String newLocalization) {
    return ;
  }

  @override
  setLocalizationInMap(String newLocalizationInMap) {
    return ;
  }

  @override
  setTitleEvent(String newTitle) {
    return ;
  }

  @override
  setListEvent() {
    return ;
  }

  @override
  closeDataBase() {
    return close();
  }
}