import 'package:flutter/material.dart';

import '../../models/on_borading_model.dart';

Widget buildOnBoardingItem(OnBoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        Text(
          model.title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.subtitle,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
