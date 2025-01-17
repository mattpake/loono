import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/simple_health_care_provider_helper.dart';
import 'package:loono_api/loono_api.dart';

class SearchDoctorCard extends StatelessWidget {
  const SearchDoctorCard({
    Key? key,
    required this.onTap,
    required this.item,
  }) : super(key: key);

  final Function() onTap;
  final SimpleHealthcareProvider item;

  @override
  Widget build(BuildContext context) {
    final _specialization = item.specialization;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 165.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (_specialization != null)
                      Expanded(
                        child: Text(
                          _specialization.toUpperCase(),
                          style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/telephone.svg',
                      color: LoonoColors.grey,
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/at.svg',
                      color: LoonoColors.grey,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    item.title,
                    style: LoonoFonts.cardTitle.copyWith(color: LoonoColors.secondaryFont),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const Spacer(),
                Text(
                  '${item.getStreet()} ${item.houseNumber}',
                  style: LoonoFonts.cardAddress,
                ),
                Text(
                  '${item.city}, ${item.getFormattedPostalCode()}',
                  style: LoonoFonts.cardAddress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
