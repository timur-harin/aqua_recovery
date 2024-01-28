import 'package:aqua_recovery/ui/widgets/first_onboarding.dart';
import 'package:aqua_recovery/ui/widgets/second_onboarding.dart';
import 'package:aqua_recovery/ui/widgets/third_onboarding.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({super.key, this.page});

  int? page;

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  final List<Widget> _pages = [
    const FirstOnboardingPage(),
    const SeconOnboardingPage(),
    const ThirdOnboardingPage(),
  ];
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              if (widget.page != null) {
                if (widget.page == index) {
                  return _pages[index];
                }
                else {
                  _currentPage = widget.page!;
                  return _pages[widget.page!];
                }
              }
              return _pages[index];
            },
          ),
          
          Positioned(
            bottom: 20.0,
            child: Row(
              children: <Widget>[
                for (int i = 0; i < _pages.length; i++)
                  if (widget.page != null)
                    if (widget.page == i)
                      OnboardingPageIndicator(isActive: true)
                    else 
                      OnboardingPageIndicator(isActive: false)  
                  else
                    if (i == _currentPage || i == widget.page)
                      OnboardingPageIndicator(isActive: true)
                    else
                      OnboardingPageIndicator(isActive: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class OnboardingPageIndicator extends StatelessWidget {
  final bool isActive;

  OnboardingPageIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      height: isActive ? 12.0 : 8.0,
      width: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
