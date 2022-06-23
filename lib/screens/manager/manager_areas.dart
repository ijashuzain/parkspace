import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/screens/manager/manager_newmap.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/area_card.dart';

class ManagerAreas extends StatelessWidget {
  const ManagerAreas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Stack(
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return AreaCard(
                  name: "CMS Parking Centre",
                  address: "2876, St.Jose Dakota 2176",
                  color: Colors.green,
                  fromDate: "24 May, 2021",
                  toDate: "25 May, 2021",
                  fromTime: "12:00 AM",
                  toTime: "1:00 AM",
                  onTap: () {},
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Globals.showStackSheet(
                    context: context,
                    child: ManagerNewMap(),
                    title: "Select Location",
                  );
                },
                backgroundColor: kPrimaryColor,
                child: const Icon(
                  Icons.add,
                  color: kSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
