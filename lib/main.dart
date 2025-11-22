import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart'; // REQUIRED: Add lottie to pubspec.yaml

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const QuoteApp());
}

// ---------------------------------------------------------------------------
// DOMAIN LAYER (Model)
// ---------------------------------------------------------------------------

class Quote {
  final String text;
  final String author;

  const Quote({required this.text, required this.author});
}

// ---------------------------------------------------------------------------
// DATA LAYER (Repository)
// ---------------------------------------------------------------------------

class QuoteRepository {
  static final List<Quote> _quotes = [
    const Quote(
      text: "The only way to do great work is to love what you do.",
      author: "Steve Jobs",
    ),
    const Quote(
      text: "Life is what happens when you're busy making other plans.",
      author: "John Lennon",
    ),
    const Quote(
      text:
          "The future belongs to those who believe in the beauty of their dreams.",
      author: "Eleanor Roosevelt",
    ),
    const Quote(
      text: "It does not matter how slowly you go as long as you do not stop.",
      author: "Confucius",
    ),
    const Quote(
      text:
          "In the end, it's not the years in your life that count. It's the life in your years.",
      author: "Abraham Lincoln",
    ),
    const Quote(
      text: "The purpose of our lives is to be happy.",
      author: "Dalai Lama",
    ),
    const Quote(
      text: "Get busy living or get busy dying.",
      author: "Stephen King",
    ),
    const Quote(
      text: "You only live once, but if you do it right, once is enough.",
      author: "Mae West",
    ),
    const Quote(
      text:
          "Many of life's failures are people who did not realize how close they were to success when they gave up.",
      author: "Thomas A. Edison",
    ),
    const Quote(
      text:
          "If you want to live a happy life, tie it to a goal, not to people or things.",
      author: "Albert Einstein",
    ),
    const Quote(
      text:
          "Money and success don’t change people; they merely amplify what is already there.",
      author: "Will Smith",
    ),
    const Quote(
      text:
          "Your time is limited, so don’t waste it living someone else’s life.",
      author: "Steve Jobs",
    ),
    const Quote(
      text: "Not how long, but how well you have lived is the main thing.",
      author: "Seneca",
    ),
    const Quote(
      text:
          "If life were predictable it would cease to be life, and be without flavor.",
      author: "Eleanor Roosevelt",
    ),
    const Quote(
      text:
          "The whole secret of a successful life is to find out what is one’s destiny to do, and then do it.",
      author: "Henry Ford",
    ),
    const Quote(
      text: "Be yourself; everyone else is already taken.",
      author: "Oscar Wilde",
    ),
    const Quote(
      text:
          "Success is not final, failure is not fatal: It is the courage to continue that counts.",
      author: "Winston Churchill",
    ),
    const Quote(
      text:
          "I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel.",
      author: "Maya Angelou",
    ),
    const Quote(
      text: "You miss 100% of the shots you don't take.",
      author: "Wayne Gretzky",
    ),
    const Quote(
      text: "The best way to predict the future is to create it.",
      author: "Peter Drucker",
    ),
    const Quote(
      text: "It is never too late to be what you might have been.",
      author: "George Eliot",
    ),
    const Quote(
      text: "Everything you can imagine is real.",
      author: "Pablo Picasso",
    ),
    const Quote(
      text: "Do what you can, with what you have, where you are.",
      author: "Theodore Roosevelt",
    ),
    const Quote(text: "Happiness depends upon ourselves.", author: "Aristotle"),
    const Quote(
      text: "Whatever you are, be a good one.",
      author: "Abraham Lincoln",
    ),
    const Quote(
      text: "Tough times never last, but tough people do.",
      author: "Robert H. Schuller",
    ),
    const Quote(
      text: "Believe you can and you're halfway there.",
      author: "Theodore Roosevelt",
    ),
    const Quote(
      text: "Don't watch the clock; do what it does. Keep going.",
      author: "Sam Levenson",
    ),
    const Quote(
      text: "A journey of a thousand miles begins with a single step.",
      author: "Lao Tzu",
    ),
    const Quote(
      text: "Everything has beauty, but not everyone sees it.",
      author: "Confucius",
    ),
    const Quote(
      text:
          "How wonderful it is that nobody need wait a single moment before starting to improve the world.",
      author: "Anne Frank",
    ),
  ];

