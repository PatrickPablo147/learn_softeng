import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/database/data_manager.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../const/colors.dart';

class ClearRecord extends StatelessWidget {
  const ClearRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController deleteController = TextEditingController();
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context),
                    const SizedBox(height: 42,),
                    reusableSubtitleText(
                        "Remove Records",
                        textColor
                    ),
                    const SizedBox(height: 8,),
                    reusableText(
                        "Removing records would not be recoverable. If you want to continue type \"DELETE.\"",
                        textColor
                    ),
                    const SizedBox(height: 42,),
                    TextField(
                      controller: deleteController,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: lGrey,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: lGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: lGrey),
                          ),
                          hintText: 'DELETE',
                          hintStyle: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 16
                          )
                      ),
                    ),
                    const SizedBox(height: 8,),
                    MaterialButton(
                      onPressed: () {
                        String delete = deleteController.text.toUpperCase();
                        if(delete == 'DELETE') {
                          value.clearData();

                          deleteController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('The record is clear.',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  letterSpacing: -0.5
                                ),
                              ),
                            ),
                          );
                        }
                        else {
                          deleteController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Type DELETE correctly.',
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    letterSpacing: -0.5
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      minWidth: double.infinity,
                      height: 62,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Set your desired border radius
                      ),
                      splashColor: Colors.grey.withOpacity(0.5),
                      highlightColor: const Color(0xFF80B2FE).withOpacity(0.2),
                      child: reusableSubtitleText('Confirm', Colors.white),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  _header(BuildContext context) {
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
          child: Center(child: reusableTitleText("Clear Record", textColor)),
        )
      ],
    );
  }
}
