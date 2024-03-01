import 'package:flutter/cupertino.dart';
import 'package:software_engineering/models/result.dart';
import '../models/option.dart';
import '../models/question.dart';
import '../models/quiz.dart';
import '../models/topics.dart';
import 'hive_database.dart';

/* Patty Dev
* Summary:
* This handles all data usage in the APP
* - Reading and Changing of users
* - Generating of default TOPICS
* - Generating of default QUIZ
* - Reading and Adding SCORES
* - Marking of Completion
* - Initializing and Clearing DATA
* */

class DataManager extends ChangeNotifier {
  String? status;

  final db = HiveDatabase();

  DataManager() {
    initializeData();
  }

  void updateUsername(String newStatus) {
    status = newStatus;

    notifyListeners();
  }

  /* Summary:
  * A 2D Array that Generate a List of Topic eg. [1, 2, 3,], [4, 5, 6]
  * List<Topic> a class that require [Chapter num, Title, Image, isCompleted = false];
  * */

  // Generate a default list of Topics for Software Engineering
  List<List<Topic>> softwareEngineering = [
    //Software Engineering 1
    [
      Topic(topicValue: 1, topicTitle: "Introduction", topicImage: "lib/assets/engineer.png"),
      Topic(topicValue: 2, topicTitle: "Software Development Life Cycle", topicImage: "lib/assets/cycle.png"),
      Topic(topicValue: 3, topicTitle: "Software Requirements", topicImage: "lib/assets/requirement.png"),
      Topic(topicValue: 4, topicTitle: "Software Design", topicImage: "lib/assets/design.png"),
      Topic(topicValue: 5, topicTitle: "Software Coding", topicImage: "lib/assets/coding.png"),
      Topic(topicValue: 6, topicTitle: "Creating Flow Graphs", topicImage: "lib/assets/flow-chart.png"),
      Topic(topicValue: 7, topicTitle: "Software Maintenance", topicImage: "lib/assets/maintenance.png"),
      Topic(topicValue: 8, topicTitle: "Software Metrics", topicImage: "lib/assets/metric.png"),
    ],
    //Software Engineering 2
    [
      Topic(topicValue: 9, topicTitle: "Software Planning and Scheduling", topicImage: "lib/assets/planning.png"),
      Topic(topicValue: 10, topicTitle: "Software Cost Estimation", topicImage: "lib/assets/cost.png"),
      Topic(topicValue: 11, topicTitle: "Software Quality", topicImage: "lib/assets/quality.png"),
    ]
  ];

  // Get the default List of Topic
  List<List<Topic>> getSoftwareEngineering() {
    return softwareEngineering;
  }

  // Compile the list of Result --> Title of Quiz && Score
  List<Result> quizResult = [];

  List<Result> getQuizResult() {
    return quizResult;
  }

  void addResult(String quizName, int score) {
    quizResult.add(
      Result(quizName: quizName, score: score),
    );

    _saveData();
    notifyListeners();
  }

  void markQuizCompleted(int selectedQuiz) {
    getQuizList()[selectedQuiz].isCompleted = true;

    _saveData();
    notifyListeners();
  }

  void clearResult() {
    quizResult.clear();

    notifyListeners();
  }

