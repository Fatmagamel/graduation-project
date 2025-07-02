import 'package:flutter/material.dart';
import 'package:lastupdate/loginscreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required String title});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;



  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/images/logo.png',
      title: 'Welcome to Our App',
      description:
      'Discover amazing features and possibilities with our innovative solution.',
    ),
    OnboardingPage(
      image: 'assets/images/logo.png',
      title: 'Easy to Use',
      description:
      'Simple and intuitive interface designed for the best user experience.',
    ),
    OnboardingPage(
      image: 'assets/images/logo.png',
      title: 'Get Started',
      description:
      'Join us today and begin your journey with our powerful platform.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to home screen or handle completion
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child:
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const  BoxDecoration(
             /* gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87],
              ),*/
            ),
        child: Column(
          children: [
            Expanded(
              child: Container(

                child :PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
    )
            ),
           // _buildBottomSection(),
            _buildPageIndicator(),
            _buildNavigationButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Image.asset(page.image, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF10B981)
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget _buildPageIndicator() {
     return Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: List.generate(
        _pages.length,
             (index) => Container(
           margin: const EdgeInsets.symmetric(horizontal: 4),
           width: 8,
           height: 8,
           decoration: BoxDecoration(
             shape: BoxShape.circle,
             color:
             _currentPage == index
                 ? const Color(0xFF10B981)
                 : Colors.grey.withOpacity(0.3),
           ),
         ),
       ),
     );
   }
   Widget _buildNavigationButton() {
     return Padding(
      padding: const EdgeInsets.all(24.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
           if (_currentPage > 0)
             ElevatedButton(
               style: ButtonStyle(

                 backgroundColor: WidgetStateProperty.all(const Color(0xFF10B981)),  // اللون عند التفاعل
                 foregroundColor: WidgetStateProperty.all(Colors.white), // لون النص
                 elevation: WidgetStateProperty.all(5),  // الظل (الإضاءة)
               ),
               onPressed: () {
                 _pageController.previousPage(
                   duration: const Duration(milliseconds: 300),
                   curve: Curves.easeInOut,
                 );
              },

              child: const Text('Back'),
             ),
           const Spacer(),
           ElevatedButton(
             style: ButtonStyle(
               backgroundColor: WidgetStateProperty.all(const Color(0xFF10B981)),  // اللون عند التفاعل
               foregroundColor: WidgetStateProperty.all(Colors.white), // لون النص
               elevation: WidgetStateProperty.all(5),  // الظل (الإضاءة)
             ),

             onPressed: () {
               if (_currentPage < _pages.length - 1) {
                 _pageController.nextPage(
                   duration: const Duration(milliseconds: 300),
                   curve: Curves.easeInOut,
                 );
               } else {
                 
                 // Navigate to the main app or home screen
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(title: " ")));
               }


             },
             child: Text(
               _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
             ),
           ),
         ],
       ),
     );
   }





}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}

