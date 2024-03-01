import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/topic_screen.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../database/data_manager.dart';

/* Summary:
* Home Screen -> Display the topics and course
* Navigate to Topic based on Topic Tiles that been TAP
* */

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController();
  int courseIndex = 0;

  @override
  void initState() {
    super.initState();

    // Add the listener to update courseIndex when the page changes
    _controller.addListener(_updateCourseIndex);
  }

  void _updateCourseIndex() {
    setState(() {
      courseIndex = _controller.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(courseIndex);
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    reusableTitleText("Learning Software Engineering!", primaryColor),
                    const SizedBox(height: 42,),

                    // Software engineering 1 --> Software engineering 2
                    Expanded(child: softEngContainer())
                  ],
                ),
                // Indicator
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: primaryColor,
                      dotColor: primaryColor,
                      dotWidth: 10,
                      dotHeight: 10
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  /* Summary:
  * Page View -> Display the selected software engineering course container
  * Container -> View of Image and course title
  * Navigating -> Sliding horizontally
  * On change -> Set the course Index to 0 or 1
  * */
  softEngContainer() {
    return PageView.builder(
      controller: _controller,
      itemCount: 2,
      itemBuilder: (context, index) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: Offset(0, 4)
                    )
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 4,),
                  //Image
                  Expanded(
                    child: index == 0 ? const Image(image: AssetImage("lib/assets/softEng1.png"),) : const Image(image: AssetImage("lib/assets/softEng2.png"),),
                  ),
                  //Title
                  reusableSubtitleText(index == 0 ? "Software Engineering 1" : "Software Engineering 2", textColor),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
            const SizedBox(height: 12,),

            //Topics
            reusableSubtitleText("   Relevant Topics:", textColor),
            const SizedBox(height: 24,),

            topicListView()
          ],
        ),
      ),
    );
  }

  /* Summary:
  * Topic list view -> Display the list of chapters based on Course topics
  * List of topics set to 2 tiles vertically
  * On tap -> Navigate to topic screen where chapter is selected e.g Chapter 1 == Topic 1
  * */
  topicListView() {
    return Consumer<DataManager>(
      builder: (context, value, child) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: value.getSoftwareEngineering()[courseIndex].length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1 / 1.2
        ),
        itemBuilder: (context, index) {
          return Animate(
            key: ValueKey<int>(index),
            effects: [FadeEffect(
                duration: 1000.ms,
                delay: Duration(milliseconds: index * 400),
                curve: Curves.easeInOut
            )],
            child: MaterialButton(
              padding: const EdgeInsets.all(12),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return TopicScreen(
                          topicValue: index,
                          courseIndex: courseIndex,
                        );
                      }
                  )
              ),
              elevation: 0.3,
              color: secondaryColor,
              splashColor: primaryColor.withOpacity(0.2),
              highlightColor: primaryColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Set your desired border radius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Chapter
                  reusableSubtitleText("Chapter: ${value.getSoftwareEngineering()[courseIndex][index].topicValue}", textColor),
                  const SizedBox(height: 12,),

                  // Image
                  Expanded(
                    child: Image(
                      image: AssetImage(value.getSoftwareEngineering()[courseIndex][index].topicImage.toString()),
                      width: 80, height: 80,
                    )
                  ),
                  const SizedBox(height: 12,),

                  // Title
                  Text(
                    value.getSoftwareEngineering()[courseIndex][index].topicTitle.toString(),
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textColor
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
