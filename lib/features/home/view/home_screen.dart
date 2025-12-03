import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/features/home/controller/home_screen_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) {
        return BaseScaffold(
          usePaddingHorizontal: false,
          title: 'AI Image Generator',
          contentMobile: _contentMobile(controller),
        );
      },
    );
  }

  Widget _contentMobile(HomeScreenController controller) {
    return Container(
      color: ColorPalette.white,
      child: Column(
        children: [
          
          Container(
            padding: Dimens.paddingBase,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorPalette.greenTheme.withOpacity(0.1),
                  ColorPalette.greenTheme.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              children: [
                Dimens.marginVerticalMedium(),

                
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        onPressed: controller.pickImage,
                        icon: Icons.add_photo_alternate_outlined,
                        label: 'Upload',
                        color: ColorPalette.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(() => _buildActionButton(
                            onPressed: controller.loading.value ||
                                    controller.selectedImage.value == null
                                ? null
                                : () =>
                                    controller.handleGenerate(useDummy: true),
                            icon: Icons.auto_awesome_outlined,
                            label: 'Generate',
                            color: ColorPalette.greenTheme,
                          )),
                    ),
                  ],
                ),

                Dimens.marginVerticalMedium(),

                
                Obx(() {
                  if (controller.selectedImage.value != null) {
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: ColorPalette.greenTheme.withOpacity(0.5),
                            width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: ColorPalette.greenTheme.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.selectedImage.value!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorPalette.greenTheme,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle,
                                      color: ColorPalette.primary, size: 14),
                                  SizedBox(width: 4),
                                  Text(
                                    'Ready',
                                    style: TextStyle(
                                        color: ColorPalette.primary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),

          
          Obx(() => controller.error.value != null
              ? Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.error.value!,
                          style: TextStyle(
                              color: Colors.red.shade700, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()),

          
          Expanded(
            child: Obx(() {
              final images = controller.generatedImages;

              if (images.isEmpty) {
                return _buildEmptyState();
              }

              return Column(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${images.length} ${images.length == 1 ? 'Image' : 'Images'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            
                          },
                          icon: const Icon(Icons.download, size: 18),
                          label: const Text('Download All'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: images.length,
                      onPageChanged: controller.setCurrentPage,
                      itemBuilder: (context, index) {
                        final image = images[index];
                        return _buildImageCard(image, index, images.length);
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  
                  Obx(() => _buildDotsIndicator(
                      images.length, controller.currentPage.value)),

                  const SizedBox(height: 16),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isDisabled = onPressed == null;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey.shade300 : color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDisabled
            ? null
            : [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isDisabled
                      ? Colors.grey.shade500
                      : (color == ColorPalette.greenTheme
                          ? ColorPalette.primary
                          : Colors.white),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isDisabled
                        ? Colors.grey.shade500
                        : (color == ColorPalette.greenTheme
                            ? ColorPalette.primary
                            : Colors.white),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(Object image, int index, int totalImages) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _buildImageWidget(image),
          ),

          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          
          Positioned(
            bottom: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: ColorPalette.greenTheme,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorPalette.greenTheme.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.download_rounded,
                    color: ColorPalette.primary,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),

          
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ColorPalette.greenTheme.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: ColorPalette.primary.withOpacity(0.2), width: 1),
              ),
              child: Text(
                '${index + 1} / $totalImages',
                style: const TextStyle(
                  color: ColorPalette.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorPalette.greenTheme.withOpacity(0.2),
                  ColorPalette.greenTheme.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.collections_outlined,
              size: 64,
              color: ColorPalette.primary.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Generated Images',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload an image and tap generate\nto create AI-powered results',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotsIndicator(int count, int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) {
          final isActive = currentPage == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? ColorPalette.greenTheme : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: ColorPalette.greenTheme.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageWidget(Object image) {
    if (image is File) {
      return Image.file(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (image is String) {
      return Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return const SizedBox.shrink();
  }
}
