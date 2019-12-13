import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRSection extends StatefulWidget {
  final String code;
  final Function createQR;
  QRSection({this.code, this.createQR});
  @override
  _QRSectionState createState() => _QRSectionState();
}

class _QRSectionState extends State<QRSection>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.createQR,
      child: AttendanceQR(
        code: widget.code,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AttendanceQR extends StatelessWidget {
  final String code;
  AttendanceQR({this.code});

  @override
  Widget build(BuildContext context) {
    Widget alter = (code != null)
        ? QrImage(data: code, size: 250)
        : Icon(Icons.center_focus_weak, size: 250.0);
    return Container(
      height: 250,
      width: 250,
      child: alter,
    );
  }
}
