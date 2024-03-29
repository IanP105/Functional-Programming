(* 
SML 2
*)

(* #0 - length helper*)

(*Helper function that is used multiple times throughout this file.*)
(*The base case of length is 0 and the recursive call determines the
list length by adding 1 to the tail length of the same list.
It returns an integer representing the length of that list.*)
fun length(nil) = 0
| length(list) = 1 + length(tl list);


(* #1 - quicksort *)

(*I was unable to complete quicksort or its helper function.
I have included my attempt at the code below.
I left the dummy implementation in place, but despite this,
the test file seems to still fail at this function.*)

(*
fun partition(list) =
  let val pivot = hd(list)
  in
    if hd(tl(list)) < pivot
    then "recursively create lists to the left"
    else {recursively create lists to the right}
*)

(*The base case of quicksort is ... and the recursive call will ...*)
fun quicksort x:int list = nil;


(* #2 - member *)

(*The base case of member is an empty list.  The recursive call occurs
if the item you are searching for is not already the first item in the list.
If it is not the first item, then the functon will recursively check
every subsequent item in the list to see if it matches the value that
is being searched for.  It then returns a boolean.*)
fun member([], _) = false
| member(first::rest, x) = if x = first then true else member(rest, x);
               
               
(* #3 - returns the union of sets (lists) s1 and s2*)

(*The base cases of union handle both lists being empty, only one empty, and only the other being empty.
In the case that both provided lists are non-empty, the function will check if the first item of set1 can be found in set2.
If not, it will recursively cons that value to set2 and then take the union of that new set and the remainder of set1.
If first item of set1 can be found in set2, then it will recursively union the remainder of set1 and set2.
This way, it avoids duplication for values that are a part of both sets.  It finds all of set2 either way.
But only finds the values of set1 that are not present in set2.  Returns a list.*)
fun union(nil,nil) = nil
|union(s1,nil) = s1
|union(nil,s2) = s2
|union(first1::rest1, s2) =
if member(s2, first1) = false then union(rest1, first1 :: s2) else union(rest1, s2);


(* #4 - returns the intersection of sets (lists) s1 and s2 *)

(*The base case of intersection is an empty list.  The function checks if a value in set1 is in set 2, and if so, will
recursively cons it into the inersection of the remainder of set1 and all of set 2.  If the value is not present in both sets,
then the intersection is taken of set1 [without that particular value] and set2.  Reutrns a list.*)
fun intersection(nil,nil) = nil
|intersection(s1,nil) = nil
|intersection(nil,s2) = nil
|intersection(first1::rest1, s2) =
if member(s2,first1) = true then first1 :: intersection(rest1,s2) else intersection(rest1, s2);


(* #5 - Return list of integers from start (inclusive) to stop (exclusive) by step *)

(*The base case of range is an empty list.  The recursive call will recursively cons the starting number into
a list and then increment that starting number up by the step size. [so long as stop is not <= start] Returns a list.*)
fun range(_, _, 0) = []
| range (start, stop, step) = if stop <= start then [] else start :: range(start+step, stop, step);


(* #6 - Return a slice of a list between indices start inclusive, and stop exclusive. Assume first element of list is at index 0*)

(*Helper - The base case of nthElement is the head of the list being passed to it.  The recursive call will recurse through the
tail of the list, reducing n by 1 each time.  This will find the value at index n in the list.  Returns a value.*)
fun nthElement(list,n) =
if n=0 then hd(list) else nthElement(tl(list),n-1);

(*The base case of slice is an empty list.  The recursive call finds the values in the list between points x and y[non-inclusive]
and returns those points in the form of a list.  It does this by consing that value into the list and then incrementing x by 1
when performing the slice.  Returns a list.*)
fun slice([],_,_) = []
| slice(list,x,y) = if x = y then [] else nthElement(list,x)::slice(list,x+1,y);


(* #7 - binary search *)

(*Helper - The base case of mid is a tuple of (0,0).  This function has no recursivity.  Returns a tuple of the
middle index of the list and the value at that index.*)
fun mid(list) =
if list = nil then (0, 0) else (length(list) div 2, nthElement(list, length(list) div 2));

(*The base case of binarySearch is a boolean [false], signifying that no searched value will be found in an empty list, nor will it be
found in a list of length one unless that one value is the very same value being searched for.  If the value at the middle of the list
is greater than the value being searched for, then the list is recursively sliced, generating multilple lists that consist of elements
from 0 to to the given index.  If the value at the middle is not greater than the value being searched for, then the recursive lists
being generated will contain values from the index up until the end of the list.  Returns a boolean, true if item is found in list, false otherwise.*)
fun binarySearch([],_) = false
| binarySearch([a],b) = a = b
| binarySearch(list,x) =
  let val (index, value) = mid(list)
  in if x < value then binarySearch(slice(list,0,index),x) else binarySearch(slice(list,index,length(list)), x)
  end;
