import 'package:cloud_9_agent/provider/utility_provider.dart';

// import 'package:cloud_9_agent/screens/categories_screen.dart';
import 'package:cloud_9_agent/screens/procedure_sreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);

    return Stack(
      children: <Widget>[
        //  CategoriesScreen(),
        Transform(
            transform: Matrix4.identity(),
            alignment: Alignment.centerLeft,
            child: ProcedureScreen())
      ],
    );
  }
}
