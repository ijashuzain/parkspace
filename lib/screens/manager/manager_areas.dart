import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/area_provider.dart';
import 'package:parkspace/screens/manager/manager_newmap.dart';
import 'package:parkspace/utils/globals.dart';
import 'package:parkspace/widgets/area_card.dart';
import 'package:provider/provider.dart';

import 'manager_newarea.dart';

class ManagerAreas extends StatefulWidget {
  const ManagerAreas({Key? key}) : super(key: key);

  @override
  State<ManagerAreas> createState() => _ManagerAreasState();
}

class _ManagerAreasState extends State<ManagerAreas> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<AreaProvider>().fetchAllMyAreas(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<AreaProvider>(builder: (context, provider, child) {
        if (provider.fetchingAreas) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (provider.myAreas.isEmpty) {
          return Stack(
            children: [
              const Center(
                child: Text("No Areas Found"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    _onAddArea();
                  },
                  backgroundColor: kPrimaryColor,
                  child: const Icon(
                    Icons.add,
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox(
          child: Stack(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: provider.myAreas.length,
                itemBuilder: (context, index) {
                  return AreaCard(
                    name: provider.myAreas[index].areaName,
                    address: provider.myAreas[index].areaAddress,
                    color: Colors.green,
                    rate: provider.myAreas[index].rate,
                    cameraStatus: provider.myAreas[index].cameraStatus,
                    nightParking: provider.myAreas[index].nightParking,
                    slots: provider.myAreas[index].slots,
                    onTap: () {
                      Globals.showStackSheet(
                        context: context,
                        child: ManagerNewArea(
                          isEdit: true,
                          location: LatLng(
                            double.parse(provider.myAreas[index].latitude),
                            double.parse(provider.myAreas[index].longitude),
                          ),
                          area: provider.myAreas[index],
                        ),
                        title: "Update Parking Area",
                      );
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    _onAddArea();
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
        );
      }),
    );
  }

  _onAddArea() {
    Globals.showStackSheet(
      context: context,
      child: ManagerNewMap(),
      title: "Select Location",
    );
  }
}
