import 'package:flutter/material.dart';
import 'package:flutter_application/front-page/lessons/back_button.dart';

class Letters extends StatefulWidget {
  const Letters({Key? key}) : super(key: key);

  @override
  State<Letters> createState() => _LettersState();
}

class _LettersState extends State<Letters> {
  final List<Map<String, dynamic>> lessonLetters = [
    {'letter': 'Alphabet A-C', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet D-F', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet G-I', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet J-L', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet M-O', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet P-R', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet S-U', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet V-X', 'subtext': 'Learn new signs'},
    {'letter': 'Alphabet Y-Z', 'subtext': 'Learn new signs'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 100,
              maxHeight: 150,
              child: Container(
                color: Colors.deepPurpleAccent[700],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 36, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: CustomBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Visibility(
                        child: Text(
                          'Learn Alphabets',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/lesson-icon/img1.png',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final lesson = lessonLetters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: const Icon(Icons.menu_book_outlined, size: 30),
                      title: Text(
                        lesson['letter'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(lesson['subtext']),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: () {
                        // Perform your desired action here
                      },
                    ),
                  ),
                );
              },
              childCount: lessonLetters.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
