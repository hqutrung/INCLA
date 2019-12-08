import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function openDrawer;

  // MainAppBar({@required this.title, @required this.openDrawer});
  MainAppBar({Key key, @required this.title, @required this.openDrawer})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  final Size preferredSize; // default is 56.0
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: widget.openDrawer,
      ),
    );
  }
}
