import 'package:http/http.dart' show Client;

class NewAPIProvider {
  Client client = Client();

  fetchTopIds() {
    final String topIdsUrl =
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty';
    final Uri uri = Uri.parse(topIdsUrl);
    client.get(
      uri,
    );
  }

  fetchItem() {}
}
