import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// Import styles
import 'package:kiddy/shared/theme.dart';
import 'package:kiddy/ui/widgets/camera_view.dart';

// Import Widgets
import 'package:kiddy/ui/widgets/header.dart';
import 'package:kiddy/ui/widgets/map_view.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  // Index for content
  int currentIndex = 0;

  // Carousel Controller
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    // Title
    Widget title() {
      return Padding(
        padding: const EdgeInsets.only(
          top: 48,
          right: 28,
          left: 28,
        ),
        child: Text(
          'Children Tracker',
          style: whiteText.copyWith(fontSize: 20, fontWeight: bold),
        ),
      );
    }

    // Current Content selected
    Widget content() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: CarouselSlider(
              items: const [
                CameraView(),
                MapView(),
              ],
              carouselController: _controller,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                enableInfiniteScroll: false,
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    1.5,
                padEnds: false,
                viewportFraction: 1,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) => GestureDetector(
                onTap: () => _controller.animateToPage(index),
                child: Container(
                  width: currentIndex == index ? 20 : 12,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentIndex == index
                        ? darkYellowColor
                        : lightGreyColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // render body
    Widget body() {
      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            title(),
            content(),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(children: [
        Header(
          color: darkPinkColor,
        ),
        body()
      ]),
    );
  }
}
