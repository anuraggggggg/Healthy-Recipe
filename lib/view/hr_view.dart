import 'package:firebase_prac/model/hr_model.dart';
import 'package:flutter/material.dart';



// ignore: must_be_immutable
class Foodinfo extends StatefulWidget {
  AllPosts post;
  Foodinfo({required this.post, super.key});

  // List <AllPosts>?  ofFood;

  @override
  State<Foodinfo> createState() => _FoodinfoState();
}

class _FoodinfoState extends State<Foodinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 30,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.network(widget.post.postImage!)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Ingredients",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(widget.post.ingredients!),
              SizedBox(
                height: 20,
              ),
              Text(
                "Methods",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(widget.post.methods!)
            ],
          ),
        ),
      ),
    );
  }
}
