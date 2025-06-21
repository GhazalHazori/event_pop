import 'package:flutter/material.dart';

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final List<Map<String, String>> allFollowing = [
    {"name": "Nour Alwan", "subtitle": "Artist"},
    {"name": "David Ali", "subtitle": "Tech Blogger"},
    {"name": "Hala Sami", "subtitle": "UI Designer"},
    {"name": "Mohamed Zain", "subtitle": "Traveler"},
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredFollowing = allFollowing
        .where(
          (f) => f["name"]!.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Following"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search following...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => searchText = value);
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredFollowing.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                final following = filteredFollowing[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.grey[700]),
                  ),
                  title: Text(following["name"]!),
                  subtitle: Text(following["subtitle"]!),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black87,
                    ),
                    child: Text("Unfollow"),
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
