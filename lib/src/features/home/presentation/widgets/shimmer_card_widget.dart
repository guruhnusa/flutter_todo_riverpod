import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 15,
      ),
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 200,
            width: context.deviceWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
