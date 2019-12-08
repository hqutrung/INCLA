
// import 'package:document/models/document_model.dart';
// import 'package:flutter/material.dart';

// class DocumentPage extends StatefulWidget {
//   @override
//   _DocumentPageState createState() => _DocumentPageState();
// }

// class _DocumentPageState extends State<DocumentPage> {
//   _document() {
//     return ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: documents.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             padding: EdgeInsets.all(10),
//             child: RaisedButton(
//               onPressed: (){},
//               padding: EdgeInsets.all(10),
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)
//               ),
//               child: Row(
//                 children: <Widget>[
//                    Column(
//                     children: <Widget>[
//                       Icon(
//                         Icons.insert_drive_file,
//                         size: 65,
//                       ),
//                     ],
//                   ),
//                    Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           documents[index].name,
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                         Text(
//                           documents[index].file,
//                           style: TextStyle(
//                             fontSize: 10,
//                           ),
//                         ),
//                         Text(
//                           documents[index].lop.id + ' - ' + documents[index].lop.name,
//                           style: TextStyle(
//                             fontSize: 10,
//                           ),
//                         ),
//                         Text(
//                           documents[index].ngaytao,
//                           style: TextStyle(
//                             fontSize: 10,
//                           ),
//                         ),
//                       ]),
//                 ],
//               ),
//             )

//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tài liệu'),
//       ),
//       body: _document(),
//     );
//   }
// }
