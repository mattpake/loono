import 'package:badges/badges.dart' as b;
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationBadges extends StatelessWidget {
  const ExaminationBadges({
    Key? key,
    required this.examinationType,
    required this.categorizedExamination,
    required this.badges,
  }) : super(key: key);

  final ExaminationType examinationType;
  final CategorizedExamination categorizedExamination;
  final Future<BuiltList<Badge>?> badges;

  @override
  Widget build(BuildContext context) {
    print('data categoriezed examination ${categorizedExamination.examination}');

    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: LoonoColors.greenLight,
        ),
        // height: 170,
        // child: Expanded(
        child: FutureBuilder<Badge?>(
          future: _currentBadge(),
          builder: (context, snapshot) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      context.l10n.examination_detail_rewards_for_examination,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                // FutureBuilder<Badge?>(
                //     future: _currentBadge(),
                //     builder: (context, snapshot) {
                //     return
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            // return FutureBuilder<Badge?>(
                            //   future: _currentBadge(),
                            //   builder: (context, snapshot) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              // child: Expanded(
                              child: Column(
                                children: [
                                  b.Badge(
                                    showBadge: _showRedBadge(snapshot.data, index),
                                    badgeColor: LoonoColors.red,
                                    position: b.BadgePosition.topStart(top: -10, start: 27),
                                    padding: const EdgeInsets.all(4),
                                    badgeContent: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.white,
                                          child: b.Badge(
                                            showBadge: _showGreenBadge(snapshot.data, index),
                                            badgeColor: LoonoColors.green,
                                            padding: const EdgeInsets.all(4),
                                            badgeContent: const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                            position:
                                                b.BadgePosition.bottomEnd(bottom: -8, end: -24),
                                            child: Image.asset(
                                              'assets/badges_examination/${examinationType.toString().toLowerCase()}'
                                              '/level_${snapshot.data?.type.name == categorizedExamination.examination.badge.name && snapshot.data!.level >= index + 1 ? '${index + 1}.png' : '${index + 1}_disabled.png'}',
                                            ),
                                          ),
                                        ),
                                        if (_showRedBadge(snapshot.data, index))
                                          SvgPicture.asset('assets/icons/ellipse.svg'),
                                      ],
                                    ),
                                  ),
                                  if (snapshot.data != null && snapshot.data!.level >= index + 1)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: SvgPicture.asset('assets/icons/points.svg'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 7.0),
                                            child: Text(
                                              categorizedExamination.examination.points.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: LoonoColors.checkBoxMark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  // Text('Test'),
                                ],
                              ),
                              // ),
                            );
                            //   },
                            // );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                //   },
                // ),
                if (_showRedBadge(snapshot.data)) const Text('test'),
                if (_showPointsText(snapshot.data))
                  // Padding(
                  // padding: const EdgeInsets.only(left: 18.0, top: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      // child: Padding(
                      //   padding: const EdgeInsets.only(left: 18.0, bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            context.l10n.examination_detail_rewards_last_month_validity_1,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              context.l10n.examination_detail_rewards_last_month_validity_1,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // ),
                // ),
              ],
            );
          },
        ),
        // ),
      ),
    );
  }

  Future<Badge?> _currentBadge() async {
    Badge? currentBadge;
    await badges.then(
      (value) {
        value!.forEach(
          (element) {
            if (element.type.name == categorizedExamination.examination.badge.name) {
              currentBadge = element;
              // isDisabled = false;
              // print(element.type.name);
              // print(categorizedExamination.examination.badge.name);
              // badgeLevel = element.level.toInt();
              // print(isDisabled);
            }
          },
        );
      },
    );
    return currentBadge;
  }

  bool _showGreenBadge(Badge? data, int index) {
    String relationship;
    final date = DateTime.now();
    final recommendedIntervalMinusTwoMonths =
        categorizedExamination.examination.intervalYears.toInt() * 12 - 2;
    // print('print date: $date');
    final comparedDate =
        DateTime(date.year, date.month - recommendedIntervalMinusTwoMonths, date.day);
    final lastConfirmedDate = DateTime(
      categorizedExamination.examination.lastConfirmedDate!.year,
      categorizedExamination.examination.lastConfirmedDate!.month,
      categorizedExamination.examination.lastConfirmedDate!.day,
    );
    final resultDate = lastConfirmedDate.compareTo(comparedDate);
    final isPlannedDate = categorizedExamination.examination.plannedDate != null;

    // if (resultDate < 0)
    //   relationship = "is older than";
    // else if (resultDate == 0)
    //   relationship = "is the same time as";
    // else
    //   relationship = "is newer (not older) than";
    //
    // print("last confirmed dat: $lastConfirmedDate");
    // print('compared date: $comparedDate');
    // print('Result date: $resultDate');
    // print('test: ${!isPlannedDate}');

    if (categorizedExamination.examination.state.name == 'CONFIRMED' &&
        !isPlannedDate &&
        ((resultDate == 1) || (resultDate == 0)) &&
        index + 1 == data?.level) {
      return true;
    } else {
      return false;
    }
  }

  bool _showRedBadge(Badge? data, [int? index]) {
    final isPlannedDate = categorizedExamination.examination.plannedDate != null;
    final date = DateTime.now();
    print('print date: $date');
    final recommendedIntervalMinusTwoMonths =
        categorizedExamination.examination.intervalYears.toInt() * 12 - 2;
    print('print recommendedIntervalMinusTwoMonths: $recommendedIntervalMinusTwoMonths');

    final comparedDateMinusTwoMonths =
        DateTime(date.year, date.month - recommendedIntervalMinusTwoMonths, date.day);
    print('print comparedDateMinusTwoMonths: $comparedDateMinusTwoMonths');

    final lastConfirmedDate = DateTime(
      categorizedExamination.examination.lastConfirmedDate!.year,
      categorizedExamination.examination.lastConfirmedDate!.month,
      categorizedExamination.examination.lastConfirmedDate!.day,
    );
    print('print lastConfirmedDate: $lastConfirmedDate');

    final resultDateMinusTwoMonths = lastConfirmedDate.compareTo(comparedDateMinusTwoMonths);
    print('print resultDateMinusTwoMonths: $resultDateMinusTwoMonths');

    // if (resultDate < 0)
    //   relationship = "is older than";
    // else if (resultDate == 0)
    //   relationship = "is the same time as";
    // else
    //   relationship = "is newer (not older) than";
    //
    // print("last confirmed dat: $lastConfirmedDate");
    // print('compared date: $comparedDate');
    // print('Result date: $resultDate');
    // print('test: ${!isPlannedDate}');

    final recommendedInterval = categorizedExamination.examination.intervalYears.toInt() * 12;
    print('recommendedInterval: $recommendedInterval');
    final comparedDateMinusRecommendedInterval =
        DateTime(date.year, date.month - recommendedInterval, date.day);
    print('comparedDateMinusRecommendedInterval: $comparedDateMinusRecommendedInterval');
    final resultDateRecommendedInterval =
        lastConfirmedDate.compareTo(comparedDateMinusRecommendedInterval);
    print('resultDateRecommendedInterval: $resultDateRecommendedInterval');
    if (!isPlannedDate &&
        resultDateMinusTwoMonths < 0 &&
        resultDateRecommendedInterval > 0 &&
        ((index == null) || (index + 1 == data?.level))) {
      return true;
    } else {
      return false;
    }
  }

  bool _showPointsText(Badge? data) {
    final isPlannedDate = categorizedExamination.examination.plannedDate != null;
    print('isPlannedDate: $isPlannedDate');
    final date = DateTime.now();
    print('date: $date');

    final recommendedInterval = categorizedExamination.examination.intervalYears.toInt() * 12;
    print('recommendedInterval: $recommendedInterval');

    final lastConfirmedDate = DateTime(
      categorizedExamination.examination.lastConfirmedDate!.year,
      categorizedExamination.examination.lastConfirmedDate!.month,
      categorizedExamination.examination.lastConfirmedDate!.day,
    );
    print('lastConfirmedDate: $lastConfirmedDate');

    final comparedDateMinusRecommendedInterval =
        DateTime(date.year, date.month - recommendedInterval, date.day);
    print('comparedDateMinusRecommendedInterval: $comparedDateMinusRecommendedInterval');

    final resultDateMinusTwoMonths =
        lastConfirmedDate.compareTo(comparedDateMinusRecommendedInterval);
    print('resultDateMinusTwoMonths: $resultDateMinusTwoMonths');

    if (isPlannedDate || resultDateMinusTwoMonths == 1) {
      return true;
    } else {
      return false;
    }
  }
}
