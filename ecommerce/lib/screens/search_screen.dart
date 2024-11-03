import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String auth = "NllIUFNURUU4SkRTM0VIQ1NYU0c3QlE1QTU1QUxKSkE6";
List list_name = [];

class _SearchScreenState extends State<SearchScreen> {
  // Sample data list for search results
  final List<String> _allItems = [
    'Laptop',
    'Smartphone',
    'Tablet',
    'Smartwatch',
    'Headphones',
    'Keyboard',
    'Mouse',
    'Monitor',
    'Printer',
    'Camera',
  ];

  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _filterSearchResults(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = _allItems;
    } else {
      results = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: _filterSearchResults,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: _filteredItems.isNotEmpty
          ? ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredItems[index]),
                  onTap: () {
                    // Handle the onTap if necessary (e.g., navigate to product details)
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${_filteredItems[index]} selected'),
                    ));
                  },
                );
              },
            )
          : Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
    );
  }
}
