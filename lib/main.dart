import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UtilityProvider()),
        ],
        child: App(),
      ),
    );
