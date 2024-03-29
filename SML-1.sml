(* 
SML 1
*)

(* #1 - pow *)

(*The base case of pow is 0 and the recursive call multiplies the parameter a by b times.*)
fun pow (a, b) =
if b = 0 then 1 else a * pow (a, b-1);

(* #2 - sumTo *)

(*The base case of sumTo is 0 and the recursive call continuously adds fractions approaching 1.*)
fun sumTo (x:int) =
if x = 0 then 0.0 else (1.0/real(x)) + sumTo(x-1);


(* #3 - repeat *)

(*The base case of repeat is 0 and the recursive call repeates the given string n many times,
where n is a number specified by the user.  The repeat strings are concatinated together.*)
fun repeat (s, n) =
if n = 0 then "" else s ^ repeat(s, n-1);


(* #4 - binary *)

(*Helper - The base case of length is an empty list and the recursive call adds 1 to the value
of x for every item in a list, acting as a counter for the number of items in that list.*)
fun length x =
if null x then 0 else 1 + length(tl x);

(*Helper - The base case of binaryHelper is 0 and the recursive call repeatedly divides x by two
and concatinates to either 1 or 0 depending on the result.*)
fun binaryHelper x =
if x = 0 then "" else if (x mod 2) = 1 then "1" ^ binaryHelper(x div 2) else "0" ^ binaryHelper(x div 2);

(*The base case of binary counts up from 0 and then stops at 16 bits.  The recursive call does the following:
If the numbers passed into list x are not length 16, then repeatedly add 0 to the list y many times, where y is
the difference between 16 and the passed in length. [16 - length of x = remaining number of 0s to add]*)
fun binary x =
if length(explode(binaryHelper(x))) = 16 then binaryHelper(x) else repeat("0", 16 - (length(explode(binaryHelper(x))))) ^ binaryHelper(x);


(* #5 - countNegative *)

(*The base case of countNegative is an empty list and the recursive call continuously adds 1 to the
returned value for all numbers less than 0 and adds 0 to the return for all other numbers. [those greater than 0]*)
fun countNegative x =
if null x then 0 else if (hd x) < 0 then 1 + countNegative(tl x) else 0 + countNegative(tl x);


(* #6 - absList *)

(*Helper - The absListHelper function gets the absolute value of the two integers within a tuple.*)
fun absListHelper (x, y) =
(abs(x), abs(y));

(*The base case of absList is an empty list and the recursive call joins the tuples from the helper together into a list.*)
fun absList x = 
if null x then [] else absListHelper(hd x) :: absList(tl x);


(* #7 - split *)

(*Helper - The base case of splitHeader checks for an even number by calculating the remainder of x and 2.
The recursive call divides even numbers by two, making the first and second item in the tuple the same.
The recursive call then divides odd numbers by 2 for the first item in the tuple and then takes
x-(x/2) for the second item in the tuple, making it 1 greater than the first tuple item.*)
fun splitHelper x =
if x mod 2 = 0 then (x div 2, x div 2) else (x div 2, x - (x div 2));

(*The base case of split is an empty list and the recursive call adds the tuples from the helper
into a list by joining head to tail.*)
fun split x =
if null x then [] else splitHelper(hd x) :: split(tl x);


(* #8 - isSorted *)

(*The base case of isSorted is an empty list and the recursive call will continuously compare the current item in the list
to the next item in the list.  If the current item is larger than the next item, the list is not sorted, and false is returned.
The "trues" and "falses" are then compared with "andalso". [true and true and false and true] for example is false because
one of the elements is not in order.  So the list is not in order.*)
fun isSorted x =
if null x then true else if null (tl x) then true else if (hd x) > hd(tl x) then false andalso isSorted(tl x) else true andalso isSorted(tl x);

 
(* #9 - collapse *) 

(*The base case of collapse is an empty list and the recursive call adds the current item in the list to
the next item in groups of two until there is either zero or one itemsleft in the list.  In the case of zero,
the function completes. In the case of one remaining item, that remaining item itself is returned.*)
fun collapse x =
if null x then [] else if length(x) = 1 then x else (hd x) + hd(tl x) :: collapse(tl(tl x));


(* #10 - insert *)

(*The base case of insert is an empty list and the recursive call continuously joins the user's input, n, to the
tail of the list so long as it is not greater than the head, in which case it is added to the head.*)
fun insert (n, x) =
if null x then [n] else if n < (hd x) then n :: x else (hd x) :: insert(n, (tl x));


(* #11 - decimal *)

(*Helper - The base case of decimalHelper is 0 for either parameter a or b.
The recursive call multiplies the values of the tuple passed into the function by 2.*)
fun decimalHelper (a, b) =
if a = 0 then 0 else if b = 0 then 1 else 2 * decimalHelper(a, b-1);

(*The base case of decimal is the empty string and the recursive call continuously gets the ord of
the head of the exploded string, before passing it into the helper function.  Afterwards, 1 is
aubtracted from it.  The result is joined with the remaining characters in the string.*)
fun decimal (s:string) =
if null (explode s) then 0 else decimalHelper((ord(hd(explode(s)))) - ord(#"0"), (length(explode s)) -1) + decimal(implode(tl (explode s)));
