import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LessonsScreen(),
    AlphabetScreen(),
    const DictionaryScreen(),
    const StudyScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: HomePage.scaffoldKey,

      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: const Text('SignBuddy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.feedback),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF5B187B),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          5.0), // do adjust the margin of avatar and Text "Juan Dela Cruz"
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  'assets/user_man.png'), // Replace with your avatar image path
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Juan Dela Cruz', // Replace with the user's name
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        HomePage.scaffoldKey.currentState?.openEndDrawer();
                      });
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Handle profile tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification'),
              onTap: () {
                // Handle notification tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('FAQ'),
              onTap: () {
                // Handle FAQ tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Handle about tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout tap
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF5BD8FF),
        unselectedItemColor: Colors.grey[800],
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Lessons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Alphabet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Dictionary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      // floatingActionButton: _currentIndex == 0
      //     ? FloatingActionButton.extended(
      //         onPressed: () {

      //         },
      //         icon: const Icon(Icons.play_arrow),
      //         label: const Text('Start'),
      //         backgroundColor: Colors.deepPurpleAccent[700],
      //       )
      //     : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  int? selectedLessonIndex;

  final List<Map<String, dynamic>> lessons = [
    {'lessonName': 'Alphabet', 'icon': 'lesson-icon/img1.png'},
    {'lessonName': 'Numbers', 'icon': 'lesson-icon/img2.png'},
    {'lessonName': 'Family and Friends', 'icon': 'lesson-icon/img3.png'},
    {'lessonName': 'Colors', 'icon': 'lesson-icon/img4.png'},
    {'lessonName': 'Shapes', 'icon': 'lesson-icon/img5.png'},
    {'lessonName': 'Animals', 'icon': 'lesson-icon/img6.png'},
    {'lessonName': 'Nature', 'icon': 'lesson-icon/img7.png'},
    {'lessonName': 'Foods and Drinks', 'icon': 'lesson-icon/img8.png'},
    {'lessonName': 'Time and Days', 'icon': 'lesson-icon/img9.png'},
    {'lessonName': 'Greetings', 'icon': 'lesson-icon/img10.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bg-signbuddy.png'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(41, 20, 20, 20),
              child: const Text(
                'Lessons',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  final isSelected = index == selectedLessonIndex;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        _navigateToStartLesson(context, lesson['lessonName']);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/${lesson['icon']}',
                            width: 48,
                            height: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            lesson['lessonName'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToStartLesson(BuildContext context, String lesson) {
  switch (lesson) {
    case 'Alphabet':
      Navigator.pushNamed(context, '/basic');
      break;
    case 'Mastering Finger Spelling':
      Navigator.pushNamed(context, '/finger_spelling');
      break;
    // Add more cases for other lessons...

    default:
      // Handle the case when the lesson is not found
      break;
  }
}

class AlphabetScreen extends StatefulWidget {
  @override
  _AlphabetScreenState createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  final letterImages = {
    'A': 'alphabet/a',
    'B': 'alphabet/b',
    'C': 'alphabet/c',
    'D': 'alphabet/d',
    'E': 'alphabet/e',
    'F': 'alphabet/f',
    'G': 'alphabet/g',
    'H': 'alphabet/h',
    'I': 'alphabet/i',
    'J': 'alphabet/j',
    'K': 'alphabet/k',
    'L': 'alphabet/l',
    'M': 'alphabet/m',
    'N': 'alphabet/n',
    'O': 'alphabet/o',
    'P': 'alphabet/p',
    'Q': 'alphabet/q',
    'R': 'alphabet/r',
    'S': 'alphabet/s',
    'T': 'alphabet/t',
    'U': 'alphabet/u',
    'V': 'alphabet/v',
    'W': 'alphabet/w',
    'X': 'alphabet/x',
    'Y': 'alphabet/y',
    'Z': 'alphabet/z',
  };

  String selectedLetter = '';

  @override
  Widget build(BuildContext context) {
    final letters = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(25, 50, 20, 20),
            child: const Text(
              'Sign Language Alphabet',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set the text color of the title
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: selectedLetter.isNotEmpty
                  ? Image.asset(
                      'assets/${letterImages[selectedLetter]}.png',
                      width: 200,
                      height: 200,
                    )
                  : const Text(
                      'Tap a letter to see the sign language image',
                      style: TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(20),
              children: List.generate(26, (index) {
                final letter = letters[index];
                final isSelected = selectedLetter == letter;
                return Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue[300] : Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          selectedLetter = '';
                        } else {
                          selectedLetter = letter;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
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

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bg-signbuddy.png'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Dictionary Screen',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class StudyScreen extends StatelessWidget {
  const StudyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bg-signbuddy.png'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Study Screen',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bg-signbuddy.png'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Settings Screen',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
