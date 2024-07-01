import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth/controllers/quiz_controller.dart';
import 'package:firestore_auth/models/quiz.dart';
import 'package:firestore_auth/widgets/first_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Widget> pages = [];
  int _curPage = 0;
  final Map<int, bool> _answeredQuestion = {};
  final _pageController = PageController();

  void _onAnswerSelected(int pageIndex, bool isAnswered) {
    setState(() {
      _answeredQuestion[pageIndex] = isAnswered;
    });
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.bounceOut);
  }

  @override
  Widget build(BuildContext context) {
    final quizController = context.read<QuizController>();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                // showDialog(context: context, builder: (ctx) => {});
              },
              contentPadding: EdgeInsets.all(10),
              tileColor: Colors.amber,
              title: Text("Add Question"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(10),
            const ListTile(
              contentPadding: EdgeInsets.all(10),
              tileColor: Colors.amber,
              title: Text("Edit Question"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(10),
            const ListTile(
              contentPadding: EdgeInsets.all(10),
              tileColor: Colors.amber,
              title: Text("Delete Question"),
              trailing: Icon(Icons.keyboard_arrow_right),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("HomeScreen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 205, 22, 237),
      body: StreamBuilder(
          stream: quizController.list,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text(" No questions yet!"),
              );
            }
            final questions = snapshot.data!.docs;
            return questions.isEmpty
                ? const Center(
                    child: Text(" No questions yet!"),
                  )
                : Center(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: questions.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == questions.length) {
                          return const FlutterLogo(
                            size: 100,
                          );
                        } else {
                          final question = Quiz.fromJson(questions[index]);
                          print(question);

                          return AlternativesWidget(
                            question: question,
                          );
                        }
                      },
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _pageController.nextPage(
                duration: Duration(seconds: 1), curve: Curves.linear);
          },
          label: const Text('Next')),
    );
  }
}
