import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vonture_grad/core/utils/app_router.dart';
import 'package:vonture_grad/features/splash/presentation/views/widgets/sliding_widgets.dart';

class Splashiew extends StatelessWidget {
  const Splashiew({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingImageAnimation;
  late Animation<Offset> slidingTextAnimation;
  Animation<Offset>? slidingVontureAnimation; // Make it nullable
  late Animation<double> opacityAnimation;
  bool slidingVontureInitialized = false;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateTo();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: screenWidth / 5.6,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: slidingImageAnimation,
                  child: FadeTransition(
                    opacity: opacityAnimation,
                    child: child,
                  ),
                );
              },
              child: const SlidingImage(),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  height: screenHeight / 18.9,
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      if (slidingVontureAnimation == null) {
                        return const SizedBox(); // Return an empty SizedBox if animation is null
                      }
                      return SlideTransition(
                        position: slidingVontureAnimation!,
                        child: FadeTransition(
                          opacity: opacityAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: const SlidingVonture(),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 130 / 375,
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return SlideTransition(
                        position: slidingTextAnimation,
                        child: FadeTransition(
                          opacity: opacityAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: const SlidingText(),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    slidingImageAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animationController);

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        slidingVontureAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animationController);
        slidingVontureInitialized = true;
      });
    });

    slidingTextAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
            .animate(animationController);

    opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);

    animationController.forward();
  }

  void navigateTo() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        GoRouter.of(context).pushReplacement(AppRouter.kLogin);
      },
    );
  }
}
