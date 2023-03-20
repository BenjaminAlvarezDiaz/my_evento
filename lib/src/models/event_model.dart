final String tableEvents = 'events';

class EventFields{
  static final List<String> values = [
    //Add all fields
    id, eventTitle, image, date, startHour, endHour, localization, description
  ];

  static final String id = '_id';
  static final String eventTitle= 'eventTitle';
  static final String image = 'image';
  static final String date = 'date';
  static final String startHour = 'startHour';
  static final String endHour = 'endHour';
  static final String localization = 'localization';
  static final String description = 'description';
}

class Event{

  int? id;
  String eventTitle;
  String image;
  DateTime date;
  String startHour;
  String endHour;
  String localization;
  String description;


  Event(
      this.id,
      this.eventTitle,
      this.image,
      this.date,
      this.startHour,
      this.endHour,
      this.localization,
      this.description
  );

  Event copy({
    int? id,
    String? eventTitle,
    String? image,
    DateTime? date,
    String? startHour,
    String? endHour,
    String? localization,
    String? description,
  }) =>
      Event(
        id ?? this.id,
        eventTitle ?? this.eventTitle,
        image ?? this.image,
        date ?? this.date,
        startHour ?? this.startHour,
        endHour ?? this.endHour,
        localization ?? this.localization,
        description ?? this.description,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
    json[EventFields.id] as int?,
    json[EventFields.eventTitle] as String,
    json[EventFields.image] as String,
    DateTime.parse(json[EventFields.date] as String),
    json[EventFields.startHour] as String,
    json[EventFields.endHour] as String,
    json[EventFields.localization] as String,
    json[EventFields.description] as String,
  );

  Map<String, Object?> toJson() => {
    EventFields.id: id,
    EventFields.eventTitle: eventTitle,
    EventFields.image: image,
    EventFields.date: date.toIso8601String(),
    EventFields.startHour: startHour,
    EventFields.endHour: endHour,
    EventFields.localization: localization,
    EventFields.description: description,
  };

}