  // Generate a default Quiz
  List<Quiz> quizList = [
    Quiz(
        name: 'Chapter 1: What is software engineering?',
        questions: [
          Question(
              text: "It is a collection of codes, documents, and triggers that does a specific job and fills a specific requirement",
              options: [
                Option(text: 'Software', isCorrect: true),
                Option(text: 'Engineering', isCorrect: false),
                Option(text: 'Software engineering', isCorrect: false),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "It is the development of products using best practices, principles, and methods",
              options: [
                Option(text: 'Software', isCorrect: false),
                Option(text: 'Engineering', isCorrect: true),
                Option(text: 'Software engineering', isCorrect: false),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "is a detailed study of engineering to the design, development and maintenance of software",
              options: [
                Option(text: 'Software', isCorrect: false),
                Option(text: 'Engineering', isCorrect: false),
                Option(text: 'Software engineering', isCorrect: true),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Manages and control the internal operation of a computer system.",
              options: [
                Option(text: 'Software', isCorrect: false),
                Option(text: 'System software', isCorrect: true),
                Option(text: 'Software engineering', isCorrect: false),
                Option(text: 'Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "observe, analyzes and controls real world event as the occur",
              options: [
                Option(text: 'System software', isCorrect: false),
                Option(text: 'Engineering and scientific software', isCorrect: false),
                Option(text: 'Business engineering', isCorrect: false),
                Option(text: 'Real-time software', isCorrect: true),
              ]
          ),
        ],
    ),
    Quiz(
        name: 'Chapter 2: Software development and life cycle',
        questions: [
          Question(
              text: "What is SDLC means",
              options: [
                Option(text: 'Software Development Life Cycle', isCorrect: true),
                Option(text: 'Software Development Light Cycling', isCorrect: false),
                Option(text: 'Soft Day Life Cycling', isCorrect: false),
                Option(text: 'Sight Developing Light Cycle', isCorrect: false),
              ]
          ),
          Question(
              text: "Project leaders evaluate the terms of the project",
              options: [
                Option(text: 'Planning', isCorrect: true),
                Option(text: 'Define Requirements', isCorrect: false),
                Option(text: 'Software Design', isCorrect: false),
                Option(text: 'Software Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "Determine what the application is supposed to do and it's requirements",
              options: [
                Option(text: 'Planning', isCorrect: false),
                Option(text: 'Define Requirements', isCorrect: true),
                Option(text: 'Software Design', isCorrect: false),
                Option(text: 'Software Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "Consist of standardized patterns used for both architecture and software development",
              options: [
                Option(text: 'Software', isCorrect: false),
                Option(text: 'Engineering', isCorrect: false),
                Option(text: 'Software design', isCorrect: true),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Defines the way customers interact with the software",
              options: [
                Option(text: 'Architecture', isCorrect: false),
                Option(text: 'User Interface', isCorrect: true),
                Option(text: 'Platforms', isCorrect: false),
                Option(text: 'Programming', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
        name: 'Chapter 3: Software requirements',
        questions: [
          Question(
              text: "IEEE stands for",
              options: [
                Option(text: 'Institute of Electrical and Electronics Engineers', isCorrect: true),
                Option(text: 'Institute of Electric and Economic Engineers', isCorrect: false),
                Option(text: 'Inspired Eccentric Ecosystem Environment', isCorrect: false),
                Option(text: 'Institution of Electric and Electronics Engineering', isCorrect: false),
              ]
          ),
          Question(
              text: "Defined using natural language, tables and diagrams as these can be understood by all users",
              options: [
                Option(text: 'User requirements', isCorrect: false),
                Option(text: 'Engineering', isCorrect: true),
                Option(text: 'System Requirements', isCorrect: false),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Detailed description of what the system should do including the software system's functions, services, and operational constraints",
              options: [
                Option(text: 'Functional requirements', isCorrect: false),
                Option(text: 'Software Engineering', isCorrect: false),
                Option(text: 'Software Requirements', isCorrect: true),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "How the system should react to particular inputs and how the system should behave in particular situations",
              options: [
                Option(text: 'Functional requirements', isCorrect: true),
                Option(text: 'Software Engineering', isCorrect: false),
                Option(text: 'Software Requirements', isCorrect: false),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
          Question(
              text: "Define system properties and constraints e.g. reliability, response time and storage requirements",
              options: [
                Option(text: 'Functional requirements', isCorrect: false),
                Option(text: 'Software Engineering', isCorrect: false),
                Option(text: 'Non-Functional Requirements', isCorrect: true),
                Option(text: 'System software', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
        name: 'Chapter 4: Software Design',
        questions: [
          Question(
              text: "It refers to a system for hiding irrelevant information",
              options: [
                Option(text: 'Software', isCorrect: false),
                Option(text: 'Process', isCorrect: true),
                Option(text: 'Entity', isCorrect: false),
                Option(text: 'Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "It refers to a model or view of an item",
              options: [
                Option(text: 'Software', isCorrect: false),
                Option(text: 'Process', isCorrect: false),
                Option(text: 'Entity', isCorrect: true),
                Option(text: 'Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "This involves the use of parameterized subprograms referred to as ‘groups'",
              options: [
                Option(text: 'Functional Abstraction', isCorrect: true),
                Option(text: 'Data Abstraction', isCorrect: false),
                Option(text: 'Control Abstraction', isCorrect: false),
                Option(text: 'System Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "This involves specifying data that describes a data object",
              options: [
                Option(text: 'Functional Abstraction', isCorrect: false),
                Option(text: 'Data Abstraction', isCorrect: true),
                Option(text: 'Control Abstraction', isCorrect: false),
                Option(text: 'Non-Functional Abstraction', isCorrect: false),
              ]
          ),
          Question(
              text: "This states the desired effect, without stating the exact mechanism of control",
              options: [
                Option(text: 'Functional Abstraction', isCorrect: false),
                Option(text: 'Data Abstraction', isCorrect: false),
                Option(text: 'Control Abstraction', isCorrect: true),
                Option(text: 'System Abstraction', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
        name: 'Chapter 5: Software Coding',
        questions: [
        Question(
            text: "Software code should be written in a simple and concise manner.",
            options: [
              Option(text: 'Simplicity', isCorrect: true),
              Option(text: 'Modularity', isCorrect: false),
              Option(text: 'Design', isCorrect: false),
              Option(text: 'Efficiency', isCorrect: false),
            ]
        ),
        Question(
            text: "Breaking the software into several modules not only to makes it easy to understand but also easy to debug.",
            options: [
              Option(text: 'Simplicity', isCorrect: false),
              Option(text: 'Modularity', isCorrect: true),
              Option(text: 'Design', isCorrect: false),
              Option(text: 'Efficiency', isCorrect: false),
            ]
        ),
        Question(
            text: "Software code is properly designed if it is presented in a proper manner.",
            options: [
              Option(text: 'Simplicity', isCorrect: false),
              Option(text: 'Modularity', isCorrect: false),
              Option(text: 'Design', isCorrect: true),
              Option(text: 'Efficiency', isCorrect: false),
            ]
        ),
        Question(
            text: "A program is said to be efficient if it makes optimal use of the available resources.",
            options: [
              Option(text: 'Simplicity', isCorrect: false),
              Option(text: 'Modularity', isCorrect: false),
              Option(text: 'Design', isCorrect: false),
              Option(text: 'Efficiency', isCorrect: true),
            ]
        ),
          Question(
              text: "_ can be achieved by using features such as simplicity, readability, and modularity.",
              options: [
                Option(text: 'Simplicity', isCorrect: false),
                Option(text: 'Modularity', isCorrect: false),
                Option(text: 'Design', isCorrect: false),
                Option(text: 'Clarity', isCorrect: true),
              ]
          ),
      ],
    ),
    Quiz(
        name: 'Chapter 6: Creating Flow Graphs',
        questions: [
          Question(
              text: "represents the logical flow within a program.",
              options: [
                Option(text: 'Appendices', isCorrect: false),
                Option(text: 'System Testing', isCorrect: false),
                Option(text: 'DERIVING TEST CASES', isCorrect: false),
                Option(text: 'FLOW GRAPHS', isCorrect: true),
              ]
          ),
          Question(
              text: "Software is integrated with other elements such as a hardware, people and data base. This system is then checked for errors using testing.",
              options: [
                Option(text: 'Appendices', isCorrect: false),
                Option(text: 'System Testing', isCorrect: true),
                Option(text: 'DERIVING TEST CASES', isCorrect: false),
                Option(text: 'FLOW GRAPHS', isCorrect: false),
              ]
          ),
          Question(
              text: "A path through the program which specifies a new condition or minimum of one new set of processing statements",
              options: [
                Option(text: 'Appendices', isCorrect: false),
                Option(text: 'System Testing', isCorrect: false),
                Option(text: 'DERIVING TEST CASES', isCorrect: false),
                Option(text: 'FINDING INDEPENDENT PATHS', isCorrect: true),
              ]
          ),
          Question(
              text: " basis path testing is presented as a series of steps and cases are developed to ensure that all statements within the programs get exercised at least once while performing basis paths in the program derived ",
              options: [
                Option(text: 'Appendices', isCorrect: false),
                Option(text: 'System Testing', isCorrect: false),
                Option(text: 'DERIVING TEST CASES', isCorrect: true),
                Option(text: 'FINDING INDEPENDENT PATHS', isCorrect: false),
              ]
          ),
          Question(
              text: "used to develop software tools that in turns help in carrying out basis paths testing.",
              options: [
                Option(text: 'Graphic Matrix', isCorrect: true),
                Option(text: 'System Testing', isCorrect: false),
                Option(text: 'DERIVING TEST CASES', isCorrect: false),
                Option(text: 'FINDING INDEPENDENT PATHS', isCorrect: false),
              ]
          ),
        ]
    ),
    Quiz(
      name: 'Chapter 7: Software Maintenance',
      questions: [
        Question(
            text: "describes an old system, which remains in operation within an organization.",
            options: [
              Option(text: 'Legacy System', isCorrect: true),
              Option(text: 'Software Product', isCorrect: false),
              Option(text: 'Software Maintenance Team', isCorrect: false),
              Option(text: 'Design Phase', isCorrect: false),
            ]
        ),
        Question(
            text: "contribute to the maintenance cost are listed below.",
            options: [
              Option(text: 'Legacy System', isCorrect: false),
              Option(text: 'Software Product', isCorrect: true),
              Option(text: 'Software Maintenance Team', isCorrect: false),
              Option(text: 'Design Phase', isCorrect: false),
            ]
        ),
        Question(
            text: "The group of individuals responsible for the software maintenance",
            options: [
              Option(text: 'Legacy System', isCorrect: false),
              Option(text: 'Software Product', isCorrect: false),
              Option(text: 'Software Maintenance Team', isCorrect: true),
              Option(text: 'Design Phase', isCorrect: false),
            ]
        ),
        Question(
            text: "the modifications to be made in the software are designed. The input attribute comprises outputs produced by analysis phase (detailed analysis),",
            options: [
              Option(text: 'Legacy System', isCorrect: false),
              Option(text: 'Software Product', isCorrect: false),
              Option(text: 'Software Maintenance Team', isCorrect: false),
              Option(text: 'Design Phase', isCorrect: true),
            ]
        ),
        Question(
            text: "the regression testing (a type of system testing) is performed on the modified system to ensure that no new faults are introduced in the software as a result of the maintenance activity.",
            options: [
              Option(text: 'Legacy System', isCorrect: false),
              Option(text: 'Software Product', isCorrect: false),
              Option(text: 'Implementation phase', isCorrect: true),
              Option(text: 'Design Phase', isCorrect: false),
            ]
        ),
      ],
    ),
    Quiz(
      name: 'Chapter 8: Software Metrics',
      questions: [
        Question(
            text: "include software processes like cost and effort applied and products and lines code produced, execution speed, and other defects that have been reported.",
            options: [
              Option(text: 'Software Metrics', isCorrect: false),
              Option(text: 'Software Goal', isCorrect: false),
              Option(text: 'Direct Measure', isCorrect: true),
              Option(text: 'Indirect Measure', isCorrect: false),
            ]
        ),
        Question(
            text: "include products like functionality, quality, complexity, reliability, maintainability, and many more.",
            options: [
              Option(text: 'Software Metrics', isCorrect: false),
              Option(text: 'Software Goal', isCorrect: false),
              Option(text: 'Direct Measure', isCorrect: false),
              Option(text: 'Indirect Measure', isCorrect: true),
            ]
        ),
        Question(
            text: "defined as the measure of degree to which a system, component, or process has a given attribute.",
            options: [
              Option(text: 'Software Metrics', isCorrect: true),
              Option(text: 'Software Goal', isCorrect: false),
              Option(text: 'Direct Measure', isCorrect: false),
              Option(text: 'Indirect Measure', isCorrect: false),
            ]
        ),
        Question(
            text: " Assess the effectiveness and quality of software process, determine the maturity of the process, effort required in the process, effectiveness of defect removal during development, and so on.",
            options: [
              Option(text: 'Software Metrics', isCorrect: false),
              Option(text: 'Process Metrics', isCorrect: true),
              Option(text: 'Direct Measure', isCorrect: false),
              Option(text: 'Indirect Measure', isCorrect: false),
            ]
        ),
        Question(
            text: "_ can be achieved by using features such as simplicity, readability, and modularity.",
            options: [
              Option(text: 'Software Metrics', isCorrect: false),
              Option(text: 'Software Goal', isCorrect: false),
              Option(text: 'Direct Measure', isCorrect: true),
              Option(text: 'Indirect Measure', isCorrect: false),
            ]
        ),
      ],
    ),
    Quiz(
      name: 'Chapter 9: Software Planning and Scheduling',
      questions: [
        Question(
            text: "a discipline for stating how to complete a project within a certain timeframe, usually with defined stages, and with designated resources.",
            options: [
              Option(text: 'Project Purpose', isCorrect: false),
              Option(text: 'Project Scope', isCorrect: false),
              Option(text: 'Project Planning', isCorrect: true),
              Option(text: 'Project Scheduling', isCorrect: false),
            ]
        ),
        Question(
            text: "explains the reason for its existence, the meaning of what is done, the ambition or dream pursued by the project or the direction it takes and maintains",
            options: [
              Option(text: 'Project Purpose', isCorrect: true),
              Option(text: 'Project Scope', isCorrect: false),
              Option(text: 'Project Plan', isCorrect: false),
              Option(text: 'Project Scheduling', isCorrect: false),
            ]
        ),
        Question(
            text: "a detailed outline of all aspects of a project, including all related activities, resources, timelines, and deliverables, as well as the project's boundaries.",
            options: [
              Option(text: 'Project Purpose', isCorrect: false),
              Option(text: 'Project Scope', isCorrect: false),
              Option(text: 'Project Plan', isCorrect: true),
              Option(text: 'Project Scheduling', isCorrect: false),
            ]
        ),
        Question(
            text: "a timetable that organizes project tasks, activity durations, calendar start and end dates, and sets overall project milestones on a timeline.",
            options: [
              Option(text: 'Project Purpose', isCorrect: false),
              Option(text: 'Project Scope', isCorrect: true),
              Option(text: 'Project Plan', isCorrect: false),
              Option(text: 'Project Scheduling', isCorrect: false),
            ]
        ),
        Question(
            text: "a graphic representation of the task flow for a project. ",
            options: [
              Option(text: 'Task Network', isCorrect: true),
              Option(text: 'Project Scope', isCorrect: false),
              Option(text: 'Project Plan', isCorrect: false),
              Option(text: 'Project Scheduling', isCorrect: false),
            ]
        ),
      ],
    ),
    Quiz(
      name: 'Chapter 10: Software Cost Estimation',
      questions: [
        Question(
            text: "human expert use their knowledge and skills to estimate the cost of software project. While estimating cost, expert make several assumptions and judgements about the cost involved in the project.",
            options: [
              Option(text: 'Expert Judgement', isCorrect: true),
              Option(text: 'Project Size', isCorrect: false),
              Option(text: 'Programmer Ability', isCorrect: false),
              Option(text: 'Available Time', isCorrect: false),
            ]
        ),
        Question(
            text: "Generally, software is categorized into three parts namely application programs, utility programs, and system programs.",
            options: [
              Option(text: 'Product Complexity', isCorrect: true),
              Option(text: 'Project Size', isCorrect: false),
              Option(text: 'Programmer Ability', isCorrect: false),
              Option(text: 'Available Time', isCorrect: false),
            ]
        ),
        Question(
            text: "Software project is also dependent on the ability of the programmers who are involve to the software development.",
            options: [
              Option(text: 'Product Complexity', isCorrect: false),
              Option(text: 'Project Size', isCorrect: false),
              Option(text: 'Programmer Ability', isCorrect: true),
              Option(text: 'Available Time', isCorrect: false),
            ]
        ),
        Question(
            text: "available to develop a software project according to the user requirements is considered an important factor while determining the project cost.",
            options: [
              Option(text: 'Product Complexity', isCorrect: false),
              Option(text: 'Project Size', isCorrect: false),
              Option(text: 'Programmer Ability', isCorrect: false),
              Option(text: 'Available Time', isCorrect: true),
            ]
        ),
        Question(
            text: "an important criterion for estimating the cost of a software project. A large-sized project consumes more resources than a smaller project.",
            options: [
              Option(text: 'Product Complexity', isCorrect: false),
              Option(text: 'Project Size', isCorrect: true),
              Option(text: 'Programmer Ability', isCorrect: false),
              Option(text: 'Available Time', isCorrect: false),
            ]
        ),
      ],
    ),
    Quiz(
      name: 'Chapter 11: Software Quality',
      questions: [
        Question(
            text: "a world wide federation of national standard bodies.",
            options: [
              Option(text: 'Software Quality', isCorrect: false),
              Option(text: 'Functional', isCorrect: false),
              Option(text: 'Non-Functional', isCorrect: false),
              Option(text: 'ISO', isCorrect: true),
            ]
        ),
        Question(
            text: "the product’s compliance with functional (explicit) requirements and design specifications.",
            options: [
              Option(text: 'Software Quality', isCorrect: false),
              Option(text: 'Functional', isCorrect: true),
              Option(text: 'Non-Functional', isCorrect: false),
              Option(text: 'ISO', isCorrect: false),
            ]
        ),
        Question(
            text: "system’s inner characteristics and architecture, i.e structural (implicit) requirements. ",
            options: [
              Option(text: 'Software Quality', isCorrect: false),
              Option(text: 'Functional', isCorrect: false),
              Option(text: 'Non-Functional', isCorrect: true),
              Option(text: 'ISO', isCorrect: false),
            ]
        ),
        Question(
            text: "defined as a field of study and practice that describes the desirable attributes of software products.",
            options: [
              Option(text: 'Software Quality', isCorrect: true),
              Option(text: 'Functional', isCorrect: false),
              Option(text: 'Non-Functional', isCorrect: false),
              Option(text: 'ISO', isCorrect: false),
            ]
        ),
        Question(
            text: "the degree of conformance to explicit or implicit requirements and expectations.",
            options: [
              Option(text: 'Software Quality', isCorrect: true),
              Option(text: 'Functional', isCorrect: false),
              Option(text: 'Non-Functional', isCorrect: false),
              Option(text: 'ISO', isCorrect: false),
            ]
        ),
      ],
    ),

  ];

  List<Quiz> getQuizList() {
    return quizList;
  }

  void addNewQuiz(Quiz quiz) {
    quizList.add(quiz);

    _saveData();
    notifyListeners();

    print(quizList);
  }

  // Run database when app is Fire
  void initializeData() async {
    await db.init();
    // Check if there is currently data to be read
    if (db.previousDataExists()) {
      final data = db.readFromDatabase();

      // Retrieve quizList and quizResult from the data map
      quizList = data['quizList'];
      quizResult = data['quizResult'];
    } else {
      print("SAVE");
      _saveData(); // Save default data
    }
  }

  void _saveData() {
    db.saveToDatabase(quizList, quizResult);
  }

  void clearNewQuizzes() {
    // Get the index where the new quizzes start
    int newQuizIndex = softwareEngineering.length;
    // Remove all quizzes starting from the index where new quizzes were added
    quizList.removeRange(newQuizIndex, quizList.length);

    notifyListeners();
  }

  void clearData() {
    clearResult();
    clearNewQuizzes();

    _saveData();
    notifyListeners();
  }
}