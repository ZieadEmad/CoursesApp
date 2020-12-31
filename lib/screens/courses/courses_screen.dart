import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_app/screens/courses/cubit/cubit.dart';
import 'package:course_app/screens/courses/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CoursesCubit()..getCourses(),
      child: BlocConsumer<CoursesCubit, CoursesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var Courses = CoursesCubit.get(context).courses;
          return ConditionalBuilder(
            condition: state is! CoursesStatesLoading,
            builder: (context) => ConditionalBuilder(
              condition: state is! CoursesStatesError,
              builder: (context) => ConditionalBuilder(
               condition: Courses.length!=0,
                builder: (context)=>Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 100.0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildSearchCategoryItem(cat[index], context),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                        itemCount: cat.length,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          top: 20.0,
                        ),
                        itemBuilder: (context, index) => buildCourseItems(Courses[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 25.0,
                        ),
                        itemCount: Courses.length,
                      ),
                    ),
                  ],
                ),
                fallback: (context)=>Center(child: Text('No Courses Yet!!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),),
              ),
              fallback: (context) => Center(child: Text('Error !!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
