import 'dart:convert';
// import 'dart:math';

import 'package:firebase_prac/view/hr_view.dart';
import 'package:firebase_prac/model/hr_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Allfoods extends StatefulWidget {
  const Allfoods({super.key});

  @override
  State<Allfoods> createState() => _AllfoodState();
}

class _AllfoodState extends State<Allfoods> {
  List<AllCategories>? data;
  List<AllPosts>? info;
  AllFood? foods;

  fetchFood() async {
    var response = await http.get(Uri.parse(
        "https://mapi.trycatchtech.com/v3/healthy_recipes/healthy_recipes_all_data"));
    try {
      if (response.statusCode == 200) {
        foods = AllFood.fromJson(jsonDecode(response.body));
        data = List.from(foods!.allCategories!);
        info = List.from(foods!.allPosts!);
        print(foods);
      }
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  @override
  void initState() {
    fetchFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("HEALTHY BITES"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "List of All Foods",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            info == null
                ? Center(child: CircularProgressIndicator())
                : info!.isEmpty
                    ? Text("No data found")
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.70),
                          itemCount: info!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Foodinfo(post: info![index]),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 30,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: Card(
                                          child: Image.network(
                                              "${info![index].postImage}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      decoration:
                                          BoxDecoration(color: Colors.black),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "Calories - ${info![index].calories}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ));
  }
}
