// import 'package:artemis_ui_kit/artemis_ui_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../core/classes/flight_class.dart';
// import '../core/constants/ui.dart';
// import 'AirlineLogo.dart';
//
// class FlightBanner extends StatelessWidget {
//   final Flight flight;
//   const FlightBanner({super.key,required this.flight});
//
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return Material(
//       key: const Key("1"),
//       borderRadius: BorderRadius.circular(5),
//       color: Colors.white,
//       child: Focus(
//         descendantsAreTraversable: false,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(5),
//           splashColor: theme.primaryColor.withOpacity(0.3),
//           onTap: null,
//           child:  Container(
//                   key: Key(flight.al),
//                   padding: const EdgeInsets.symmetric(horizontal: 2),
//                   decoration: BoxDecoration(
//                       // color: Colors.white,
//                       border: Border.all(color: MyColors.veryLightPink),
//                       borderRadius: BorderRadius.circular(5)),
//                   child: SizedBox(
//                       width: 350,
//                       height: 30,
//                       child:  Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 2),
//                                   child: AirlineLogo(flight.al, size: 28, key: const Key("1")),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 const SizedBox(width: 12),
//                                 Text("${flight.from} - ${flight.to}"),
//                                 const SizedBox(width: 12),
//                                 Text(flight.std),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   DateFormat("dd MMM, EEE").format(flight.flightDate),
//                                   style: const TextStyle(fontSize: 12),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Text(flight.getAircraft?.registration ?? ""),
//                                 const Spacer(),
//                               ],
//                             )),
//                 ),
//         ),
//       ),
//     );
//   }
// }
//
