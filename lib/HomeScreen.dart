import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<StoryData> stories = [
    StoryData(
        username: 'User 1',
        imagePath: 'assets/images/avatar1.png',
        hasStory: true),
    StoryData(
        username: 'User 2',
        imagePath: 'assets/images/avatar2.jpg',
        hasStory: true),
    StoryData(
        username: 'User 3',
        imagePath: 'assets/images/avatar3.jpg',
        hasStory: true),
  ];

  final List<PostData> posts = [
    PostData(
      username: 'Ola Max',
      userImage: 'assets/images/ola.jpg',
      postImage: 'assets/images/sky.jpg',
      timeAgo: '10 mins ago',
      likes: 90,
      comments: 3,
      shares: 10,
    ),
    PostData(
      username: 'Ola Max',
      userImage: 'assets/images/ola.jpg',
      postImage: 'assets/images/sky.jpg',
      timeAgo: '10 mins ago',
      likes: 90,
      comments: 3,
      shares: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              const Color(0xFF4A1818),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildStories(),
              Expanded(
                child: _buildPosts(),
              ),
              _buildBottomNavigation(),
            ],
          ),
        ),
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
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1), // لون الظل
                  offset: Offset(4, 4), // اتجاه الظل (أفقي، رأسي)
                  blurRadius: 15, // درجة الضباب (نعومة الظل)
                  spreadRadius: 2, // مدى انتشار الظل
                ),
              ],

            ),
            child: const Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStories() {
    return Container(
      height: 100,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
      margin: const EdgeInsets.only(right: 16),
      width: 80,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFDF0FF), // لون الظل
            offset: Offset(0, 2), // اتجاه الظل (أفقي، رأسي)
            blurRadius: 4, // درجة الضباب (نعومة الظل)
            spreadRadius: 0, // مدى انتشار الظل

          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          size: 45,
          color: Colors.black,
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
        margin: const EdgeInsets.only(right: 16),
        width: 70,
        child: Column(
          children: [
            Container(
              width: 86,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: story.hasStory ? Colors.blue : Colors.grey,
                  width: 1,
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

  Widget _buildPosts() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(posts[index]);
      },
    );
  }

  Widget _buildPostCard(PostData post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.person, 'Profile', true),
          _buildNavItem(Icons.sports_motorsports, 'Helmet', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
      ],
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
