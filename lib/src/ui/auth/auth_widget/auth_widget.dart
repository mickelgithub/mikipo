import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/auth/auth_widget/viewmodel/auth_view_model.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class AuthWidget extends StatefulWidget {

  static final _logger = getLogger('AuthWidget');

  final AuthViewModel viewModel;

  const AuthWidget({this.viewModel});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {

  AuthViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
