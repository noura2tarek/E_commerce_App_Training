part of 'favourites_cubit.dart';

@immutable
abstract class FavouritesState {}

class FavouritesInitialState extends FavouritesState {}
class GetFavouritesSuccessState extends FavouritesState {}
class GetFavouritesErrorState extends FavouritesState {}
class AddToFavouritesSuccessState extends FavouritesState {
  final String? status;

  AddToFavouritesSuccessState(this.status);
}
class AddToFavouritesErrorState extends FavouritesState {}
class DeleteFromFavouritesSuccessState extends FavouritesState {}
class DeleteFromFavouritesErrorState extends FavouritesState {}
