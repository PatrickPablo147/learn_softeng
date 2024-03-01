import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/quiz_screen.dart';
import 'package:software_engineering/utils/lesson_slideshare.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../database/data_manager.dart';
import '../models/lesson.dart';

/* PATTY_DEV
* Summary:
*  This handles topic screen -->
* - Topics Content
* - Slide Share PPT
* */

class TopicScreen extends StatefulWidget {
  final int courseIndex;
  final int topicValue;
  const TopicScreen({Key? key, required this.topicValue, required this.courseIndex}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  final Lesson lessonContent = Lesson();
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.topicValue;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _header(),
                const SizedBox(height: 12,),

                //Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Slide Share Container
                        _slideShareContainer(value),

                        // Prev Button --> Indicator --> Next Button
                        _navigationWidget(value),
                        const SizedBox(height: 8,),

                        // Try Quiz Button
                        MaterialButton(
                            minWidth: 132,
                            height: 46,
                            elevation: 0,
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Set your desired border radius
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QuizScreen()
                                  )
                              );
                            },
                            child: reusableSubtitleText('Try Quiz', Colors.white)
                        ),

                        // Chapter title
                        Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: reusableSubtitleText(
                                'Chapter ${value.getSoftwareEngineering()[widget.courseIndex][currentIndex].topicValue.toString()}: '
                                    '${value.getSoftwareEngineering()[widget.courseIndex][currentIndex].topicTitle}',
                                textColor
                            )
                        ),

                        // Chapter Content
                        _chapterContent(value)
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Chapter Widget
  _chapterContent(DataManager value) {
    final Lesson lessonContent = Lesson();

    return reusableText(lessonContent.getContent()[widget.courseIndex][currentIndex].toString(), textColor);
  }
  // Navigation --> Next Topic or Previous Topic
  _navigationWidget(DataManager value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              //Check if topic length is not equal to index --> e.g. the first item of list would set inactive prev button
              if(currentIndex != 0) {
                setState(() {
                  currentIndex--;
                });
              }
            },
            child: reusableText(
              "Prev Topic",
              //Check if topic length is equal 0 --> e.g. the first item of list would display inactive prev button
              currentIndex == 0 ? grey : textColor
            ),
          ),
          const SizedBox(
            width: 100,
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              //Check if topic length is not equal to index + 1 --> e.g. the last item of list would set inactive next button
              if(currentIndex + 1 != value.getSoftwareEngineering()[widget.courseIndex].length) {
                setState(() {
                  currentIndex++;
                });
              }
            },
            child: reusableText(
              "Next Topic",
              //Check if topic length is equal to topic value + 1 --> e.g. the last item of list would display inactive next button
              value.getSoftwareEngineering()[widget.courseIndex].length == currentIndex + 1 ? grey : textColor
            ),
          ),
        ],
      ),
    );
  }
  // Allows Slide Share to Display at Full Scale
  _showFullScreenImage() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: true,
      pageBuilder: (BuildContext context, _, __) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context); // Close the fullscreen view on tap
          },
          child: Stack(
            children: [
              Container(
                color: Colors.white, // Background color
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 1, // Rotate the image 90 degrees
                    child: PageView.builder(
                      itemCount: lessonContent.getLessons()[widget.courseIndex][widget.topicValue].length,
                      itemBuilder: (context, index) {
                        return Image(image: AssetImage(lessonContent.getLessons()[widget.courseIndex][widget.topicValue][index]));
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: 24, height: 24,
                color: Colors.black,
              )
            ],
          ),
        );
      },
    ));
  }
  // Slide Share PPT Widget
  _slideShareContainer(DataManager value) {
    return SizedBox(
      height: 220,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(onTap: _showFullScreenImage, child: LessonSlideShare(courseIndex: widget.courseIndex, topicValue: currentIndex,))
    );
  }
  // Return button and Title
  _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
          height: 46, minWidth: 50,
          padding: const EdgeInsets.only(right: 4),
          shape: const CircleBorder(),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.2),
          child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,),
        ),
        Expanded(
          child: reusableTitleText(widget.courseIndex == 0 ? "Software Engineering 1" : "Software Engineering 2", textColor),
        )
      ],
    );
  }
}


