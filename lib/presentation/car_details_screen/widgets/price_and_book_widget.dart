import 'package:car_dealership/models/car_model.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class PriceAndBookWidget extends StatelessWidget {
  final Car car;

  const PriceAndBookWidget(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Price'),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${car.price}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: car.status != 'Available' ? null : () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              disabledBackgroundColor: ColorManager.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text(
            car.status == 'Available' ? 'Book Now' : car.status,
            style: TextStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
