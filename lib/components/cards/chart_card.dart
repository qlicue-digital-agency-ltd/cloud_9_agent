import 'package:bezier_chart/bezier_chart.dart';
import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartCard extends StatelessWidget {
  final fromDate = DateTime(2020, 01, 01);

  final toDate = DateTime(2021, 12, 30);

  final date1 = DateTime.now().add(Duration(days: 2));
  final date2 = DateTime.now().add(Duration(days: 3));

  final date3 = DateTime.now().add(Duration(days: 35));
  final date4 = DateTime.now().add(Duration(days: 36));

  final date5 = DateTime.now().add(Duration(days: 65));
  final date6 = DateTime.now().add(Duration(days: 64));
  final date7 = DateTime.now().add(Duration(days: 70));
  final date8 = DateTime.now().add(Duration(days: 82));

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _dataCustomer = [
      DataPoint<DateTime>(value: 10, xAxis: date1),
      DataPoint<DateTime>(value: 130, xAxis: date2),
      DataPoint<DateTime>(value: 50, xAxis: date3),
      DataPoint<DateTime>(value: 150, xAxis: date4),
      DataPoint<DateTime>(value: 75, xAxis: date5),
      DataPoint<DateTime>(value: 0, xAxis: date6),
      DataPoint<DateTime>(value: 5, xAxis: date7),
      DataPoint<DateTime>(value: 45, xAxis: date8),
    ];

    final _dataTransaction = [
      DataPoint<DateTime>(value: 33, xAxis: date1),
      DataPoint<DateTime>(value: 10, xAxis: date2),
      DataPoint<DateTime>(value: 50, xAxis: date3),
      DataPoint<DateTime>(value: 40, xAxis: date4),
      DataPoint<DateTime>(value: 75, xAxis: date5),
      DataPoint<DateTime>(value: 60, xAxis: date6),
      DataPoint<DateTime>(value: 55, xAxis: date7),
      DataPoint<DateTime>(value: 12, xAxis: date8),
    ];
    final _dataBooking = [
      DataPoint<DateTime>(value: 20, xAxis: date1),
      DataPoint<DateTime>(value: 40, xAxis: date2),
      DataPoint<DateTime>(value: 50, xAxis: date3),
      DataPoint<DateTime>(value: 90, xAxis: date4),
      DataPoint<DateTime>(value: 43, xAxis: date5),
      DataPoint<DateTime>(value: 23, xAxis: date6),
      DataPoint<DateTime>(value: 50, xAxis: date7),
      DataPoint<DateTime>(value: 45, xAxis: date8),
    ];
    return Card(
      child: Center(
        child: Container(
          color: Colors.blue,
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width * 0.9,
          child: BezierChart(
            bezierChartScale: BezierChartScale.MONTHLY,
            fromDate: fromDate,
            toDate: toDate,
            selectedDate: toDate,
            series: [
              BezierLine(
                label: _utilityProvider.chartDropdownValue == "Customer"
                    ? 'Customers'
                    : (_utilityProvider.chartDropdownValue == "Transactions"
                        ? "Transactions"
                        : "Bookings"),
                data: _utilityProvider.chartDropdownValue == "Customer"
                    ? _dataCustomer
                    : (_utilityProvider.chartDropdownValue == "Transactions"
                        ? _dataTransaction
                        : _dataBooking),
              ),
            ],
            config: BezierChartConfig(
              verticalIndicatorStrokeWidth: 3.0,
              verticalIndicatorColor: Colors.black26,
              showVerticalIndicator: true,
              verticalIndicatorFixedPosition: false,
              backgroundColor: Colors.blue,
              snap: false,
            ),
          ),
        ),
      ),
    );
  }
}
