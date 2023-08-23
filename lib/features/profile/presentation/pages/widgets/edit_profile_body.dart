import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/components/text_form_field_custom.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/enum/gender.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/core/providers/user_local_provider.dart';
import 'package:netflix/features/profile/presentation/manager/gender_manager.dart';
import 'package:netflix/features/profile/presentation/manager/providers.dart';
import 'package:netflix/features/profile/presentation/pages/widgets/phone_form_section.dart';

import '../../../../../core/manager/color/colors_manager.dart';
import '../../../../../core/manager/dailog/dialog_custom.dart';

class EditProfileBody extends ConsumerStatefulWidget {
  const EditProfileBody({super.key});

  @override
  ConsumerState<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends ConsumerState<EditProfileBody> {
  late TextEditingController fullNameController;

  late TextEditingController phoneController;

  @override
  void initState() {
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userLocalProvider);

    fullNameController.text = user?.fullName ?? "";
    phoneController.text = user?.phone ?? "";

    return Column(
      children: [
        const VerticalSpacer(35),
        TextFormFieldCustom(
          hintText: "Full name",
          controller: fullNameController,
          hintColor: context.scrimColor,
          validator: (value) {
            return null;
          },
        ),
        const VerticalSpacer(20),
        PhoneFormSection(phoneController: phoneController),
        const VerticalSpacer(20),
        Container(
          height: 53,
          width: context.width,
          padding: const EdgeInsets.only(left: 20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.red.shade100.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              borderRadius: BorderRadius.circular(15),
              items: const [
                DropdownMenuItem(
                  value: Gender.Male,
                  child: Text("Male"),
                ),
                DropdownMenuItem(
                  value: Gender.Female,
                  child: Text("Female"),
                ),
              ],
              hint: user?.gender == null
                  ? Text(
                      "Gender",
                      style: TextStyle(color: context.scrimColor),
                    )
                  : user?.gender == "Male"
                      ? Text(
                          "Male",
                          style: TextStyle(color: context.scrimColor),
                        )
                      : Text(
                          "Female",
                          style: TextStyle(color: context.scrimColor),
                        ),
              value: ref.watch(genderProvider),
              onChanged: (value) {
                ref.read(genderProvider.notifier).setGender(value);
              },
            ),
          ),
        ),
        const VerticalSpacer(20),
        const Spacer(),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final updateUser = ref.watch(updateUserUseCaseProvider);
            _updateUserListen(ref);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonCustom(
                title: updateUser.isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColorsManager.white,
                      )
                    : const Text(
                        "Update",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColorsManager.white,
                        ),
                      ),
                onClick: () {
                  ref.read(updateUserUseCaseProvider.notifier).execute(
                        fullName: fullNameController.text,
                        gender: ref.watch(genderProvider)?.name,
                        phone: phoneController.text,
                      );
                },
              ),
            );
          },
        ),
        const VerticalSpacer(30),
      ],
    );
  }

  _updateUserListen(WidgetRef ref) {
    ref.listen(
      updateUserUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "User updated successfully",
              color: AppColorsManager.green,
            );
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: Colors.red,
            );
          },
        );
      },
    );
  }
}
