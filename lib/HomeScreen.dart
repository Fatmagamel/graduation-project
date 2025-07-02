import 'package:flutter/material.dart';
import 'package:lastupdate/profileScreen.dart';

import 'HelmetScreen.dart';
import 'emergency contacts.dart';
import 'notifications.dart' show NotificationsPage;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<StoryData> stories = [
    StoryData(username: 'User 1', imagePath: 'assets/images/avatar1.png', hasStory: true),
    StoryData(username: 'User 2', imagePath: 'assets/images/avatar2.png', hasStory: true),
    StoryData(username: 'User 3', imagePath: 'assets/images/avatar3.png', hasStory: true),
    StoryData(username: 'User 4', imagePath: 'assets/images/avatar4.png', hasStory: false),
    StoryData(username: 'User 5', imagePath: 'assets/images/avatar5.png', hasStory: true),
  ];

  final List<PostData> posts = [
    PostData(
      username: 'Ola Max',
      userImage: 'assets/images/ola.png',
      postImage: 'assets/images/sky.png',
      timeAgo: '10 mins ago',
      likes: 90,
      comments: 3,
      shares: 10,
    ),
    PostData(
      username: 'Ola Max',
      userImage: 'assets/images/ola.png',
      postImage: 'assets/images/sky.png',
      timeAgo: '10 mins ago',
      likes: 90,
      comments: 3,
      shares: 10,
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: [
                    _buildMainFeed(),
                    const ProfileScreen(title: '',),

                    const HelmetScreen(title: '',),

                  ],
                ),
              ),
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainFeed() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildHeader(),
          _buildStories(),
          _buildEmergencyQuickAccess(),
          ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return _buildPostCard(posts[index]);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good morning, Maria!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@maria_looper',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_active_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
            )
          ),


        //const Spacer(),

    const SizedBox(width: 12),
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const EmergencyContactsScreen(),
    ),
    );
    },
    child: Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
    color: Colors.red.withOpacity(0.2),
    shape: BoxShape.circle,
    border: Border.all(
    color: Colors.red.withOpacity(0.5),
    width: 1,
    ),
    ),
    child: const Icon(
    Icons.contact_emergency,
    color: Colors.red,
    size: 20,
    ),
    ),
    ),

        ],
      ),
    );
  }

  Widget _buildStories() {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: stories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddStoryButton();
          }
          final story = stories[index - 1];
          return _buildStoryItem(story);
        },
      ),
    );
  }

  Widget _buildAddStoryButton() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child:Container(
       // margin: const EdgeInsets.only(right: 12),
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child:  const Center(
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.black,
        ),
      ),
      ),
    );
  }

  Widget _buildStoryItem(StoryData story) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement story view
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 86,
        height: 78,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: story.hasStory ? Colors.blue : Colors.grey,
                  width: 2,
                ),
                image: DecorationImage(
                  image: AssetImage(story.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              story.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }




  Widget _buildEmergencyQuickAccess() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.3),
            Colors.red.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.contact_emergency,
              color: Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergency Contacts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Quick access to emergency services',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmergencyContactsScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Manage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPostCard(PostData post) {
    return Container(
      width: 327,
      height: 340,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // لون الظل
            offset: const Offset(0, 4), // اتجاه الظل (أفقي، رأسي)
            blurRadius: 10, // درجة الضباب (نعومة الظل)
            spreadRadius: 2, // مدى انتشار الظل
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(post.userImage),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      post.timeAgo,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.more_vert,
                  color: Colors.white.withOpacity(0.7),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                post.isLiked = true;
                post.likes++;
              });
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(post.postImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInteractionButton(
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  post.likes.toString(),
                  post.isLiked ? Colors.red : Colors.white,
                      () {
                    setState(() {
                      post.isLiked = !post.isLiked;
                      post.likes += post.isLiked ? 1 : -1;
                    });
                  },
                ),
                _buildInteractionButton(
                  Icons.chat_bubble_outline,
                  post.comments.toString(),
                  Colors.white,
                      () {
                    // TODO: Show comments dialog
                  },
                ),
                _buildInteractionButton(
                  Icons.share,
                  post.shares.toString(),
                  Colors.white,
                      () {
                    // TODO: Implement share functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton(
      IconData icon,
      String count,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                Icons.person_outline,
                'Profile',
                _currentIndex == 1,
                1,
                color: const Color(0xFF10B981),
              ),
              const SizedBox(width: 60),
              _buildNavItem(
                Icons.sports_motorsports,
                'Helmet',
                _currentIndex == 2,
                2,
                color: const Color(0xFF10B981),
              ),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              child: Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: _currentIndex == 0
                      ? const Color(0xFF10B981)
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: _currentIndex == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      String label,
      bool isSelected,
      int index, {
        Color color = Colors.white,
      }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color:
          isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.white.withOpacity(0.5),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.white.withOpacity(0.5),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class StoryData {
  final String username;
  final String imagePath;
  final bool hasStory;

  StoryData({
    required this.username,
    required this.imagePath,
    required this.hasStory,
  });
}

class PostData {
  final String username;
  final String userImage;
  final String postImage;
  final String timeAgo;
  int likes;
  final int comments;
  final int shares;
  bool isLiked;

  PostData({
    required this.username,
    required this.userImage,
    required this.postImage,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
  });
}