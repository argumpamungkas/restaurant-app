import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/data/models/detail_restaurant/data_detail_restaurant.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/ui/widget/dialog_failed.dart';
import 'package:restaurant_app/ui/widget/loading_dialog.dart';

class ListReview extends StatelessWidget {
  const ListReview({
    super.key,
    required this.idRestaurant,
    required this.dataDetail,
    required this.prov,
  });

  final String idRestaurant;
  final DataDetailRestaurant dataDetail;
  final RestaurantDetailProvider prov;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.reviews_outlined),
                SizedBox(width: 4),
                Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return _dialogReview(context);
                  },
                );
              },
              child: const Text("Add Review"),
            )
          ],
        ),
        ...dataDetail.customerReviews.reversed
            .map(
              (reviewer) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reviewer.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(reviewer.review),
                  Text(
                    reviewer.date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _dialogReview(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Add Review",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: prov.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: prov.nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => prov.setName(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is Empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: prov.reviewController,
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Review",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => prov.setReview(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Review is Empty";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            prov.reset();
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            if (prov.formKey.currentState!.validate()) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialog(),
              );
              await prov.addReview(idRestaurant).then((value) {
                if (value == ResultStatus.error) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        DialogFailed(description: prov.message),
                  );
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              });
            }
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
