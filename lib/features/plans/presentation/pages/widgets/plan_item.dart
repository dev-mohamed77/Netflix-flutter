import 'package:flutter/material.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

import '../../../domain/entity/plan_entity.dart';

class PlanItem extends StatelessWidget {
  const PlanItem({super.key, required this.plan, required this.onClick});

  final PlanEntity plan;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.sizeOf(context).height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              colors: [
                Colors.purple,
                Color.fromARGB(255, 48, 34, 231),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VerticalSpacer(5),
                Flexible(
                  child: Text(
                    plan.description,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalSpacer(20),
        PlanFeature(
          title: "monthly price",
          desc: "${plan.price} EGP",
        ),
        const VerticalSpacer(5),
        const Divider(
          endIndent: 25,
          indent: 25,
          thickness: 2,
        ),
        const VerticalSpacer(10),
        PlanFeature(
          title: "Resolution",
          desc: plan.resolution,
        ),
        const VerticalSpacer(5),
        const Divider(
          endIndent: 25,
          indent: 25,
          thickness: 2,
        ),
        const VerticalSpacer(10),
        PlanFeature(
          title: "Video quality",
          desc: plan.quality,
        ),
        const VerticalSpacer(5),
        const Divider(
          endIndent: 25,
          indent: 25,
          thickness: 2,
        ),
        const VerticalSpacer(10),
        Flexible(
          child: PlanFeature(
            title: "Supported devices",
            desc: plan.supportedDevices.join(", "),
          ),
        ),
        const VerticalSpacer(5),
        const Divider(
          endIndent: 25,
          indent: 25,
          thickness: 2,
        ),
        const VerticalSpacer(10),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ButtonCustom(
            title: const Text(
              "Continue",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColorsManager.white,
              ),
            ),
            onClick: onClick,
          ),
        ),
        const VerticalSpacer(35),
      ],
    );
  }
}

class PlanFeature extends StatelessWidget {
  const PlanFeature({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorsManager.accentColor,
            ),
            child: const Icon(
              Icons.done,
              color: AppColorsManager.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalSpacer(5),
              Text(
                desc,
                style: const TextStyle(
                  color: AppColorsManager.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
