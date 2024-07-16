import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context) ;
        return Scaffold(
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(cubit.categoryModel!.data.data[index].image),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    cubit.categoryModel!.data.data[index].name,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            separatorBuilder: (context, index) =>
            const SizedBox(
              height: 5,
            ),
            itemCount: cubit.categoryModel!.data.data.length,
          ),
        );
      },
    );
  }
}
