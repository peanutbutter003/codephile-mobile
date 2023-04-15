import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constants/colors.dart';
import '../bloc/search_bloc.dart';

class FilterSearch extends StatelessWidget {
  const FilterSearch({
    required this.bloc,
    Key? key,
  }) : super(key: key);
  final SearchBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>.value(
      value: bloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: AppColors.grey7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.r),
                      child: Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(SearchPeople(
                            query: state.query,
                            selectedField: bloc.updatedFilter));
                        Get.back(result: true);
                      },
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 0, 25),
                child: Text(
                  'Fields',
                  style: TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: DropdownSearch<String>(
                    selectedItem: state.selectedField,
                    popupProps: const PopupProps.menu(showSearchBox: true),
                    items: SearchBloc.fields,
                    onChanged: (field) {
                      if (field == null) return;
                      bloc.updatedFilter = field;
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: 'Select Field',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
