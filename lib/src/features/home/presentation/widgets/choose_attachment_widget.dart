import 'dart:io';

import 'package:dartz/dartz.dart' as dartz;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sabani_tech_test/src/core/extensions/build_context_ext.dart';
import 'package:sabani_tech_test/src/core/utils/constant/colors.dart';
import 'package:sabani_tech_test/src/features/home/presentation/controllers/file_provider.dart';

class ChooseAttachmentWidget extends StatefulHookConsumerWidget {
  const ChooseAttachmentWidget({super.key});

  @override
  ConsumerState<ChooseAttachmentWidget> createState() =>
      _ChooseAttachmentWidgetState();
}

class _ChooseAttachmentWidgetState
    extends ConsumerState<ChooseAttachmentWidget> {
  String filePath = '';
  File fileData = File('');

  Future<dartz.Either<String, String>> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'mp4',
        'pdf',
        'doc',
      ],
    );

    try {
      if (result != null) {
        setState(() {
          fileData = File(result.files.single.path!);
          filePath = result.files.single.name;
          ref.read(fileProvider.notifier).state = fileData;
        });
        return dartz.right('Choose Attachment Success');
      } else {
        return dartz.left('Attacment Not Choosen');
      }
    } catch (e) {
      return dartz.left('Attacment Not Choosen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attachment',
          style: TextStyle(
            color: Color(0xFF484848),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Gap(8),
        GestureDetector(
          onTap: () async {
            final file = await pickFile();
            file.fold(
              (error) => context.showErrorSnackbar(error),
              (success) => context.showSuccessSnackbar(success),
            );
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                const Gap(14),
                const Icon(
                  Icons.file_copy_outlined,
                  color: AppColors.grey,
                ),
                const Gap(14),
                Flexible(
                  child: Text(
                    maxLines: 1,
                    filePath == '' ? 'Choose Attachment' : filePath,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF777373),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                if (filePath != '')
                  IconButton(
                    onPressed: () {
                      setState(() {
                        filePath = '';
                        fileData = File('');
                        ref.read(fileProvider.notifier).state = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.primaryRed,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
