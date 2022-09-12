import 'package:alwan_press/controller/home_controller.dart';
import 'package:alwan_press/helper/app.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/model/start_up.dart';
import 'package:alwan_press/view/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SearchTextField extends SearchDelegate<String> {
  final List<SuggestionSearch> suggestionList;
  String? result;
  HomeController homeController;

  SearchTextField(
      {required this.suggestionList, required this.homeController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? const Visibility(
        child: Text(''),
        visible: false,
      )
          : IconButton(
        icon: const Icon(Icons.search, color: Colors.white,),
        onPressed: () {
          //close(context, query);
          Get.to(()=>SearchPage(query));
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(

      appBarTheme: AppBarTheme(
        color: App.pink,
        elevation: 0,
      ),
      hintColor: Colors.white,
      textTheme: const TextTheme(
        headline6: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = suggestionList.where((name) {
      return name.title.toLowerCase().contains(query.toLowerCase());
    });
    print("query");
    // print(query);
    // Get.to(()=>SearchPage(query));
    homeController.getResult(query);
   // close(context, query);
    return Center(
      child: Text('')
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = suggestionList.where((name) {
      return name.title.toLowerCase().contains(query.toLowerCase());
    });
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/background.png')
                )
            )
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: MyTheme.isDarkTheme.value ? Colors.transparent : Colors.white, //App.pink,
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  suggestions.elementAt(index).title,
                  style: TextStyle(
                      color: MyTheme.isDarkTheme.value ? Colors.white : Colors.black,
                      fontSize: 16
                  ),
                ),
                onTap: () {
                  query = suggestions.elementAt(index).title;
                  Get.to(()=>SearchPage(query));
                  // close(context, query);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
