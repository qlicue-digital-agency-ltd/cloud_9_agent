import 'package:cloud_9_agent/models/service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_9_agent/screens/set_appointment_screen.dart';

import 'media_preview_list_page.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Service service;

  const ServiceDetailScreen({Key key, @required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          service.title,
          maxLines: 1,
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.w100),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetAppointmentScreen(
                      service: service,
                    ),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    service.images.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                service.images[0].url),
                                            fit: BoxFit.cover)),
                                    height: 200,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  MediaPreviewListPage(
                                                    media: service.images,
                                                  )));
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Hero(
                                          tag: service.images[0].url,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        service.images[0].url),
                                                    fit: BoxFit.cover)),
                                            height: 200,
                                          ),
                                        ),
                                        Positioned(
                                          top: 80,
                                          left: 40,
                                          child: Text(
                                            '+' +
                                                service.images.length
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          )
                        : Container(),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            service.title,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'DESCRIPTION',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      service.title,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      service.body,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
