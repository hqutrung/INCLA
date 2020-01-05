import 'package:document/models/attendance.dart';
import 'package:document/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRSection extends StatefulWidget {
  final Function qrInteraction;
  final Attendance attendance;

  QRSection({@required this.qrInteraction, @required this.attendance});

  @override
  _QRSectionState createState() => _QRSectionState();
}

class _QRSectionState extends State<QRSection>
    with AutomaticKeepAliveClientMixin {
  User user;

  @override
  void initState() {
    user = Provider.of<User>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isOnline = false;
    Function realFunction = widget.qrInteraction;

    if (user.type == UserType.Student) {
      isOnline = (widget.attendance == null)
          ? false
          : widget.attendance.checkOnlineForUser(user.uid);
      if (isOnline) realFunction = () {};
    }

    return GestureDetector(
      onTap: realFunction,
      child: user.type == UserType.Teacher
          ? TeacherStatusQR(attendance: widget.attendance)
          : StudentStatusQR(
              isOnline: isOnline,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StudentStatusQR extends StatelessWidget {
  final bool isOnline;

  StudentStatusQR({@required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      child: Icon(
        isOnline ? Icons.offline_pin : Icons.camera_alt,
        size: 250.0,
        color: isOnline ? Colors.green : Colors.grey,
      ),
    );
  }
}

class TeacherStatusQR extends StatelessWidget {
  final Attendance attendance;

  TeacherStatusQR({@required this.attendance});

  @override
  Widget build(BuildContext context) {
    return (attendance == null)
        ? Container(
            width: 250,
            height: 250,
            child: Icon(
              Icons.add_circle_outline,
              size: 250,
              color: Colors.green,
            ))
        : QrImage(data: attendance.reference.documentID, size: 250);
  }
}
