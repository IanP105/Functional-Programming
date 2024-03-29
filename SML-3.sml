(* 
SML 3
*)

(* #1 - duplist *)

(*This function takes a list of any type and returns a new list with each element repeated twice.
foldr is used to iterate through the input list, right to left, and uses a function that takes each element,
represented as "x" and an accumulator "acc".  It then returns a new list of "x" repeating twice, followed by "acc".
"[]" is given to foldr to represent the initial value of the accumulator.*)
fun duplist lst =
	List.foldr (fn (first, acc) => first::first::acc) [] lst;

(* #2 - mylength *)

(*This function takes a list of any type and returns the number of elements in that list, represented as an integer.
foldr is used to iterate through the input list, right to left, and uses a function that takes each element,
represented as "_" and an accumulator "acc".  It then returns a new list of "acc" incremented by one.  "acc" is in
the initial state of 0, meaning an empty list.*)
fun mylength lst =
	List.foldr (fn (_, acc) => acc+1) 0 lst;

(* #3 - il2absrl *)

(*This function takes a list of integers and returns a list containing the absolute values of the elements of the input list, represented as reals.
map is used to iterate through the input list, using a function that takes each element, represented as "x".
It then returns a new list of the absolute values of each elment of the input list, represented as reals.
Real.abs function gets the absolute value and Real.fromInt converts the integer to a real.*)
fun il2absrl lst =
	List.map (fn x => Real.abs(Real.fromInt x)) lst;

(* #4 - myimplode *)

(*This function takes a list of characters and recursively uses foldr to concatenate each character of the list into the string "s".
The function fn, which is passed to foldr, takes a character "c" and a string "s", and then concatenates the character to the front of
the string using String.str and "^".  The accumulator's initial value is the empty string.  The function returns the fully concatenated string.*)
fun myimplode chars =
	foldr (fn (c, s) => String.str c ^ s) "" chars;

(* #5 - lconcat *)

(*This function takes a list of lists as input and returns a single list containing all of the combined values of the input list.
List.foldr is used to recursively fold the list, right to left.  Each of the input lists is appended to an accumulating list, "acc".
The initial value of "acc" is "[]", for an empty list.  Each input list is concatenated with the accumulating list with "@".*)
fun lconcat lst =
	List.foldr (fn (x, acc) => x @ acc) [] lst;

(* #6 - convert *)

(*This function traverses the input list of tuples, left to right, using foldl.  It starts with an accumulator that is a pair of empty lists.
At every recursion, the function will take the current pair, "(first1,first2)" and the accumulator "(acc1,acc2)" and returns a new accumulator
with "first1" added to the start of "acc1" and "first2" added to the start of "acc2".  The order of the lists in the pair is reversed so that they
reflect the original order of the elements.*)
fun convert tuple =
	let val (acc1, acc2) = foldl (fn ((first1, first2), (acc1, acc2)) => (first1::acc1, first2::acc2)) ([], []) tuple in (rev acc1, rev acc2) end;

(* #7 - mymap *)

(*This function uses the function "f" and the list "rest".  "f" is applied to each element of "rest".
foldr is used to iterate through "rest", right to left, consing every element of it into the accumulator, "acc".
The function returns the accumulator, now containing the mapped list.*)
fun mymap f rest =
	foldr (fn (first, acc) => f first::acc) [] rest;

(* #8 - myfoldl *)

(*This function takes the function "f", an initial value, and a list of elements.  The main function applies "f" to the head of the list
and the initialvalue.  It then applies "f" to the result of the previous operation and the next element of the list.  This is done
recursively until "f" has been applied to every element of the list.  The returned value is the result of applying "f" to
the last element of the list and to the accumulated value.*)
fun myfoldl f initialvalue nil = initialvalue
| myfoldl f initialvalue (head::tail) = myfoldl f (f(head,initialvalue)) tail;

(* #9 - sumSome *)

(*This function makes use of an internal helper function called sumSomeHelper, which iterates over the list and accumulates into "acc" the sum
of all the elements of the list that adhere to the input function "f".  The main function itself takes the input function "f" and returns the
inner function, taking a list as its input.*)
fun sumSome f lst =
	let
		fun sumSomeHelper [] acc = acc
		| sumSomeHelper (first::rest) acc =
			if f first then sumSomeHelper rest (first + acc)
			else sumSomeHelper rest acc
	in
		sumSomeHelper lst 0
	end;
