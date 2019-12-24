import 'package:example/utils/navigation.dart';
import 'package:flutter/material.dart';

class GeneratedScreen extends StatelessWidget {
  final String name;
  final IconData icon;
  final String inheritedScreenName;

  const GeneratedScreen({
    Key key,
    @required this.name,
    @required this.icon,
    @required this.inheritedScreenName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'To $inheritedScreenName and hide BNB',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigation.toScreen(
                  context,
                  buildInheritedWidget(),
                  rootNavigator: true,
                );
              },
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'To $inheritedScreenName',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigation.toScreen(context, buildInheritedWidget());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInheritedWidget() {
    return Scaffold(
      appBar: AppBar(title: Text(inheritedScreenName)),
      body: Center(child: Text(inheritedScreenName)),
    );
  }
}
