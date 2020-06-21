import 'package:flutter/material.dart';

typedef BookingListTileOnTap = Function();


class BookingListTile extends StatelessWidget {
  final BookingListTileOnTap bookingListCardOnTap;
  final BookingListTileOnTap bookingMoreOnTap;

  const BookingListTile(
      {Key key,
      @required this.bookingListCardOnTap,
      @required this.bookingMoreOnTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          onTap: bookingListCardOnTap,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/icons/calendar.png',
              height: 80,
            ),
          ),
          title: Text(
            'Tooth check',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('09 Jan 2020, sam-10am'),
          trailing: IconButton(
              icon: Icon(Icons.more_vert), onPressed: bookingMoreOnTap),
        ));
  }
}
