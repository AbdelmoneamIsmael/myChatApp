import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/cubit/peole_cubit/people_cubit.dart';
import 'package:messanger_app/cubit/peole_cubit/people_state.dart';
import 'package:messanger_app/screens/widgets/chat_builder.dart';

class PeopleChat extends StatelessWidget {
  const PeopleChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
          create: (context) => PeopleScreenCubit()..getAllUsersInApp(),
          child: BlocConsumer<PeopleScreenCubit, PeopleScreenState>(
            builder: (context, state) {
              PeopleScreenCubit cubit =
                  BlocProvider.of<PeopleScreenCubit>(context);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _customAppBar(context),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Your chat List',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state is PeopleScreenLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : state is PeopleScreenSuccessState
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ChatBuilder(
                                        user: cubit.usersInChatApp[index]),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 20),
                                  itemCount: cubit.numberPeople,
                                )
                              : const Center(
                                  child: Text('Failed to loadDAta'),
                                ),
                    ],
                  ),
                ),
              );
            },
            listener: (context, state) {},
          )),
    ));
  }

  Row _customAppBar(context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage: NetworkImage(
              BlocProvider.of<PeopleScreenCubit>(context).profileImageLink),
          radius: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Hello ${BlocProvider.of<PeopleScreenCubit>(context).currentName} ! ',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
