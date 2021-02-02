import 'package:flutter/material.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class HolidaysScreen extends StatefulWidget {

  static final _logger= getLogger((HolidaysScreen).toString());

  @override
  _HolidaysScreenState createState() => _HolidaysScreenState();
}

class _HolidaysScreenState extends State<HolidaysScreen> {

  static final _logger= getLogger((_HolidaysScreenState).toString());

  @override
  Widget build(BuildContext context) {
    HolidaysScreen._logger.d('build...');
    return Center(
      child: Text('Pantalla de vacaciones'),
    );
  }

  @override
  void initState() {
    super.initState();
    _logger.d('initState...');
  }

  @override
  void dispose() {
    _logger.d('dispose...');
    super.dispose();
  }
}
