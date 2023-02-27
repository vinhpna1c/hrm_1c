String formatDouble(double d) {
  double ret = d;
  double error = ret - ret.floor();
  print(error);
  if (error < 0.1) {
    return ret.toInt().toString();
  }
  return d.toStringAsFixed(1);
}
