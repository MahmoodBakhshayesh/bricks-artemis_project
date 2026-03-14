import 'package:flutter/material.dart';
import 'presentation/flights_view.desktop.dart';
import 'presentation/flights_view.phone.dart';
import 'presentation/flights_view.tablet.dart';

/// The main entry point for the Flights feature's UI.
///
/// This widget is responsible for handling responsiveness. It determines the
/// screen size and delegates the UI rendering to the appropriate
/// screen-specific layout (e.g., phone, tablet, or desktop).
class FlightsView extends StatelessWidget {
  const FlightsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const FlightsViewPhone();
        } else if (constraints.maxWidth < 1200) {
          return const FlightsViewTablet();
        } else {
          return const FlightsViewDesktop();
        }
      },
    );
  }
}
