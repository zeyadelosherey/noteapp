class NoteModel {
  int _id;
  String _Note;
  String _Date;
  String _Time;

  NoteModel(this._Note, this._Date , this._Time);

  NoteModel.map(dynamic obj) {
    this._id = obj['id'];
    this._Note = obj['Note'];
    this._Date = obj['Date'];
    this._Time = obj['Time'];
  }
  int get id => _id;
  String get Note => _Note;
  String get Date => _Date;
  String get Time => _Time;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['Note'] = _Note;
    map['Date'] = _Date;
    map['Time'] = _Time;

    return map;
  }

  NoteModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._Note = map['Note'];
    this._Date = map['Date'];
    this._Time = map['Time'];
  }
}