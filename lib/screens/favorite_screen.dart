import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/state.dart';

import '../styles/color.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = ShopAppCubit.get(context) ;
    return Scaffold(
      body:Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! ShopAppLoadingGetFavoritesState ,
          fallbackBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
          widgetBuilder: (context) =>   ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Container(
          height: 151,
          color: Colors.white,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage("${cubit.favoritesModel!.data!.dataL![index].product!.image}"),
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  if (cubit.favoritesModel!.data!.dataL![index].product!.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      color: Colors.red,
                      child: const Text(
                        "DISCOUNT",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "${cubit.favoritesModel!.data!.dataL![index].product!.description}",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${cubit.favoritesModel!.data!.dataL![index].product!.price}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: mainColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (cubit.favoritesModel!.data!.dataL![index].product!.discount != 0)
                          Text(
                            '${cubit.favoritesModel!.data!.dataL![index].product!.oldPrice}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: cubit.favorite[cubit.favoritesModel!.data!.dataL![index].product!.id]! ? mainColor : Colors.grey,
                          child: IconButton(
                              onPressed: () {
                                cubit.changeFavorite(cubit.favoritesModel!.data!.dataL![index].product!.id!) ;
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                size: 17,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const Divider(
          height: 5,
        ),
        itemCount: cubit.favoritesModel!.data!.dataL!.length,
      ),
      ));
  },
);
  }
}
