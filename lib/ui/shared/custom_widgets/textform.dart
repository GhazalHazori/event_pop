import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

class TextForm extends StatefulWidget {
  const TextForm({
    super.key,
    required this.hinttext,
    this.hintfontsize,
    required this.textfieldhintcolor,
    required this.texteditingcontroller,
    this.validator, this.prefixIcon, this.suffixIcon,
  });
  final String hinttext;
  final TextEditingController texteditingcontroller;
  final double? hintfontsize;
  final Color? textfieldhintcolor;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
 final Icon? suffixIcon;
  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextFormField(
        
        validator: widget.validator,
        controller: widget.texteditingcontroller,
        decoration: InputDecoration(
          
          errorStyle: TextStyle(color: AppColors.bluecolor),
          fillColor: AppColors.whitecolor,
          filled: true,
          prefixIcon:widget.prefixIcon ,
          suffixIcon: widget.suffixIcon,

          hintText: widget.hinttext,
          hintStyle: TextStyle(
              color: AppColors.greycolor.withOpacity(0.5),
              fontSize: widget.hintfontsize ?? size.width * 0.04),
          border: OutlineInputBorder(
            
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.greySign.withOpacity(0.5))),
        ),
      ),
    );
  }
}
