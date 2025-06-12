import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_search.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_search_event.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/search_view/search_view_controller.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/instance_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    SearchViewController controller=Get.put(SearchViewController());
    return Scaffold(body: Column(children: [
          Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
      child: SvgPicture.asset("assets/images/back.svg"),
    ),
    SizedBox(height: screenHeight(40)),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
      child: Text(
        "Search",
        style: TextStyle(
          color: AppColors.blacktext,
          fontSize: screenWidth(20),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
         Row(
      children: [
    SizedBox(width: screenWidth(1.6),
      child: Expanded( 
        
        child: CustomSearch(
          prefixIcon: Icon(Icons.search,color: AppColors.whitecolor,),
          hint: "| Search",
          
          fillcolor: AppColors.whitecolor,
          hintColor: AppColors.greySign,
        ),
      ),
    ),
    SizedBox(width: screenWidth(5.5)),
    Container(
      width: screenWidth(6),
      height: screenHeight(20),
    
      decoration: BoxDecoration(color: 
       AppColors.bluecolor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          SvgPicture.asset("assets/images/filter.svg"),
       
          Text(
            "Filter",
            style: TextStyle(
              color: AppColors.whitecolor,
              fontSize: screenWidth(25),
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    ),
      ],
    ),
       screenHeight(50).ph,
                 SizedBox(
                                       height: screenHeight(2.9),
                        child: ListView.builder(
                       
                      shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                          itemCount: controller.searcList.length,
                          
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller.searcList[index];
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                              child: InkWell(
                                onTap: () {
                                
                              
                                },
                                child:CustomSearchEvent(image: "gitar", name: "A virtual evening \nof smooth jazz", date: '1st  May- Sat -2:00 PM'),
                              ),
                            );
                          },
                        ),
                      ),
  ],
),
    );
  }
}