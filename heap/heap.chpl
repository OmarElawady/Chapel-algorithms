module Heap{

use List;
class Heap{
  var lst: list;
  type eltType;
  proc init(type eltType) {
    lst = new list(eltType);
    this.eltType = eltType;
  }

  proc push(el: eltType) {
    lst.append(el);
    sift_up(lst.size);
  }

  proc sift_up(idx: int) {
    if idx == 1 {
      return;
    }
    var parent_idx: int = parent(idx);
    ref current_elem: int = lst[idx];
    ref parent_elem: int = lst[parent_idx];
    if current_elem < parent_elem {
      current_elem <=> parent_elem;
      sift_up(parent_idx);
    }
  }

  proc top(): eltType {
    return lst[lst.size];
  }

  proc pop(): eltType throws {
    var last_idx: int = lst.size;
    ref last_elem: int = lst[last_idx];
    ref first_elem: int = lst.first();
    var return_value: eltType = first_elem;
    first_elem <=> last_elem;
    sift_down(1);
    lst.pop();
    return return_value;
  }

  proc sift_down(idx: int) {
    var left_child_idx: int = left_child(idx);
    var right_child_idx: int = right_child(idx);
    ref parent_value: eltType = lst[idx];
    var triangle_min: eltType = parent_value;
    var triangle_min_idx: int = idx;
    if left_child_idx < lst.size && lst[left_child_idx] < triangle_min {
      triangle_min = lst[left_child_idx];
      triangle_min_idx = left_child_idx;
    }

    if right_child_idx < lst.size && lst[right_child_idx] < triangle_min {
      triangle_min = lst[right_child_idx];
      triangle_min_idx = right_child_idx;
    }

    if triangle_min_idx != idx {
      lst[idx] <=> lst[triangle_min_idx];
      sift_down(triangle_min_idx);
    }
  }

  proc size(){
    return lst.size;
  }
  
  proc parent(idx: int): int {
    return idx / 2;
  }

  proc left_child(idx: int): int {
    return idx * 2;
  }

  proc right_child(idx: int): int {
    return idx * 2 + 1;
  }
}
}
