import 'package:flutter/material.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class AbsencesScreen extends StatefulWidget {

  static final _logger= getLogger((AbsencesScreen).toString());

  @override
  _AbsencesScreenState createState() => _AbsencesScreenState();
}

class _AbsencesScreenState extends State<AbsencesScreen> {

  static final _logger= getLogger((_AbsencesScreenState).toString());

  @override
  Widget build(BuildContext context) {
    AbsencesScreen._logger.d('build...');
    return Center(
      child: Text('Pantalla de ausencias'),
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
