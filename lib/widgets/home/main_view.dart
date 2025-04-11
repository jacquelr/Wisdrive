import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wisdrive/constraints/helper_functions.dart';
import 'package:wisdrive/constraints/images_routes.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<String> imagePaths = ImageCarousel.imagesList;
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0; // índice actual

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            "Welcome to Wisdrive",
            style: GoogleFonts.play(
              color: HelperFunctions.getWhiteBgTextThemeColor(),
              fontSize: 30,
            ),
          ),
          Text(
            "Get ready to be wise with wisdrive",
            style: GoogleFonts.play(
              color: HelperFunctions.getWhiteBgTextThemeColor(),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imagePaths.map((path) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: imagePaths.length,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Colors.deepPurple,
              dotColor: Colors.grey.shade300,
            ),
            onDotClicked: (index) {
              _controller.animateToPage(index);
            },
          ),
        ],
      ),
    );
  }
}
