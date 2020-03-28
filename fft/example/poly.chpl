use FFT;

proc resize_arr(arr:[] complex, n: int) {
  var D: domain(1) = {0..#n};
  var res: [D] complex;
  if n < arr.size {
    for i in 0..#n do
      res[i] = arr[i];
  }else{
    for i in 0..#(arr.size) {
      res[i] = arr[i];
    }
    for i in (arr.size)..(n - 1) {
      res[i] = 0;
    }
  }
  return res;
}

proc calc_nearest_power(n: int) {
  var res: int = 1;
  while res < n do
    res *= 2;
  return res;
}

proc multiply_polynomials(p1: [] complex, p2: [] complex) {
  var n1 = p1.size, n2 = p2.size;
  var result_length = n1 + n2;
  var max_n = max(n1, n2);
  var nearest_2_power = calc_nearest_power(max_n);
  var resized_p1 = resize_arr(p1, 2 * nearest_2_power);
  var resized_p2 = resize_arr(p2, 2 * nearest_2_power);
  var dft1 = fft(resized_p1);
  var dft2 = fft(resized_p2);
  var mul = dft1 * dft2;
  var result_p = resize_arr(ifft(mul), result_length);
  return result_p;
}

proc print_pol(p: [?D] complex){
  for i in D {
    if i != 0 {
      write(" + ");
    }
    write(round(p[i].re): int);
    if i != 0 {
      write("x^");
      write(i);
    }
  }
  writeln("");
}
var D: domain(1) = {0..#4};
var p1: [D] complex = [1, 4, 2, 3]; // 1 + 4x + 2x^2 + 3x^3
var p2: [D] complex = [0, 1, 2, 0]; // x + 2x^2
var res = multiply_polynomials(p1, p2);

writeln("The result of multiplying");
print_pol(p1);
writeln("and");
print_pol(p2);
writeln("is");
print_pol(res);

writeln("You might not have noticed it but this takes ~ 4 * log(4) operations instead of 4 * 4 ");
