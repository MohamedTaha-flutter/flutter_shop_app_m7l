import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/state.dart';
import 'package:shop_app/styles/color.dart';
import 'package:shop_app/widget/product_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.homeModel != null,
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
          widgetBuilder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Image(
                        image: NetworkImage(
                            cubit.homeModel!.data.banners[index].image)),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 5,
                    ),
                    itemCount: cubit.homeModel!.data.banners.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                               Image(
                                image: NetworkImage(cubit.categoryModel!.data.data[index].image),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                              Container(
                                width: 120,
                                color: Colors.black.withOpacity(.7),
                                child:  Text(
                                  cubit.categoryModel!.data.data[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                          itemCount: cubit.categoryModel!.data.data.length,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "New Product",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1 / 1.57,
                    children: List.generate(
                      cubit.homeModel!.data.products.length,
                      (index) => Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image(
                                  image: NetworkImage(cubit
                                      .homeModel!.data.products[index].image),
                                  height: 210,
                                ),
                                if (cubit.homeModel!.data.products[index]
                                        .discount !=
                                    0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    color: Colors.red,
                                    child: const Text(
                                      "DISCOUNT",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.homeModel!.data.products[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${cubit.homeModel!.data.products[index].price.round()}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13, color: mainColor),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      if (
                                      cubit.homeModel!.data.products[index].discount != 0
                                      )
                                        Text(
                                          '${cubit.homeModel!.data.products[index].old_price.round()}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      const Spacer(),
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor: cubit.favorite[cubit.homeModel!.data.products[index].id]! ? mainColor: Colors.grey,
                                        child: IconButton(
                                            onPressed: ()
                                            {
                                              cubit.changeFavorite(cubit.homeModel!.data.products[index].id) ;
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
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
