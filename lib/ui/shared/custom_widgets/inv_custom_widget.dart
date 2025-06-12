import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/friend_item.dart';

class InviteFriendsBottomSheet extends StatefulWidget {
  @override
  _InviteFriendsBottomSheetState createState() =>
      _InviteFriendsBottomSheetState();
}

class _InviteFriendsBottomSheetState extends State<InviteFriendsBottomSheet> {
  final List<Map<String, dynamic>> friends = [
    {'name': 'Alex Lee', 'followers': '2k'},
    {'name': 'Micheal Ulasi', 'followers': '56'},
    {'name': 'Cristofer', 'followers': '300'},
    {'name': 'David Silbia', 'followers': '5k'},
    {'name': 'Ashfak Sayem', 'followers': '402'},
    {'name': 'Rocks Velkeinjen', 'followers': '893'},
    {'name': 'Roman Kutepov', 'followers': '225'},
    {'name': 'Nora Zahra', 'followers': '1.2k'},
    {'name': 'Liam Johnson', 'followers': '950'},
    {'name': 'Emma Grace', 'followers': '3.4k'},
    {'name': 'Oliver Stone', 'followers': '1.1k'},
    {'name': 'Sofia James', 'followers': '688'},
    {'name': 'Lucas Black', 'followers': '2.9k'},
    {'name': 'Mia Khalid', 'followers': '799'},
    {'name': 'Ethan Pierce', 'followers': '5.6k'},
    {'name': 'Ava Summers', 'followers': '1.5k'},
    {'name': 'Noah King', 'followers': '740'},
    {'name': 'Isabella Queen', 'followers': '4.3k'},
    {'name': 'Mason Walker', 'followers': '2.3k'},
    {'name': 'Sophia Star', 'followers': '870'},
  ];

  List<int> selectedIndexes = [0, 2, 4, 6, 8, 10];
  List<Map<String, dynamic>> filteredFriends = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredFriends = friends;
    searchController.addListener(_filterFriends);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterFriends() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredFriends = friends;
      } else {
        filteredFriends = friends
            .where(
              (friend) => friend['name'].toString().toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          const Text(
            "Invite Friend",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Selected count indicator
          if (selectedIndexes.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF5A6CEA).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${selectedIndexes.length} friends selected',
                style: const TextStyle(
                  color: Color(0xFF5A6CEA),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Friends List
          Expanded(
            child: ListView.builder(
              itemCount: filteredFriends.length,
              itemBuilder: (context, index) {
                final friend = filteredFriends[index];
                final originalIndex = friends.indexOf(friend);
                return FriendItem(
                  name: friend['name'],
                  followers: friend['followers'],
                  isSelected: selectedIndexes.contains(originalIndex),
                  onTap: () {
                    setState(() {
                      if (selectedIndexes.contains(originalIndex)) {
                        selectedIndexes.remove(originalIndex);
                      } else {
                        selectedIndexes.add(originalIndex);
                      }
                    });
                  },
                );
              },
            ),
          ),

          // Bottom Section with Invite Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: selectedIndexes.isEmpty
                        ? null
                        : () {
                            _inviteSelectedFriends();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A6CEA),
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedIndexes.isEmpty
                              ? "SELECT FRIENDS TO INVITE"
                              : "INVITE ${selectedIndexes.length} FRIENDS",
                          style: TextStyle(
                            color: selectedIndexes.isEmpty
                                ? Colors.grey[600]
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 16,
                          ),
                        ),
                        if (selectedIndexes.isNotEmpty) ...[
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _inviteSelectedFriends() {
    final selectedFriends =
        selectedIndexes.map((index) => friends[index]['name']).toList();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم دعوة ${selectedFriends.length} من الأصدقاء بنجاح!',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF5A6CEA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.pop(context);
  }
}

void showInviteFriendsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => InviteFriendsBottomSheet(),
  );
}
