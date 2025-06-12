import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

class CustomButtonGer extends StatefulWidget {
  const CustomButtonGer(
      {super.key, required this.text, this.onTap, this.hight, this.wight});
  final String text;
  final Function? onTap;
  final double? hight;
  final double? wight;
  @override
  State<CustomButtonGer> createState() => _CustomButtonGerState();
}

class _CustomButtonGerState extends State<CustomButtonGer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      child: Container(
        width: widget.wight,
        height: widget.hight,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.98, -0.18),
            end: Alignment(0.98, 0.18),
            colors: [
              // Color(0xFF06A9B2),
              // AppColors.secondaryBlueColorE,
              // AppColors.secondaryBlueColorE,
              // AppColors.mainBlueGreeE,
              // AppColors.mainBlueGreeE,
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: [
            BoxShadow(
              color: AppColors.blacktext,
              blurRadius: 12,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.whitecolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}