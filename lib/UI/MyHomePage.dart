
import 'package:flutter/material.dart';
import 'package:noteapp/Util/BlocProvider.dart';
import 'package:noteapp/Util/DatabaseHelper.dart';
import 'package:noteapp/blocs/Note_bloc.dart';
import 'package:noteapp/model/NoteModel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();

  List<NoteModel> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  Future<void> getAllNotesF() {
      db.getAllNotes().then((notes) {
        for(int i =0 ; i<notes.length; i++) {
          setState(() {
            items.add(NoteModel.fromMap(notes[i]));
          });
        }
      });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotesF();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //final Note_bloc NoteBloc = BlocProvider.of<Note_bloc>(context);

    return Scaffold(
      backgroundColor:Colors.white.withOpacity(0.18) ,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body:
      Container(

        child:ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            if(items.length == 0){
              return Center(child: Text("No data" , style: TextStyle(color: Colors.white , fontSize: 20),),);
            }else{
              return CustomCard('${items[position].Note}' , '${items[position].Date}' , '${items[position].Time}' , items[position].id) ;
            }
          },
        ),
        //CustomCard('this is note' , '12/11/2019' , '12:00'),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: (){
          showdialogAddNote(items);
        },

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget CustomCard (String note , String time , String date , int id){
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.only(bottom: 5 ,left: 15 ,right: 15 ,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15,),
          Padding(padding: EdgeInsets.only(left: 10 , right: 10) ,
            child: Text(note , style: TextStyle(color: Colors.black , fontSize: 20 , ), textDirection: TextDirection.ltr, textAlign: TextAlign.center,),

          ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(Icons.delete ,color: Colors.redAccent,), onPressed: (){
                db.deleteNote(id).then((_){
                  items.clear();
                  getAllNotesF();
                });
              }),
              IconButton(icon: Icon(Icons.edit ,color: Colors.blue,), onPressed:(){
                db.updateNote(NoteModel('${note} updated', '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}','${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'),id).then((_){
                  items.clear();
                  getAllNotesF();
                });
              })

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(date , style: TextStyle(fontSize: 13 , color: Colors.black.withOpacity(0.8)),),
              Icon(Icons.date_range , color: Colors.black.withOpacity(0.8),size: 13,)
              ,SizedBox(width: 20,),
              Text(time , style: TextStyle(fontSize: 13 , color: Colors.black.withOpacity(0.8)),),
              Icon(Icons.access_time , color: Colors.black.withOpacity(0.8),size: 13,)
            ],
          ),
          SizedBox(height: 15,),

        ],
      ),
    );

  }





  Widget showdialogAddNote(List<NoteModel> items){

    showDialog(
           context: context,
        builder: (_) => new AlertDialog(
            title:  Center(child: Text("ADD NOTE" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),)),
            content:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child:
                    TextField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      style: TextStyle(color: Colors.black ),
                      decoration: InputDecoration(fillColor: Colors.black.withOpacity(0.8) , focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black) , )),
                      controller: myController,
                    ),
                  ),
                  SizedBox(height: 25,),
                  RaisedButton(onPressed: (){
                    if(myController.text.isEmpty){
                      print("cant operate this sitiuation");

                    }else{
                      db.saveNote(NoteModel('${myController.text}', '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}','${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}')).then((_){
                        items.clear();
                        getAllNotesF();
                        myController.clear();
                        Navigator.pop(context);
                      });
                    }
                  } ,
                    child: Padding(padding: EdgeInsets.only(right: 50 ,left: 50 ,top: 15 , bottom: 15) ,
                      child: Text("SAVE" , style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),),
                    ),
                    color: Colors.black,
                  ),

                ],
              ),
            )
        )
    );
  }

}