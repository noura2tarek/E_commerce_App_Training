import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/core/controllers/favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce_app/screens/widgets/build_fav_item.dart';
import 'package:flutter/materiaL.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/managers/app_strings.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouritesCubit, FavouritesState>(
       listener: (context, state) {},
        builder: (context, state) {
         var cubit = FavouritesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.favourites),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.favouritesModel!.favoriteProducts!.isNotEmpty,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildFavItem(
                             cubit.favouritesModel!.favoriteProducts![index], context),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5.0,
                          ),
                          itemCount: cubit.favouritesModel!.favoriteProducts!.length,
                        ),
                      ],
                    ),
                  ),
                );
              },
             fallback: (context) {
               return Container();
             },
            ),

          );
        },
    );
  }
}