  Quote getRandomQuote({Quote? currentQuote}) {
    if (_quotes.isEmpty) {
      return const Quote(text: "No quotes available.", author: "System");
    }

    final random = Random();
    Quote newQuote;

    do {
      newQuote = _quotes[random.nextInt(_quotes.length)];
    } while (currentQuote != null &&
        newQuote == currentQuote &&
        _quotes.length > 1);

    return newQuote;
  }
}

// ---------------------------------------------------------------------------
// PRESENTATION LAYER (UI)
// ---------------------------------------------------------------------------

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspire Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
          secondary: const Color(0xFF00BCD4),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
          displayMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
            height: 1.3,
            fontStyle: FontStyle.italic,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.black54,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// WELCOME SCREEN
// ---------------------------------------------------------------------------

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    // Setup background color animation
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: const Color(0xFF1A237E), // Deep Indigo
      end: const Color(0xFF4A148C), // Deep Purple
    ).animate(_backgroundController);

    _color2 = ColorTween(
      begin: const Color(0xFF00BCD4), // Cyan
      end: const Color(0xFF29B6F6), // Light Blue
    ).animate(_backgroundController);
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const QuoteHomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Animated Background
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _color1.value ?? Colors.blue,
                  _color2.value ?? Colors.cyan,
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Animated Lottie Icon: Rocket (Launching/Inspiration)
              Lottie.network(
                'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
                height: 350,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              Text(
                "INSPIRE ME",
                
                style: Theme.of(context).textTheme.displayLarge,

              ),
              const SizedBox(height: 16),
              const Text(
                "Daily Dose of Wisdom",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  letterSpacing: 1.1,
                ),
              ),

              const Spacer(flex: 2),

              // Get Started Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _navigateToHome,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HOME SCREEN
// ---------------------------------------------------------------------------

class QuoteHomePage extends StatefulWidget {
  const QuoteHomePage({super.key});

  @override
  State<QuoteHomePage> createState() => _QuoteHomePageState();
}

class _QuoteHomePageState extends State<QuoteHomePage> {
  final QuoteRepository _repository = QuoteRepository();
  late Quote _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = _repository.getRandomQuote();
  }

  void _generateNewQuote() {
    setState(() {
      _currentQuote = _repository.getRandomQuote(currentQuote: _currentQuote);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the gradient colors based on the theme
    // We want to match the Welcome screen's vibe but keep it readable
    final gradientColors = [
      const Color(0xFF1A237E), // Deep Indigo
      const Color(0xFF00BCD4), // Cyan
    ];

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows body to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // White icon to contrast against the dark gradient
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: Container(
        // Applied the Gradient Background here
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                // 1. Header with Lottie Animation
                // Used 'S.json' which looks like a Star/Sparkle (Magic/Wisdom)
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Lottie.network(
                      'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/Q.json',
                      fit: BoxFit.contain,
                      height: 250,
                    ),
                  ),
                ),

                // 2. Main Quote Display
                Expanded(
                  flex: 6,
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            final scaleAnimation =
                                Tween<double>(begin: 0.9, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutBack,
                                  ),
                                );

                            final slideAnimation =
                                Tween<Offset>(
                                  begin: const Offset(0.0, 0.1),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                  ),
                                );

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: slideAnimation,
                                child: ScaleTransition(
                                  scale: scaleAnimation,
                                  child: child,
                                ),
                              ),
                            );
                          },
                      child: _QuoteCard(
                        key: ValueKey<String>(_currentQuote.text),
                        quote: _currentQuote,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 3. Action Button
                // Updated style to work on dark background (White button)
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton.icon(
                    onPressed: _generateNewQuote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White button
                      foregroundColor: const Color(0xFF1A237E), // Indigo Text
                      elevation: 8,
                      shadowColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 28),
                    label: const Text(
                      "New Inspiration",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final Quote quote;

  const _QuoteCard({required this.quote, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95), // Slightly translucent white
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon color matches the primary theme
          Icon(
            Icons.format_quote_rounded,
            size: 50,
            color: const Color(0xFF1A237E).withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            quote.text,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: const Color(0xFF1A237E), // Dark text for readability
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 2,
                width: 30,
                color: const Color(0xFF00BCD4), // Cyan accent
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  quote.author.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black87),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 2,
                width: 30,
                color: const Color(0xFF00BCD4), // Cyan accent
              ),
            ],
          ),
        ],
      ),
    );
  }
}
