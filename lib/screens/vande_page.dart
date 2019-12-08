// import 'dart:async';

// import 'package:document/models/vande_model.dart';
// import 'package:document/services/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class VanDePage extends StatefulWidget {

//   final BaseAuth auth;


//   const VanDePage({Key key, this.auth}) : super(key: key);

//   @override
//   _VanDePageState createState() => _VanDePageState();
// }



// class _VanDePageState extends State<VanDePage> {

//   List<VanDe> vandes;

//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final _nameController = TextEditingController();
//   final _titleController = TextEditingController();
//   final _ngaytaoController = TextEditingController();
//   final _numRepController = TextEditingController();

//   StreamSubscription<Event> _onVandeAddedSubscription;
//   StreamSubscription<Event> _onVandeChangedSubscription;

//   Query _vandeQuery;

  
//   @override
//   void initState()
//   {
//     super.initState();
//     vandes=new List();
//     vandes = new List();
//     _vandeQuery = _database
//         .reference()
//         .child("vande");
//     _onVandeAddedSubscription = _vandeQuery.onChildAdded.listen(onEntryAdded);
//     _onVandeChangedSubscription =
//         _vandeQuery.onChildChanged.listen(onEntryChanged);
//   }


//   void dispose() {
//     _onVandeAddedSubscription.cancel();
//     _onVandeChangedSubscription.cancel();
//     super.dispose();
//   }


//     onEntryChanged(Event event) {
//     var oldEntry = vandes.singleWhere((entry) {
//       return entry.key == event.snapshot.key;
//     });

//     setState(() {
//       vandes[vandes.indexOf(oldEntry)] =
//           VanDe.fromSnapshot(event.snapshot);
//     });
//   }

//   onEntryAdded(Event event) {
//     setState(() {
//       vandes.add(VanDe.fromSnapshot(event.snapshot));
//     });
//   }
// addNewVande(VanDe vandeItem) {
//     if (vandeItem != null) {
//       VanDe todo = new VanDe(vandeItem.name,vandeItem.title,vandeItem.ngaytao,vandeItem.numRep);
//       _database.reference().child("vande").push().set(todo.toJson());
//     }
//   }

//   updateVande(VanDe vandeItem) {
//     //Toggle completed
//     if (vandeItem != null) {
//       _database.reference().child("vande").child(vandeItem.key).set(vandeItem.toJson());
//     }
//   }

//   deleteVande(String vandeID, int index) {
//     _database.reference().child("todo").child(vandeID).remove().then((_) {
//       print("Delete $vandeID successful");
//       setState(() {
//         vandes.removeAt(index);
//       });
//     });
//   }


// showAddTodoDialog(BuildContext context) async {
//     _nameController.clear();
//     _titleController.clear();
//     _ngaytaoController.clear();
//     _numRepController.clear();
 
//     await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: new Row(
//               children: <Widget>[
//                 new Expanded(
//                     child: new TextField(
//                   controller: _nameController,
//                   autofocus: true,
//                   decoration: new InputDecoration(
//                     labelText: 'Add new todo',
//                   ),
//                 )),
//                 new Expanded(
//                     child: new TextField(
//                   controller: _titleController,
//                   autofocus: true,
//                   decoration: new InputDecoration(
//                     labelText: 'Add new todo',
//                   ),
//                 )),
//                 new Expanded(
//                     child: new TextField(
//                   controller: _ngaytaoController,
//                   autofocus: true,
//                   decoration: new InputDecoration(
//                     labelText: 'Add new todo',
//                   ),
//                 )),
//                 new Expanded(
//                     child: new TextField(
//                   controller: _numRepController,
//                   autofocus: true,
//                   decoration: new InputDecoration(
//                   labelText: 'Add new todo',
//                   ),
//                 ))
//               ],
//             ),
//             actions: <Widget>[
//               new FlatButton(
//                   child: const Text('Cancel'),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//               new FlatButton(
//                   child: const Text('Save'),
//                   onPressed: () {
//                     VanDe vandeItem = new VanDe(_nameController.text.toString(),_titleController.text.toString(),_ngaytaoController.text.toString(),_numRepController.text.toString());
//                     addNewVande(vandeItem);
//                     Navigator.pop(context);
//                   })
//             ],
//           );
//         });
//   }

//   _vande() {
//     return ListView.builder(
//         itemCount: vandes.length,
        
//         itemBuilder: (BuildContext context, int index) {
//           String vandeName = vandes[index].name;
//           return Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Slidable(
//                 secondaryActions: <Widget>[
//                   IconSlideAction(
//                     caption: 'Xóa',
//                     color: Colors.red,
//                     icon: Icons.delete,
//                     onTap: () {
//                       setState(() {

//                         vandes.removeAt(index);
//                       });
//                     },
//                   )
//                 ],
//                 actionPane: SlidableBehindActionPane(),
//                 child: RaisedButton(
//                   onPressed: () {

//                   },
//                   padding: EdgeInsets.all(10),
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(
//                         Icons.insert_drive_file,
//                         size: 65,
//                       ),
//                       Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               vandes[index].title,
//                               style: TextStyle(
//                                 fontSize: 20,
//                               ),
//                             ),
//                             Text(
//                               'Người tạo: ' + vandes[index].name,
//                               style: TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   vandes[index].ngaytao,
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Text(
//                                   vandes[index].numRep.toString() + ' Trả lời',
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ]),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text('2h'),
//                           IconButton(
//                             splashColor: Colors.white,
//                             onPressed: () {
//                               setState(() {

//                               });
//                             },
//                             icon: Icon(
//                               Icons.star,

//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )),
//           );
//         });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thảo luận'),
//       ),
//       body: _vande(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showAddTodoDialog(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
