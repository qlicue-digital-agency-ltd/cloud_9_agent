import 'package:cloud_9_agent/provider/auth_provider.dart';
import 'package:cloud_9_agent/provider/client_provider.dart';
import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:cloud_9_agent/provider/product_provider.dart';
import 'package:cloud_9_agent/provider/order_provider.dart';
import 'package:cloud_9_agent/provider/appointment_provider.dart';
import 'package:cloud_9_agent/provider/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App.dart';

void main() =>
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
//          ChangeNotifierProvider(create: (_) => UtilityProvider()),
          ChangeNotifierProxyProvider<AuthProvider, UtilityProvider>(
            create: (_) => UtilityProvider(),
            update: (_, AuthProvider authProvider,
                UtilityProvider utilityProvider) => utilityProvider
              ..update(authProvider)
          ),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => ServiceProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),

          ChangeNotifierProxyProvider<AuthProvider, ClientProvider>(
              create: (_) => ClientProvider(),
              update: (_, AuthProvider authProvider,
                  ClientProvider clientProvider) => clientProvider
                ..update(authProvider)
          ),
          ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
              create: (_) => OrderProvider(),
              update: (_, AuthProvider authProvider,
                  OrderProvider orderProvider) => orderProvider
                ..update(authProvider)
          ),
          ChangeNotifierProxyProvider<AuthProvider, AppointmentProvider>(
              create: (_) => AppointmentProvider(),
              update: (_, AuthProvider authProvider,
                  AppointmentProvider appointmentProvider) => appointmentProvider
                ..update(authProvider)
          )

        ],
        child: App(),
      ),
    );
