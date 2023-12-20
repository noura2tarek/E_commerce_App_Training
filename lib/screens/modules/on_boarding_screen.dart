import 'package:e_commerce_app/core/controllers/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/screens/modules/register_screen.dart';
import 'package:e_commerce_app/screens/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/managers/lists.dart';
import '../widgets/build_boarding_item.dart';

class OnBoardingScreen extends StatelessWidget {
  final boardController = PageController();

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var boardingCubit = OnBoardingCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                /////////******* Page view *********//////////
                Expanded(
                  child: PageView.builder(
                    controller: boardController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return buildOnBoardingItem(boardingList[index]);
                    },
                    itemCount: boardingList.length,
                    onPageChanged: (index) {
                      if (index == (boardingList.length - 1)) {
                        boardingCubit.pageLast(index);
                      } else {
                        boardingCubit.notPageLast(index);
                      }
                    },
                  ),
                ),
                /////////******* End of Page view *********//////////

                SmoothPageIndicator(
                  controller: boardController,
                  count: boardingList.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 11.0,
                  ),
                ),

                const SizedBox(
                  height: 10.0,
                ),

                ///////******** button ********/
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DefaultButton(
                    alignment: AlignmentDirectional.center,
                    text: "Get Started",
                    isUpperCase: false,
                    backgroundColor: AppColors.primaryColor,
                    radius: 17.0,
                    function: () {
                      if (boardingCubit.isLastPage) {
                        boardingCubit.submitToRegister(
                            context: context, widgett: RegisterScreen());
                      } else {
                        boardController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },

                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
