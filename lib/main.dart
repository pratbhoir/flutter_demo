import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MatrimonyApp());
}

// Main App Widget
class MatrimonyApp extends StatelessWidget {
  const MatrimonyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri Lagna',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Lato',
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F),
          primary: const Color(0xFFD32F2F),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontFamily: 'Lato'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: SplashScreen()), // Wrap splash screen with SafeArea
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/otp': (context) => const OtpScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const MainScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit-profile': (context) => const EditProfileHubScreen(),
        '/manage-photos': (context) => const ManagePhotosScreen(),
        '/edit-basic-details': (context) => const EditBasicDetailsScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/chat': (context) => const ChatScreen(),
        '/activity': (context) => const ActivityScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/filter': (context) => const FilterScreen(),
        '/search-results': (context) => const SearchResultsScreen(),
        '/help': (context) => const HelpScreen(),
        '/premium': (context) => const PremiumScreen(),
      },
    );
  }
}

// 1. Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacementNamed('/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD32F2F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.heartHandshake, color: Colors.white, size: 80),
            SizedBox(height: 16),
            Text(
              'Agri Lagna',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Where Hearts Meet in Harmony',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
                color: Color(0xFFE0E0E0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Login Screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Icon(LucideIcons.heartHandshake, color: Color(0xFFD32F2F), size: 64),
              const SizedBox(height: 16),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                  child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFFD32F2F))),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New to Agri Lagna? "),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD32F2F))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 3. Sign Up Screen
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTextField(label: 'Full Name'),
            _buildTextField(label: 'Phone Number', keyboardType: TextInputType.phone),
            _buildTextField(label: 'Password', obscureText: true),
            _buildTextField(label: 'Date of Birth', isDatePicker: true, context: context),
            _buildTextField(label: 'Religion'),
            _buildTextField(label: 'Caste'),
            _buildTextField(label: 'Occupation'),
            _buildTextField(label: 'Highest Education'),
            _buildTextField(label: 'Location'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/otp'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType? keyboardType, bool obscureText = false, bool isDatePicker = false, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: isDatePicker,
        onTap: isDatePicker && context != null ? () async {
          await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          );
        } : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

// OTP Screen
class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Phone Number', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the 4-digit code sent to your phone number.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _buildOtpBox()),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Verify', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox() {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}


