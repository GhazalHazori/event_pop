import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';

class CustomEvent extends StatefulWidget {
  const CustomEvent(
      {super.key,
      required this.imagename,
      required this.location,
      required this.eventname,
      required this.going,
      required this.date,
      this.id});

  final String imagename;
  final String location;
  final String eventname;
  final String going;
  final String date;
  final int? id;

  @override
  State<CustomEvent> createState() => _CustomEventState();
}

class _CustomEventState extends State<CustomEvent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    if (_isSaved) {
      _controller.forward();
      EventRepository().saveEvent(id: widget.id!);
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(1.4),
      decoration: BoxDecoration(
        color: AppColors.whitecolor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.greySign.withOpacity(0.3))
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الحدث
          Stack(
            children: [
              // صورة الحدث
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.imagename,
                  placeholder: (context, url) => Container(
                    height: screenHeight(5),
                    color: Colors.grey[200],
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/placeholder.svg",
                        width: screenWidth(8),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: screenHeight(5),
                    color: Colors.grey[200],
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                  fit: BoxFit.cover,
                  height: screenHeight(5),
                  width: double.infinity,
                ),
              ),

              // تاريخ الحدث
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(40),
                    vertical: screenHeight(120),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whitecolor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.date,
                    style: TextStyle(
                      color: AppColors.orangColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(25),
                      fontFamily: 'Tajawal',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // زر الحفظ
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: _toggleSave,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(screenWidth(40)),
                    decoration: BoxDecoration(
                      color: AppColors.whitecolor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _isSaved
                          ? Icon(
                              Icons.bookmark,
                              color: AppColors.bluecolor,
                              size: screenWidth(20),
                              key: const ValueKey('saved'),
                            )
                          : SvgPicture.asset(
                              "assets/images/save.svg",
                              width: screenWidth(20),
                              color: Colors.grey[600],
                              key: const ValueKey('unsaved'),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // معلومات الحدث
          Padding(
            padding: EdgeInsets.all(screenWidth(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم الحدث
                Text(
                  widget.eventname,
                  style: TextStyle(
                    color: AppColors.blacktext,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth(18),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: screenHeight(60)),

                // عدد الحضور
                Text(
                  widget.going,
                  style: TextStyle(
                    color: AppColors.bluecolor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Tajawal',
                    fontSize: screenWidth(22),
                  ),
                ),

                SizedBox(height: screenHeight(80)),

                // الموقع
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/location.svg",
                      width: screenWidth(25),
                      // color: Colors.grey[600],
                    ),
                    SizedBox(width: screenWidth(40)),
                    Expanded(
                      child: Text(
                        widget.location,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: screenWidth(23),
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
