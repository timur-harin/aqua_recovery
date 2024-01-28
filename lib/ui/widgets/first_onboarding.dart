import 'package:flutter/material.dart';

class FirstOnboardingPage extends StatelessWidget {
  const FirstOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 0,
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.height,
                    child: Stack(
                      children: [
                        Positioned(
                          left: screenSize.width * 0.25,
                          top: screenSize.height * 0.04,
                          child: Container(
                            width: screenSize.width * 0.8,
                            height: screenSize.height * 0.6,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: Image.asset(
                                  'assets/images/shower.png',
                                ).image,
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: screenSize.height * 0.65,
                          child: const Text(
                            'Start recovering \nfaster than ever',
                            style: TextStyle(
                              color: Color(0xFF01041D),
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: screenSize.height * 0.75,
                          child: const Text(
                            'We will help you to make your life \nmore healthier by analytics and \nnotifications',
                            style: TextStyle(
                              color: Color(0xFF8189B0),
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: screenSize.width * 0.75,
                          top: screenSize.height * 0.8,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/second');
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Color(0xFF01041D),
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
