import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/all_event_view/all_event_view_controller.dart';
import 'package:flutter_templat/ui/views/saved_events/saved_events_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';

class SavedEventsView extends StatefulWidget {
  const SavedEventsView({super.key});

  @override
  State<SavedEventsView> createState() => _SavedEventsViewState();
}

class _SavedEventsViewState extends State<SavedEventsView> {
  @override
  Widget build(BuildContext context) {
    SavedEventsViewController controller=Get.put(SavedEventsViewController());
    return Scaffold(backgroundColor: AppColors.whitecolor,
      body: Column(
      children: [
        screenHeight(20).ph,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.arrow_back),screenWidth(20).pw,
              Text("All Events",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth(20)),),
            ],
          ),
        ),
   Obx((){
                  return  Expanded(
                    child: SizedBox(
                                         height: screenHeight(2.9),
                          child: ListView.builder(
                         
                        shrinkWrap: true,
                     scrollDirection: Axis.vertical,
                            itemCount: controller.eventsList.length,
                            
                            itemBuilder: (BuildContext context, int index) {
                             
                    
                              
                              return Padding(
                                padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                                child: InkWell(
                                  onTap: () {
                                   
                                   
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: AppColors.whitecolor,  boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // لون الظل
                            blurRadius: 10, // درجة التمويه
                            spreadRadius: 2, // مدى الانتشار
                            offset: const Offset(0, 5), // اتجاه الظل (X=0 , Y=5 يعني لتحت)
                          ),
                        ],),
                                      child: Row(children: [ Container(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20), // هنا درجة التدوير
                                          child: CachedNetworkImage(width: screenWidth(5),height: screenHeight(10),
                                            imageUrl: controller.eventsList[index].image??'',
                                            placeholder: (context, url) => 
                                              SvgPicture.asset("assets/images/placeholder.svg"), // صورة بديلة لوقت التحميل
                                            errorWidget: (context, url, error) =>
                                              Icon(Icons.error, color: Colors.red), // لو صار خطأ
                                         fit: BoxFit.cover,
                                            // حدد الارتفاع اللي بدك ياه
                                          ),
                                        ),
                                    ),Padding(
                                     padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Text("${ controller.eventsList[index].name != null
                          ? (controller.eventsList[index].name!.length > 10
                              ? controller.eventsList[index].name!.substring(0, 10) + '...'
                              : controller.eventsList[index].name!)
                          : ''}",
                      maxLines: 1,style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(25),fontWeight: FontWeight.w500),),
                                   screenHeight(90).ph ,      ],),
                                    )
                                    ],),)
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  );
      })
      ],
    ),);
  }
}