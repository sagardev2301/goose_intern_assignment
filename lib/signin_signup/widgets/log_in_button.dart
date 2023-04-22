import 'package:flutter/material.dart';

class LogInChip extends StatelessWidget {
  const LogInChip({super.key, required this.platform, this.onPressed});
  final String platform;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width * 0.8,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 35,
                  width: 35,
                  child: Image.asset('assets/images/$platform.png')),
              const SizedBox(
                width: 20,
              ),
              Text(
                'Continue with $platform',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