// 4. Forgot Password Screen
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your registered phone number to receive a reset code.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildTextField(label: 'Phone Number', keyboardType: TextInputType.phone),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/otp'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Send Reset Code', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType? keyboardType}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Main Screen with Bottom Navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // GlobalKey for controlling the Scaffold
  final GlobalKey<ScaffoldState> _mainScreenKey = GlobalKey<ScaffoldState>();

  // Define the widget options and pass the scaffoldKey to HomeScreen
  static List<Widget> _widgetOptions(GlobalKey<ScaffoldState> mainScreenKey) => <Widget>[
    HomeScreen(mainScreenKey: mainScreenKey), // Pass the scaffold key to HomeScreen
    MessagesScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mainScreenKey, // Assign the global key to the scaffold
      drawer: const AppDrawer(), // AppDrawer
      body: _widgetOptions(_mainScreenKey)[_selectedIndex], // Show the appropriate screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(LucideIcons.house), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.messageCircle), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.chartBar), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFD32F2F),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}


// Home Screen
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> mainScreenKey;

  const HomeScreen({super.key, required this.mainScreenKey}); // Pass the scaffold key

  void _showToast(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> matchProfiles = [
       {'name': 'Anjali Singh, 27', 'details': "5'6\" • Bangalore • Rajput", 'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop', 'work': 'Graphic Designer', 'income': '₹12L+', 'education': 'M.Des', 'imageCount': 3},
       {'name': 'Rohan Verma, 29', 'details': "5'11\" • Delhi • Kshatriya", 'image': 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1887&auto=format&fit=crop', 'work': 'Architect', 'income': '₹15L+', 'education': 'B.Arch', 'imageCount': 5},
       {'name': 'Vikram Rathod, 31', 'details': "6'0\" • Pune • Maratha", 'image': 'https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?q=80&w=1976&auto=format&fit=crop', 'work': 'Doctor', 'income': '₹25L+', 'education': 'MBBS, MD', 'imageCount': 2},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Open the drawer using the global scaffold key
                mainScreenKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD32F2F), width: 2),
                ),
                child: const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=1887&auto=format&fit=crop'),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Agri Lagna',
          style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFD32F2F), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/filter'), icon: const Icon(LucideIcons.funnel)),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/notifications'), icon: const Icon(LucideIcons.bell)),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: matchProfiles.length,
        itemBuilder: (context, index) {
          final profile = matchProfiles[index];
          return MatchCard(
            name: profile['name'],
            details: profile['details'],
            imageUrl: profile['image'],
            work: profile['work'],
            income: profile['income'],
            education: profile['education'],
            imageCount: profile['imageCount'],
            onInterest: () => _showToast(context, 'Interest Sent!'),
            onShortlist: () => _showToast(context, 'Profile Shortlisted!'),
            onChat: () {
              _showToast(context, 'Opening Chat...');
              Navigator.pushNamed(context, '/chat');
            },
          );
        },
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final String name;
  final String details;
  final String imageUrl;
  final String work;
  final String income;
  final String education;
  final int imageCount;
  final VoidCallback onInterest;
  final VoidCallback onShortlist;
  final VoidCallback onChat;

  const MatchCard({
    super.key,
    required this.name,
    required this.details,
    required this.imageUrl,
    required this.work,
    required this.income,
    required this.education,
    required this.imageCount,
    required this.onInterest,
    required this.onShortlist,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text('$imageCount', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    const SizedBox(width: 4),
                    const Icon(LucideIcons.image, color: Colors.white, size: 14),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(details, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  Text('$work • $income', style: const TextStyle(fontSize: 14, color: Colors.white)),
                  Text(education, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(icon: LucideIcons.heart, label: 'Interest', color: Colors.greenAccent, onPressed: onInterest),
                        ActionButton(icon: LucideIcons.star, label: 'Shortlist', color: Colors.yellowAccent, onPressed: onShortlist),
                        ActionButton(icon: LucideIcons.messageCircle, label: 'Chat', color: Colors.blueAccent, onPressed: onChat),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}


// Side Menu (Drawer)
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  color: const Color(0xFFFFF0F0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFD32F2F), width: 2),
                            ),
                            child: const CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=1887&auto=format&fit=crop'),
                            ),
                          ),
                          // const CircleAvatar(
                          //   radius: 30,
                          //   backgroundImage: NetworkImage('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=1887&auto=format&fit=crop'),
                          // ),
                          const SizedBox(width: 16),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Priya Sharma', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 18)),
                              Text('ID: 12345', style: TextStyle(fontSize: 12, color: Colors.black87)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/premium');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: const Text('Upgrade to Premium', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Divider(),
                ListTile(
                  leading: const Icon(LucideIcons.userCog),
                  title: const Text('Edit Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                ),
                ListTile(
                  leading: const Icon(LucideIcons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: const Icon(LucideIcons.circleQuestionMark),
                  title: const Text('Help & Support'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/help');
                  },
                ),
                // const Divider(),  
                ListTile(
                  leading: const Icon(LucideIcons.logOut, color: Color(0xFFD32F2F)),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 5. Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> profileImages = [
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=1887&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1964&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=1961&auto=format&fit=crop'
    ];

    return Scaffold(
      appBar: AppBar(
          title: const Text('Profile', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(color: const Color(0xFFF0F2F5)),
                Positioned(
                  top: 30,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ImageGalleryScreen(imageUrls: profileImages),
                      ));
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: const Color(0xFFD32F2F),
                      child: CircleAvatar(
                        radius: 96,
                        backgroundImage: CachedNetworkImageProvider(profileImages[0]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Column(
                    children: [
                      const Text(
                        'Priya Sharma, 28',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Software Engineer at Google',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD32F2F),
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                      const SizedBox(height: 24),
                      _buildProfileSection(
                        title: 'About Me',
                        content: const Text(
                          "Looking for a compatible partner to share life's beautiful journey. I'm an optimistic and modern individual with a deep respect for traditional values.",
                          style: TextStyle(color: Colors.black54, height: 1.5),
                        ),
                      ),
                      _buildProfileSection(
                        title: 'Basic Details',
                        content: _buildDetailGrid({
                          'Height': "5' 5\"",
                          'Religion': 'Hindu, Brahmin',
                        }),
                      ),
                      _buildProfileSection(
                        title: 'Contact Details',
                        content: _buildDetailGrid({
                          'Email': "priya.s@email.com",
                          'Phone': '9876543210',
                        }),
                      ),
                       _buildProfileSection(
                        title: 'Education & Career',
                        content: _buildDetailGrid({
                          'Highest Education': "M.Tech",
                          'Employed In': 'Private Sector',
                          'Occupation': 'Software Engineer',
                          'Annual Income': '₹20 Lakhs+',
                        }),
                      ),
                      _buildProfileSection(
                        title: 'Family Details',
                        content: _buildDetailGrid({
                          "Father's Occupation": 'Businessman',
                          "Mother's Occupation": 'Homemaker',
                          'Siblings': '1 younger brother',
                          'Family Values': 'Moderate',
                        }),
                      ),
                      _buildProfileSection(
                        title: 'Lifestyle',
                        content: _buildDetailGrid({
                          'Hobbies': "Reading, Hiking",
                          'Sports': 'Badminton',
                        }),
                      ),
                       _buildProfileSection(
                        title: 'Horoscope',
                        content: _buildDetailGrid({
                          'Nakshatra': "Rohini",
                          'Mangal': 'No',
                        }),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection({required String title, required Widget content}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailGrid(Map<String, String> details) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.5),
      },
      children: details.entries.map((entry) {
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(entry.key, style: const TextStyle(color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(entry.value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// Image Gallery Screen
class ImageGalleryScreen extends StatefulWidget {
  final List<String> imageUrls;
  const ImageGalleryScreen({super.key, required this.imageUrls});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.imageUrls.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}


// 6. Edit Profile Hub Screen
class EditProfileHubScreen extends StatelessWidget {
  const EditProfileHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Sections', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildEditCard(context, icon: LucideIcons.circleUserRound, label: 'About Me', route: '/edit-basic-details'),
              _buildEditCard(context, icon: LucideIcons.circleUserRound, label: 'Basic Details', route: '/edit-basic-details'),
              _buildEditCard(context, icon: LucideIcons.graduationCap, label: 'Education', route: '/edit-basic-details'),
              _buildEditCard(context, icon: LucideIcons.briefcase, label: 'Career', route: '/edit-basic-details'),
              _buildEditCard(context, icon: LucideIcons.users, label: 'Family', route: '/edit-basic-details'),
              _buildEditCard(context, icon: LucideIcons.contact, label: 'Contact', route: '/edit-basic-details'),
              _buildEditCard(context, icon: LucideIcons.gem, label: 'Lifestyle', route: '/edit-basic-details'),
              _buildEditCard(context, icon: LucideIcons.sun, label: 'Horoscope', route: '/edit-basic-details'),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, '/manage-photos'),
              leading: const Icon(LucideIcons.image, color: Color(0xFFD32F2F)),
              title: const Text('Manage Photos', style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(LucideIcons.chevronRight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditCard(BuildContext context, {required IconData icon, required String label, required String route}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// Manage Photos Screen
class ManagePhotosScreen extends StatefulWidget {
  const ManagePhotosScreen({super.key});

  @override
  State<ManagePhotosScreen> createState() => _ManagePhotosScreenState();
}

class _ManagePhotosScreenState extends State<ManagePhotosScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Photos', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _selectedImages.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: _pickImages,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!, style: BorderStyle.solid),
                  ),
                  child: const Icon(LucideIcons.plus, color: Colors.grey, size: 40),
                ),
              );
            }
            final image = _selectedImages[index - 1];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(image.path), fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}


// Edit Basic Details Screen
class EditBasicDetailsScreen extends StatelessWidget {
  const EditBasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Details', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTextField(label: 'Name', initialValue: 'Priya Sharma'),
            _buildTextField(label: 'Gender', initialValue: 'Female'),
            _buildTextField(label: 'Caste', initialValue: 'Brahmin'),
            _buildTextField(label: 'City', initialValue: 'Mumbai'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

// 8. Messages Screen
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: const [
          MessageListItem(
            name: 'Rohan Verma',
            message: "That sounds great! Let's talk...",
            time: '10:42 AM',
            imageUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1887&auto=format&fit=crop',
            unreadCount: 2,
          ),
          MessageListItem(
            name: 'Anjali Singh',
            message: 'You: Thanks for accepting my request!',
            time: 'Yesterday',
            imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop',
            unreadCount: 0,
          ),
        ],
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  final int unreadCount;

  const MessageListItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, '/chat'),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: CachedNetworkImageProvider(imageUrl),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          if (unreadCount > 0) ...[
            const SizedBox(height: 4),
            CircleAvatar(
              radius: 10,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// 9. Chat Screen
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    // Mock data representing a JSON array of messages
    const messagesJson = '''
    [
      {"text": "Hey Priya! Thanks for connecting. Your profile looks really interesting.", "isSentByMe": false},
      {"text": "Hi Rohan! Likewise. Happy to connect. How are you doing?", "isSentByMe": true}
    ]
    ''';
    setState(() {
      _messages.addAll(List<Map<String, dynamic>>.from(jsonDecode(messagesJson)));
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({"text": _controller.text.trim(), "isSentByMe": true});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider('https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1887&auto=format&fit=crop'),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rohan Verma', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Online', style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.phone)),
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.video)),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatMessage(
                  text: message['text'],
                  isSentByMe: message['isSentByMe'],
                );
              },
            ),
          ),
          _buildMessageComposer(context),
        ],
      ),
    );
  }

  Widget _buildMessageComposer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(LucideIcons.paperclip, color: Colors.grey),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _sendMessage,
            mini: true,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(LucideIcons.send, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSentByMe;

  const ChatMessage({super.key, required this.text, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? Theme.of(context).primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: isSentByMe ? const Radius.circular(4) : const Radius.circular(20),
            bottomLeft: isSentByMe ? const Radius.circular(20) : const Radius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}


// 10. Activity Screen
class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activity', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Interests Received'),
              Tab(text: 'Interests Sent'),
            ],
            labelColor: Color(0xFFD32F2F),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFFD32F2F),
          ),
        ),
        body: const TabBarView(
          children: [
            InterestList(isReceived: true),
            InterestList(isReceived: false),
          ],
        ),
      ),
    );
  }
}

class InterestList extends StatelessWidget {
  final bool isReceived;
  const InterestList({super.key, required this.isReceived});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        InterestCard(
          name: isReceived ? 'Anjali Singh' : 'Arjun Mehra',
          details: isReceived ? '27, Graphic Designer' : '32, Architect, Delhi',
          imageUrl: isReceived ? 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop' : 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1887&auto=format&fit=crop',
          isReceived: isReceived,
        ),
      ],
    );
  }
}

