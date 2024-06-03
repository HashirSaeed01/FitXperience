import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';

class RadialProgressIndicator extends StatefulWidget {
  final double attribute1Percentage;
  final double attribute2Percentage;
  final double attribute3Percentage;

  RadialProgressIndicator({
    this.attribute1Percentage = 20,
    this.attribute2Percentage = 40,
    this.attribute3Percentage = 40,
  });

  @override
  State<RadialProgressIndicator> createState() =>
      _RadialProgressIndicatorState();
}

class _RadialProgressIndicatorState extends State<RadialProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
      holeRadius: 10,
      // edgeStyle: SegmentEdgeStyle.round,
      size: Size(150.0, 130.0),
      initialChartData: <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
              widget.attribute1Percentage,
              Colors.red,
              rankKey: 'attribute1',
            ),
            CircularSegmentEntry(
              widget.attribute2Percentage,
              Colors.blue,
              rankKey: 'attribute2',
            ),
            CircularSegmentEntry(
              widget.attribute3Percentage,
              Colors.purple,
              rankKey: 'attribute3',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Pie,
      percentageValues: true,
      holeLabel: '',
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    );
  }
}
