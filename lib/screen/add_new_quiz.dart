import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/database/data_manager.dart';
import 'package:software_engineering/models/question.dart';
import 'package:software_engineering/models/quiz.dart';
import 'package:software_engineering/models/option.dart';

/* PATTY DEV
* This handles the adding of new quizzes screen
* */

class AddNewQuiz extends StatefulWidget {
  const AddNewQuiz({Key? key}) : super(key: key);

  @override
  State<AddNewQuiz> createState() => _AddNewQuizState();
}

class _AddNewQuizState extends State<AddNewQuiz> {
  TextEditingController quizNameController = TextEditingController();
  List<List<TextEditingController>> optionControllers = [];
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    // Initialize questions list with empty questions
    for (int i = 0; i < 5; i++) {
      questions.add(Question(
        text: '',
        options: List.generate(
          4,
              (index) => Option(text: '', isCorrect: false),
        ),
      ));
      // Initialize optionControllers list with empty controllers for each question
      optionControllers.add(List.generate(
        4,
            (index) => TextEditingController(),
      ));
    }
  }

  @override
  void dispose() {
    // Dispose all optionControllers when the state is disposed
    for (var controllers in optionControllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Quiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveQuiz,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: quizNameController,
                decoration: const InputDecoration(labelText: 'Quiz Name'),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _questionBuilder(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionBuilder(int id) {
    return Column(
      children: [
        TextField(
          onChanged: (text) => questions[id].text = text,
          decoration: InputDecoration(labelText: 'Question ${id + 1}'),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (text) => questions[id].options[index].text = text,
                    controller: optionControllers[id][index],
                    decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                  ),
                ),
                const SizedBox(width: 12),
                Radio<Option>(
                  value: questions[id].options[index], // Set the value to the option object
                  groupValue: questions[id].selectedOption, // Use the selected option for this group
                  onChanged: (value) {
                    setState(() {
                      // Update the selectedOption for the question
                      questions[id].selectedOption = value;

                      // Update the isCorrect property of the corresponding Option object
                      for (int i = 0; i < questions[id].options.length; i++) {
                        questions[id].options[i].isCorrect = (questions[id].options[i] == value);
                      }

                    });
                  },
                )
              ],
            );
          },
        )
      ],
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _saveQuiz() {
    if (quizNameController.text.isEmpty) {
      _showDialog('Quiz Name Required', 'Please enter a name for the quiz.');
      return;
    }

    for (int i = 0; i < 5; i++) {
      if (questions[i].text.isEmpty) {
        _showDialog('Question Text Required', 'Please enter text for Question ${i + 1}.');
        return;
      }
      for (int j = 0; j < 4; j++) {
        if (optionControllers[i][j].text.isEmpty) {
          _showDialog('Option Text Required', 'Please enter text for Option ${j + 1} of Question ${i + 1}.');
          return;
        }
      }
      if (questions[i].selectedOption == null) {
        _showDialog('Option Required', 'Please select an option for Question ${i + 1}.');
        return;
      }
    }
    // Create a new list to store the dynamically generated questions
    List<Question> newQuestions = [];

    // Iterate through each question and create a new Question object with user input
    for (int i = 0; i < 5; i++) {
      // Get the text of the question
      String questionText = questions[i].text;

      // Create a new list to store the options for this question
      List<Option> questionOptions = [];

      // Keep track of the index of the correct option
      int correctOptionIndex = -1;

      // Iterate through each option and create a new Option object with user input
      for (int j = 0; j < 4; j++) {
        // Get the text of the option
        String optionText = optionControllers[i][j].text;

        // Determine if this option is the correct one
        bool isCorrect = (questions[i].selectedOption == questions[i].options[j]);

        // Create a new Option object and add it to the list of options for this question
        questionOptions.add(Option(text: optionText, isCorrect: isCorrect));

        // Update the index of the correct option
        if (isCorrect) {
          correctOptionIndex = j;
        }
      }

      // Update the correct option in the list of options
      if (correctOptionIndex != -1) {
        questionOptions[correctOptionIndex].isCorrect = true;
      }

      // Create a new Question object with the question text and options
      Question newQuestion = Question(text: questionText, options: questionOptions);

      // Add the new question to the list of questions
      newQuestions.add(newQuestion);
    }

    // Create a new quiz object with the quiz name and dynamically generated questions
    Quiz newQuiz = Quiz(
      name: quizNameController.text,
      questions: newQuestions,
    );

    // Add the new quiz to the quizList in the DataManager
    Provider.of<DataManager>(context, listen: false).addNewQuiz(newQuiz);

    // Clear the quizNameController and optionControllers
    quizNameController.clear();
    questions.clear();
    for (var controllers in optionControllers) {
      for (var controller in controllers) {
        controller.clear();
      }
    }

    // Navigate back to the previous screen
    Navigator.pop(context);
  }

}