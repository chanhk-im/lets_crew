import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEARCH'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addClub');
              },
              icon: Icon(
                Icons.add,
              ))
        ],
      ),
    );
  }
}