import 'package:e_commerce_app/core/controllers/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:e_commerce_app/screens/modules/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/managers/lists.dart';
import '../widgets/build_boarding_item.dart';

class OnBoardingScreen extends StatelessWidget {
  final boardController = PageController();

  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var boardingCubit = OnBoardingCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
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
                const SizedBox(
                  height: 10.0,
                ),
                ///////******** button ********/
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: FloatingActionButton(
                      child: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onPressed: () {
                        if (boardingCubit.isLastPage) {
                          boardingCubit.submitToRegister(
                              context: context, widgett: RegisterScreen());
                        } else {
                          boardController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
