import 'package:flutter_tts/flutter_tts.dart';

class CoachTTS {
  final FlutterTts tts = FlutterTts();

  speak(String text) async {
    await tts.setLanguage("en-US");
    await tts.setPitch(1);
    await tts.speak(text);
  }
}
