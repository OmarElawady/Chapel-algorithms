module FFT{

use Math;
private var dm: domain(1);

private proc intlog(n: int): int{
  var lg = 0;
  while (1 << lg) < n do
    lg += 1;
  return lg;
}

private proc rev(in x: int, in lgn: int): int{
  var res = 0;
  while lgn > 0 {
    res = 2 * res + (x & 1);
    x /= 2;
    lgn -= 1;
  }
  return res;
}


proc fft(arr: [?D] complex) : [D] complex throws {
  var n = arr.size;
  if n & (n - 1) != 0 {
    throw new owned IllegalArgumentError("The size of the vector must be a power of 2");
  }
  dm = {0..#n};
  var lgn = intlog(n);
  var perm: [0..#n] complex;
  for i in 0..#n do
    perm[i] = arr[rev(i, lgn)];
  for s in 1..lgn {
    var m = (1 << s);
    
    var wm: complex = exp(-2i * pi / m);
    for k in 0..#n by m {
      var w: complex = 1;
      for j in 0..#(m/2) {
        var t = w * perm[k + j + m / 2];
        var u = perm[k + j];
        perm[k + j] = u + t;
        perm[k + j + m / 2] = u - t;
        w = w * wm;
      }
    }
  }
  return perm;
}

proc ifft(in arr: [?D] complex) : [D] complex throws {
  var n = arr.size;
  for e in arr do
    e.im *= -1;
  var res = fft(arr);
  for e in res {
    e /= n;
    e.im *= -1;
  }
  return res;
}
}
