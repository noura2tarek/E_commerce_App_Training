import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/on_borading_model.dart';

Widget buildOnBoardingItem(OnBoardingModel model) => Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.zero,
          width: double.infinity,
          height: 400.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(model.image),
              fit: BoxFit.cover,

            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Text(
          model.title.toUpperCase(),
          style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0, color:  HexColor('#5DB3C2')),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.subtitle,
          style: const TextStyle(fontSize: 16.0, color: Colors.grey),
        ),

      ],
    );
