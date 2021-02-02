import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mikipo/ui/comun/Login_back.dart';
import 'package:mikipo/ui/comun/colors.dart';

enum Action { initial, logup, login }

class LoginScreen5 extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen5>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _logupTextOpacity = 0;
  double _loginTextOpacity = 0;
  Action _action = Action.initial;
  double _logupLeft = 0;
  double _logupTop = 0;
  double _loginTop = 0;
  double _loginRight = 0;

  bool _showPassInPassField = false;
  bool _showPassInRepeatPassField = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _executeAfterWholeBuildProcess(context));
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    print("LoginScreen.....${hashCode}");
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedAlign(
            duration: Duration(milliseconds: 1000),
            alignment: Alignment.topCenter,
            child: AnimatedOpacity(
              curve: Interval(
                0.7,
                1.0,
                curve: Curves.decelerate,
              ),
              opacity: _logupTextOpacity,
              duration: Duration(milliseconds: 100),
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: AnimatedOpacity(
              curve: Interval(
                0.0,
                0.4,
                curve: Curves.decelerate,
              ),
              opacity: 1 - _logupTextOpacity,
              duration: Duration(milliseconds: 100),
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  'Acceder',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: AnimatedCrossFade(
                duration: Duration(milliseconds: 200),
                firstChild: _buildLogupForm(node, size, _action),
                secondChild: _buildLoginForm(node, size, _action),
                crossFadeState: _action== Action.login ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              ),
            ),
          ),
          _buildActionButton(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  void _swapLogupLogin(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (_action == Action.logup || _action == Action.initial) {
      _action = Action.login;
      _logupLeft = 0;
      _logupTop = 0;
      _loginRight = screenSize.width / 10;
      _loginTop = screenSize.height / 10;
      _animationController.reverse();
      _logupTextOpacity = 0;
    } else {
      _action = Action.logup;
      _logupLeft = screenSize.width / 10;
      _logupTop = screenSize.height / 10;
      _loginRight = 0;
      _loginTop = 0;
      _animationController.forward();
      _logupTextOpacity = 1;
    }

    setState(() {});
  }

  void _executeAfterWholeBuildProcess(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _logupLeft = screenSize.width / 10;
    _logupTop = screenSize.height / 10;
    _animationController.forward();
    _logupTextOpacity = 1;
    setState(() {});
  }

  Color _getLogupBorderColor(bool focused) {
    if (focused) {
      return Palette.black;
    } else {
      return Palette.penelopeColor;
    }
  }

  Color _getLoginBorderColor(bool focused) {
    if (focused) {
      return Palette.black;
    } else {
      return Palette.ldaColor;
    }
  }

  Widget _buildProfileWidget(Action action) {
    if (_action == Action.initial || _action == Action.logup) {
      return Stack(children: [
        CircleAvatar(
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.account_circle_sharp,
            color: Palette.penelopeColor,
            size: 90,
          ),
          radius: 42,
        ),
        Positioned(
          right: 0,
          child: Icon(
            Icons.arrow_circle_up,
            color: Palette.penelopeColor,
          ),
        ),
      ]);
    } else {
      return CircleAvatar(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.account_circle_sharp,
          color: Palette.ldaColor,
          size: 90,
        ),
        radius: 42,
      );
    }
  }

  Widget _buildLogupForm(FocusScopeNode node, Size size, Action action) {

    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height / 13,
        ),
        _buildProfileWidget(action),
        SizedBox(
          height: 100,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            node.nextFocus();
          },
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.alternate_email),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.amber),
            hintText: 'Email',
            labelText: 'Email',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLogupBorderColor(false),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLogupBorderColor(true),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            node.nextFocus();
            node.nextFocus();
          },
          keyboardType: TextInputType.number,
          maxLines: 1,
          obscureText: _showPassInPassField,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _showPassInPassField = !_showPassInPassField;
                });
              },
            ),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.amber),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLogupBorderColor(false),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLogupBorderColor(true),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          onFieldSubmitted: (_) => node.unfocus(),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLines: 1,
          obscureText: _showPassInRepeatPassField,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _showPassInRepeatPassField = !_showPassInRepeatPassField;
                });
              },
            ),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.amber),
            hintText: 'Confirmar contraseña',
            labelText: 'Confirmar contraseña',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLogupBorderColor(false),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLogupBorderColor(true),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.transparent,
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              onChanged: (value) {},
              value: 'Desarrollo',
              items: <String>['Desarrollo', 'Arquitectura', 'Telecom', 'BI', 'Oficina Tecnica']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(FocusScopeNode node, Size size, Action action) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height / 13,
        ),
        _buildProfileWidget(action),
        SizedBox(
          height: 100,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            node.nextFocus();
          },
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.alternate_email, color: Palette.penelopeColor,),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Palette.penelopeColor),
            hintText: 'Email',
            labelText: 'Email',
            labelStyle: TextStyle(color: Palette.penelopeColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLoginBorderColor(false),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLoginBorderColor(true),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            node.nextFocus();
            node.nextFocus();
          },
          keyboardType: TextInputType.number,
          maxLines: 1,
          obscureText: _showPassInPassField,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _showPassInPassField = !_showPassInPassField;
                });
              },
            ),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Palette.penelopeColor),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            labelStyle: TextStyle(color: Palette.penelopeColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLoginBorderColor(false),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: _getLoginBorderColor(true),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _keyboardIsVisible(BuildContext context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  _buildActionButton(BuildContext context) {
      return Positioned(
        bottom: 50,
        child: FlatButton(
          onPressed: () {
            _swapLogupLogin(context);
          },
          child: Center(
            child: Text(_action == Action.login ? 'Acceder' : 'Registrarse',
            style: TextStyle(color: _keyboardIsVisible(context) ? Colors.transparent : Colors.black),),
          ),
        ),
      );
    }

}
