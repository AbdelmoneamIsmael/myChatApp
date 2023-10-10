import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/cubit/picker_cubit/image_picker_cubit.dart';
import 'package:messanger_app/cubit/picker_cubit/image_picker_state.dart';

class BottomSheetForImage extends StatelessWidget {
  const BottomSheetForImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickerCubit, PickerState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<PickerCubit>(context);
        return BottomSheet(
          onClosing: () {
            cubit.closed();
            Navigator.pop(context);
          },
          builder: (context) {
            return SizedBox(
              height: 300,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          cubit.addPhoto(isCamera: true);
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.camera,
                          size: 80,
                        ),
                      ),
                      const Text(
                        'Camera',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          cubit.addPhoto(isCamera: false);
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 80,
                        ),
                      ),
                      const Text(
                        'Galary',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      listener: (context, state) {},
    );
  }
}