class InterestCard extends StatelessWidget {
  final String name;
  final String details;
  final String imageUrl;
  final bool isReceived;

  const InterestCard({
    super.key,
    required this.name,
    required this.details,
    required this.imageUrl,
    required this.isReceived,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(details, style: const TextStyle(color: Colors.grey)),
                  if (isReceived) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green[100]), child: Text('Accept', style: TextStyle(color: Colors.green[800]))),
                        const SizedBox(width: 8),
                        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]), child: Text('Decline', style: TextStyle(color: Colors.red[800]))),
                      ],
                    )
                  ] else ... [
                     const SizedBox(height: 8),
                     Text('Awaiting Response', style: TextStyle(color: Colors.orange[700], fontWeight: FontWeight.w500)),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 11. Notifications Screen
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            icon: LucideIcons.heart,
            iconColor: Color(0xFFD32F2F),
            title: 'New Match!',
            subtitle: 'You and Rohan Verma have liked each other.',
            time: '5 minutes ago',
          ),
          NotificationCard(
            icon: LucideIcons.messageSquare,
            iconColor: Colors.blue,
            title: 'New Message from Anjali Singh',
            subtitle: '"Thanks for accepting my request!"',
            time: '2 hours ago',
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: iconColor.withOpacity(0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: iconColor,
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 8),
                  Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 12. Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          _buildSettingsCategory('Account'),
          _buildSettingsItem(context, 'Edit Profile', route: '/edit-profile'),
          _buildSettingsItem(context, 'Change Password'),
          _buildSettingsCategory('Privacy'),
          _buildSettingsSwitch('Show my photo to all'),
          _buildSettingsCategory('Support'),
          _buildSettingsItem(context, 'Help & Support', route: '/help'),
          const SizedBox(height: 40),
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false),
              child: const Text('Logout', style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCategory(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title.toUpperCase(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildSettingsItem(BuildContext context, String title, {String? route}) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(LucideIcons.chevronRight, color: Colors.grey),
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

  Widget _buildSettingsSwitch(String title) {
    return SwitchListTile(
      title: Text(title),
      value: true,
      onChanged: (bool value) {},
      activeColor: const Color(0xFFD32F2F),
    );
  }
}

// Filter Screen
class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Matches', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSectionTitle('Age Range'),
            RangeSlider(values: RangeValues(25, 35), min: 18, max: 60, onChanged: null),
            _buildFilterSectionTitle('Marital Status'),
            _buildFilterChip('Never Married', true),
            _buildFilterChip('Divorced', false),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/search-results'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildFilterSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? const Color(0xFFD32F2F) : Colors.grey[300],
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }
}

