import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

Widget skeletonListItem() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            color: Colors.white,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 8.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 4.0),
                Container(
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
