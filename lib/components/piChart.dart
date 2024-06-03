// import 'material'



// class MyPieChart extends StatefulWidget {
//   final int value1, value2, value3, value4, value5, value6;

//   const MyPieChart({
//     Key? key,
//     required this.value1,
//     required this.value2,
//     required this.value3,
//     required this.value4,
//     required this.value5,
//     required this.value6,
//   }) : super(key: key);

//   @override
//   _MyPieChartState createState() => _MyPieChartState();
// }

// class _MyPieChartState extends State<MyPieChart> {
//   @override
//   Widget build(BuildContext context) {
//     return PieChart(
//       PieChartData(
//           centerSpaceRadius: 50,
//           sectionsSpace: 0, // No gaps between sections
//           sections: [
//             PieChartSectionData(
//               color: Colors.red,
//               value: widget.value1.toDouble(),
//               title: '${widget.value1}%',
//               radius: 50,
//               titleStyle: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             PieChartSectionData(
//               color: Colors.green,
//               value: widget.value2.toDouble(),
//               title: '${widget.value2}%',
//               radius: 50,
//               titleStyle: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             PieChartSectionData(
//               color: Colors.blue,
//               value: widget.value3.toDouble(),
//               title: '${widget.value3}%',
//               radius: 50,
//               titleStyle: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             PieChartSectionData(
//               color: Colors.yellow,
//               value: widget.value4.toDouble(),
//               title: '${widget.value4}%',
//               radius: 50,
//               titleStyle: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             PieChartSectionData(
//               color: Colors.purple,
//               value: widget.value5.toDouble(),
//               title: '${widget.value5}%',
//               radius: 50,
//               titleStyle: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             PieChartSectionData(
//               color: Colors.orange,
//               value: widget.value6.toDouble(),
//               title: '${widget.value6}%',
//               radius: 50,
//               titleStyle: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//           ]),
//     );
//   }
// }
