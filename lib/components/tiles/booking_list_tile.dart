import 'package:cloud_9_agent/models/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef BookingListTileOnTap = Function();

class BookingListTile extends StatelessWidget {
  final BookingListTileOnTap bookingListCardOnTap;
  final BookingListTileOnTap bookingMoreOnTap;
  final Booking booking;

  const BookingListTile(
      {Key key,
      @required this.bookingListCardOnTap,
      @required this.bookingMoreOnTap,
      @required this.booking})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            ListTile(
              onTap: bookingListCardOnTap,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/icons/calendar.png',
                  height: 80,
                ),
              ),
              title: Text(booking.date),
              subtitle: Text(' ${booking.startTime}',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)),
              trailing: IconButton(
                  icon: Icon(Icons.more_vert), onPressed: bookingMoreOnTap),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(booking.service.title,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            )
          ],
        ));
  }
}