// Search Results Screen
class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Results', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: const Center(
        child: Text('Matching profiles will be shown here.'),
      ),
    );
  }
}


// 13. Help & Support Screen
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('FAQs', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildFaqItem('How do I verify my profile?'),
          _buildFaqItem('How can I upgrade my membership?'),
          const SizedBox(height: 24),
          const Text('Contact Us', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(LucideIcons.mail),
            title: const Text('Email Support'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(LucideIcons.phone),
            title: const Text('Call Us'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question) {
    return Card(
      child: ListTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(LucideIcons.chevronRight),
      ),
    );
  }
}


// 14. Premium Screen
class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFDE047), Color(0xFFF0F2F5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Column(
              children: [
                Icon(LucideIcons.gem, color: Color(0xFFB45309), size: 64),
                SizedBox(height: 16),
                Text('Go Premium', style: TextStyle(fontFamily: 'Poppins', fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF78350F))),
                SizedBox(height: 8),
                Text('Unlock exclusive benefits & find your match faster!', style: TextStyle(color: Color(0xFF92400E))),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                PremiumFeatureCard(icon: LucideIcons.send, title: 'Send Unlimited Interests', subtitle: "Don't wait, express your interest freely."),
                PremiumFeatureCard(icon: LucideIcons.phone, title: 'View Contact Details', subtitle: 'Connect with matches directly.'),
                PremiumFeatureCard(icon: LucideIcons.eye, title: 'See Who Viewed Your Profile', subtitle: 'Know who is interested in you.'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFBBF24),
            foregroundColor: const Color(0xFF78350F),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Upgrade for ₹499/month', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }
}

class PremiumFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const PremiumFeatureCard({super.key, required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
