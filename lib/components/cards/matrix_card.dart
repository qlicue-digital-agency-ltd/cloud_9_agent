import 'package:flutter/material.dart';

typedef MatrixCardOnTap = Function();

class MatrixCard extends StatelessWidget {
  final String subtitle;
  final Color textColor;
  final String title;
  final Color backgroundColor;
  final MatrixCardOnTap onTap;
  final bool isLoading;

  const MatrixCard(
      {Key key,
      @required this.subtitle,
      @required this.title,
      @required this.textColor,
      @required this.backgroundColor,
      @required this.onTap,
      this.isLoading = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 2,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(children: <Widget>[
            isLoading ? Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),) : Container(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: TextStyle(color: textColor,fontSize: 18)),
            ),
            Positioned(
              right: 0,
              bottom: 0,
                          child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(subtitle, style: TextStyle(color: textColor, fontSize: 25)),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
