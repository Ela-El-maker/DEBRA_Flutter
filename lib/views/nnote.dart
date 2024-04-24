import 'package:flutter/cupertino.dart';

final String tableNote = "notes";

class NoteFields {
  static final List<String> values = [
    ///Add all fields
    id, isImportant, number, title, description, time, folderid
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
  static final String folderid = "folderid";
}

class Note {
  final int? id;
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final DateTime? creation;
  final int? folderid;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.creation,
    required this.folderid,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    int? folderid,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        creation: createdTime ?? this.creation,
        folderid: folderid ?? this.folderid,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        creation: DateTime.parse(json[NoteFields.time] as String),
        folderid: json[NoteFields.folderid] as int?,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant! ? 1 : 0,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.time: creation!.toIso8601String(),
        NoteFields.folderid: folderid,
      };
}