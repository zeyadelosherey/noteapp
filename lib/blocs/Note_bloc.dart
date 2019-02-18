import 'dart:async';

import 'package:noteapp/Util/BlocProvider.dart';
import 'package:noteapp/Util/DatabaseHelper.dart';
import 'package:noteapp/model/NoteModel.dart';

class Note_bloc implements BlocBase{
  List<NoteModel> _Note = new List();
  DatabaseHelper db = new DatabaseHelper();
  StreamController<List<NoteModel>> _NoteCotroller = StreamController<List<NoteModel>>();
  Sink<List<NoteModel>> get _inUser => _NoteCotroller.sink;
  Stream<List<NoteModel>> get outUser => _NoteCotroller.stream;
  Note_bloc(){
    NoteModel model = new NoteModel('hello', '123', '4545');
//    AddNewNote(model);


    _Note.add(model);
    _inUser.add(_Note);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _NoteCotroller.close();
  }
  void AddnewUser(NoteModel user){
    _Note.add(user);
    _inUser.add(_Note);
  }
  void deletenewUser(int userid){
    _Note.removeAt(userid);
    _inUser.add(_Note);
  }
//
//  Future<void> AddNewNote(NoteModel Note ){
//    db.saveNote(Note).then((_){
//      getAllNotes();
//    });
//  }
//







//  Future<void> getAllNotes() {
//    db.getAllNotes().then((notes) {
//      for(int i =0 ; i<notes.length; i++) {
//        _Note.add(NoteModel.fromMap(notes[i]));
//        _inUser.add(_Note);
//      }
//    });

  }


