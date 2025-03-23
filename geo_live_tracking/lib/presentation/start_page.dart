import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_live_tracking/config.dart';
import 'package:geo_live_tracking/presentation/signIn/sign_in.dart';

class GetStartedPage extends StatefulWidget {
  GetStartedPage({Key? key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
 int _current = 0;

  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> imageList = [
    'assets/get1.svg',
    'assets/get2.svg',
    'assets/get3.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20.0,top: 80,right: 20,bottom: 10),
              child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                  height: 320,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 2,
                  autoPlayInterval: Duration(seconds: 3),
                  enableInfiniteScroll: true,
                ),
                items: imageList.map((imagePath) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      imagePath,
                      width: 268,
                      height: 338,
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
              ),
            ),
               Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 7.0,
                height: 7.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? AppConfig.primaryColor
                        : AppConfig.appGrey)
              ),
            );
          }).toList(),
        ),
            SizedBox(height: 20),
            SizedBox(
              width: 252,
              child: Text(
                'Ride smarter with real-time navigation. Stay on track, stay safe.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            StartButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
            },),
          ],
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
 const  StartButton({
    super.key,
    this.text = 'Get Started',
    this.onPressed
  });

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 196,
        height: 58,
        decoration: BoxDecoration(
          color: AppConfig.buttonColor1,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
