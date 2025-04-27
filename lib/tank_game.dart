import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class TankGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Thêm logic khởi tạo game ở đây
    print('Game đã tải xong!');
  }
}
