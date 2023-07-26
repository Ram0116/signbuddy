import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SoundIdentification extends StatefulWidget {
  const SoundIdentification({Key? key}) : super(key: key);

  @override
  _SoundIdentificationState createState() => _SoundIdentificationState();
}

class _SoundIdentificationState extends State<SoundIdentification> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();
  String correctAnswer = 'Dog';
  String? userAnswer;
  bool showModal = false;
  bool isAnswerCorrect = false;

  Future<void> playSound() async {
    await audioPlayer.open(
      Audio('assets/sounds/dog_bark.mp3'),
    );
    audioPlayer.play();
  }

  void handleAnswerSelection(String selectedAnswer) {
    setState(() {
      userAnswer = selectedAnswer;
    });
  }

  void guessAnswer() {
    setState(() {
      showModal = true;
      isAnswerCorrect = userAnswer == correctAnswer;
    });
  }

  void closeModal() {
    setState(() {
      showModal = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Dispose the audio player when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isGuessButtonEnabled = userAnswer != null;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Which animal is making this kind of noise?',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50.0),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  color: Colors
                      .deepPurpleAccent[700], // Set the color of the play logo
                  iconSize: 60.0,
                  onPressed: playSound,
                ),
                const SizedBox(height: 80.0),
                Wrap(
                  spacing: 10.0,
                  children: [
                    ElevatedButton(
                      onPressed: () => handleAnswerSelection('Cat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            userAnswer == 'Cat' ? Colors.yellow[800] : null,
                        fixedSize: const Size(
                            70, 50), // Adjust the width and height as needed
                      ),
                      child: Text(
                        'Cat',
                        style: TextStyle(
                          color:
                              userAnswer == 'Cat' ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => handleAnswerSelection('Dog'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            userAnswer == 'Dog' ? Colors.yellow[800] : null,
                        fixedSize: const Size(
                            70, 50), // Adjust the width and height as needed
                      ),
                      child: Text(
                        'Dog',
                        style: TextStyle(
                          color:
                              userAnswer == 'Dog' ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => handleAnswerSelection('Bird'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            userAnswer == 'Bird' ? Colors.yellow[800] : null,
                        fixedSize: const Size(
                            70, 50), // Adjust the width and height as needed
                      ),
                      child: Text(
                        'Bird',
                        style: TextStyle(
                          color: userAnswer == 'Bird'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                    onPressed: isGuessButtonEnabled ? guessAnswer : null,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 45),
                      backgroundColor: Colors.deepPurpleAccent[700],
                    ),
                    child: const Text(
                      'Guess',
                      style: TextStyle(fontSize: 18.0),
                    )),
              ],
            ),
          ),
          if (showModal)
            Container(
              color: Colors.black54,
              child: Center(
                child: GestureDetector(
                  onTap: closeModal,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isAnswerCorrect)
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 48.0,
                          ),
                        if (!isAnswerCorrect)
                          const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 48.0,
                          ),
                        const SizedBox(height: 20.0),
                        Text(
                          isAnswerCorrect ? 'Correct' : 'Incorrect',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(90, 35)),
                          onPressed: closeModal,
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
