import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:browser/display.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _searchQuery;
  final TextEditingController _searchQueryController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchQuery = '';
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQueryController.text = newQuery;
      _searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            title: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                // suffixIcon: Icon(Icons.search),
              ),
              onChanged: (newQuery) {
                _updateSearchQuery(newQuery);
              },
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  _updateSearchQuery(_searchQueryController.text);
                },
              ),
            ],
          ),
        ),
        body: _searchQuery.isEmpty
            ? const Center(
                child: Text('Please enter a search query'),
              )
            : SearchResultsWidget(query: _searchQuery),
      ),
    );
  }
}
