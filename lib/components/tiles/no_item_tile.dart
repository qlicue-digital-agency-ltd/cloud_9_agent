import 'package:flutter/material.dart';

typedef NoItemTileOnTap = Function();

class NoItemTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double height;
  final double width;
  final NoItemTileOnTap onTap;

  const NoItemTile({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    this.height = 400,
    this.width = 300,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: width / 3 + 40,
        child: Column(
          children: <Widget>[
            Image.asset(icon, height: width / 3),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: width / 20),
                text: title,
                children: <TextSpan>[
                  TextSpan(
                    text: '\n',
                  ),
                  TextSpan(
                    text: subtitle, style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
