import 'package:flutter/material.dart';
import 'package:flutter_templat/core/translation/app_traslation.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch(
      {super.key,
      this.prefixIcon,
      this.suffixIcon,
      required this.hint,
      required this.fillcolor,
      required this.hintColor,
      this.borderRadius});
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String hint;
  final Color fillcolor;
  final Color hintColor;
  final double? borderRadius;

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(

          // prefixIcon: widget.prefixIcon,suffixIcon: widget.suffixIcon,hint:Text (widget.hint),hintStyle: TextStyle(color: widget.hintColor,),fillColor: widget.fillcolor
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
              borderSide: BorderSide.none)),
    );
  }
}
