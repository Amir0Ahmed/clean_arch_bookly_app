import 'package:clean_arch_bookly_app/core/widgets/skelton.dart';
import 'package:flutter/material.dart';

class SearchListViewShimmerLoading extends StatelessWidget {
  const SearchListViewShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
     return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SizedBox(
            height: 125,
            child: Row(
              children: [
                const AspectRatio(
                  aspectRatio: 2.6 / 4,
                  child: Skelton(),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Skelton(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                       const Skelton(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                       Skelton(
                        height: 10,
                        width: MediaQuery.of(context).size.width * .4,
                      ),
              
                   
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
