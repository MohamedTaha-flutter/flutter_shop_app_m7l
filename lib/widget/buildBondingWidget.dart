import 'package:flutter/material.dart';
import 'package:shop_app/model/boardingModel.dart';




Widget buildBondingWidget(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: Image(image: AssetImage('${model.image}'),)),
    const SizedBox(height: 30,),
    Text(" ${model.title}",style: const TextStyle(fontSize: 25),),
    const SizedBox(height: 10,),
    Text(" ${model.body}",style: const TextStyle(fontSize: 15,color: Colors.grey),),
    const SizedBox(height: 30,),
  ],
);
