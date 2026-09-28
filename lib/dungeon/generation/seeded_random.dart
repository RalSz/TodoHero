class SeededRandom {
  int _state;
  SeededRandom(int seed) : _state = seed == 0 ? 0xA5A5A5A5 : seed;

  int nextInt(int max) {
    _state ^= (_state << 13) & 0xFFFFFFFF;
    _state ^= _state >> 17;
    _state ^= (_state << 5) & 0xFFFFFFFF;
    _state &= 0xFFFFFFFF;
    
    return _state % max;
  }

  double nextDouble() => nextInt(1 << 20) / (1 << 20);

  bool nextBool([double chance = 0.5]) => nextDouble() < chance;
}