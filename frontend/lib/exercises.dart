import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/widgets/inside_card.dart';
import 'package:url_launcher/url_launcher.dart';

class Exercises extends StatelessWidget {
  const Exercises({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: AppBar(
            iconTheme: IconThemeData(color: Color(0xff5A4AE3)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.logout, color: Colors.red, size: 30),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InsideCard(
                    img: "assets/meditation.png",
                    title: "Meditation",
                    txt: "Meditation is a mindfulness exercise that involves sitting in a quiet place and focusing on your thoughts, emotions, and bodily sensations. It helps to calm your mind, reduce stress, and improve your overall well-being. With regular practice, meditation can enhance your ability to focus, increase your self-awareness, and promote inner peace.",
                    popupTxt: "Take a deep breath and relax your mind. Set the timer and begin your meditation exercise. Stay focused on your breathing and let go of any thoughts or worries that arise. Stop the timer when you are done, take a moment to appreciate the stillness and peace you have found.",
                    type: 'Meditation',
                    onTap: ()async{
                      await launchUrl(Uri.parse("https://www.nytimes.com/guides/well/how-to-meditate"));
                    },
                  ),
                  InsideCard(
                    img: "assets/nature_observation.png",
                    title: "Nature Observation",
                    txt: "This exercise involves paying attention to the natural world around you, such as the colors, shapes, and movements of trees, flowers, clouds, and animals. The goal is to engage all of your senses, including sight, sound, touch, and smell, and to simply observe without judgment or analysis. This can help you connect with the present moment, reduce stress and anxiety, and cultivate a greater appreciation for the beauty and wonder of nature.",
                    popupTxt: 'Find a quiet spot outdoors and take a moment to observe your surroundings. Set the timer and allow yourself to fully engage with nature. Take note of the sights, sounds, and smells around you. Stop the timer when you are done, take a deep breath and carry this feeling of connection with you throughout your day.',
                    type: 'Nature Observation',
                      onTap: ()async{
                        await launchUrl(Uri.parse("https://nature-mentor.com/easy-guide-to-nature-observation/#:~:text=Nature%20observation%20is%20the%20practice,with%20the%20world%20around%20you"));
                      }
                  ),
                  InsideCard(
                    img: "assets/yoga.png",
                    title: "Yoga and Stretching",
                    txt: "Yoga and stretching are physical activities that can help in promoting mindfulness. Through these exercises, individuals can improve their mind-body connection, increase their focus, and reduce stress levels. Yoga and stretching allow individuals to become more aware of their breath and body sensations, helping them to stay present in the moment. Practicing yoga and stretching regularly can improve flexibility, balance, and strength, leading to overall physical and mental wellbeing.",
                    popupTxt: "Get comfortable and prepare to stretch your body and calm your mind. Set the timer and allow yourself to fully engage with each movement. Focus on your breath and allow it to guide you through the exercise. Stop the timer when you are done, take a deep breath and carry this feeling of relaxation with you throughout your day.",
                    type: 'Yoga and Stretching',
                      onTap: ()async{
                        await launchUrl(Uri.parse("https://www.prevention.com/fitness/workouts/g30417941/best-yoga-stretches/"));
                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
