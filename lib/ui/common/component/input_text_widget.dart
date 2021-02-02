import 'package:flutter/material.dart';
import 'package:mikipo/ui/comun/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputTextWidget extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final IconData iconData;
  final bool isDone;
  final FocusScopeNode node;
  final Function(String) onChanged;
  final String value;
  final String error;
  final bool isPass;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool moveFocusTwice;

  InputTextWidget(
      {Key key,
      @required this.hintText,
      @required this.textInputType,
      @required this.iconData,
      this.isDone = false,
      this.node,
      this.onChanged,
      this.value,
      this.error,
      this.isPass = false,
      this.focusNode,
      this.controller,
      this.moveFocusTwice = false})
      : super(key: key);

  @override
  _InputTextWidgetState createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    FaIcon eyeIconData = null;
    if (widget.isPass) {
      eyeIconData = _obscure
          ? FaIcon(
              FontAwesomeIcons.eyeSlash,
              color: Palette.grey,
            )
          : FaIcon(
              FontAwesomeIcons.eye,
              color: Palette.white,
            );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Material(
        elevation: 4.0,
        color: Palette.ldaColor,
        borderRadius: BorderRadius.circular(25.0),
        child: TextFormField(
          key: ObjectKey(widget.hintText),
          controller: widget.controller,
          initialValue: widget.value,
          enableSuggestions: !widget.isPass,
          autocorrect: false,
          onEditingComplete: () {
            if (widget.node != null) {
              if (!widget.isDone) {
                widget.node.nextFocus();
                if (widget.moveFocusTwice) {
                  widget.node.nextFocus();
                }
              } else {
                widget.node.unfocus();
              }
            }
          },
          onChanged: widget.onChanged,
          textInputAction:
              widget.isDone ? TextInputAction.done : TextInputAction.next,
          style: TextStyle(color: Palette.backgroundColor),
          keyboardType: widget.textInputType,
          maxLines: 1,
          obscureText: _obscure && widget.isPass,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.iconData,
              color: Palette.backgroundColor,
            ),
            suffixIcon: widget.isPass
                ? IconButton(
                    focusColor: Palette.transparent,
                    icon: eyeIconData,
                    onPressed: () {
                      setState(
                        () {
                          _obscure = !_obscure;
                        },
                      );
                    },
                    splashColor: Palette.transparent,
                    hoverColor: Palette.transparent,
                  )
                : null,
            alignLabelWithHint: true,
            labelText: widget.hintText,
            labelStyle: TextStyle(color: Palette.white, height: 0.5),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Palette.white),
            contentPadding: EdgeInsets.all(0.0),
            fillColor: Palette.ldaColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Text(
          widget.error == null ? '' : widget.error,
          style: TextStyle(color: Palette.textErrorColor, fontSize: 10.0),
        ),
      ),
    ]);
  }
}
