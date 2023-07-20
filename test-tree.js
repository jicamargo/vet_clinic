/**** version 1: using while *********/
function leftmostNodesSum(array) {
  let total = 0;
  let index = 0;
  while (index < array.length) {
    total += array[index];
    index = index * 2 + 1;
  };
  return total;
};

/**** version 2: using recursion *********/
function leftmostNodesSum_recursive(array) {
  function traverse_array (index) {
    if (index >= array.length) {
      return 0;
    }
    return array[index] + traverse_array(index * 2 + 1);
  }  
  return traverse_array(0);
};


console.log(leftmostNodesSum([2, 7, 5, 2, 6, 0, 9]))
// => 11

console.log(leftmostNodesSum([1, 7, 5, 2, 6, 0, 9, 3, 7, 5, 11, 0, 0, 4, 0]))
// => 13


console.log(leftmostNodesSum_recursive([2, 7, 5, 2, 6, 0, 9]))
// => 11

console.log(leftmostNodesSum_recursive([1, 7, 5, 2, 6, 0, 9, 3, 7, 5, 11, 0, 0, 4, 0]))
// => 13

