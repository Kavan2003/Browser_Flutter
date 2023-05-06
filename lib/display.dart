import 'package:browser/searchModal.dart';
import 'package:browser/service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultsWidget extends StatelessWidget {
  final String query;

  const SearchResultsWidget({super.key, required this.query});
  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SearchResult>>(
      future: CustomSearchService.search(query),
      builder: (context, snapshot) {
        print(CustomSearchService.search(query));
        if (snapshot.hasData) {
          final List<SearchResult> searchResults = snapshot.data!;

          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final SearchResult searchResult = searchResults[index];

              return ListTile(
                // leading: IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {

                // }),
                title: Text(searchResult.title),
                subtitle: Text(searchResult.snippet),
                onTap: () {
                  _launchUrl(Uri.parse(searchResult.link));
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Failed to load search results' +
              snapshot.error.toString() +
              snapshot.data.toString());
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
