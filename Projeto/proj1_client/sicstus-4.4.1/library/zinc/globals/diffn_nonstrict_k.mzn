/** @group globals.packing
  Constrains \p k-dimensional boxes to be non-overlapping. For each box \p i
  and dimension \p j, \a box_posn[\p i, \p j] is the base position of the box
  in dimension \p j, and \a box_size[\p i, \p j] is the size in that dimension.
  Boxes whose size is 0 in at least one dimension can be packed anywhere.
*/
predicate diffn_nonstrict_k(array[int,int] of var int: box_posn,
                            array[int,int] of var int: box_size) =
    let { set of int: DIMS= index_set_2of2(box_posn) } in
    assert(index_set_2of2(box_size) = DIMS /\
           index_set_1of2(box_posn) = index_set_1of2(box_size),
           "diffn: index sets of arguments are incorrect",
     if card(DIMS)=1 then
       let {int: j = min(DIMS)} in 
         disjunctive([box_posn[b,j] | b in index_set_1of2(box_posn)],
	             [box_size[b,j] | b in index_set_1of2(box_posn)])
     else if card(DIMS)=2 then
       let {int: j = min(DIMS)} in 
         diffn_nonstrict([box_posn[b,j  ] | b in index_set_1of2(box_posn)],
	                 [box_posn[b,j+1] | b in index_set_1of2(box_posn)],
			 [box_size[b,j  ] | b in index_set_1of2(box_posn)],
			 [box_size[b,j+1] | b in index_set_1of2(box_posn)])
     else
	 forall(b1, b2 in index_set_1of2(box_posn) where b1 < b2)
	       (diffn_nonstrict_nonoverlap_k([ box_posn[b1,j] | j in DIMS ],   
					     [ box_size[b1,j] | j in DIMS ], 
					     [ box_posn[b2,j] | j in DIMS ],   
					     [ box_size[b2,j] | j in DIMS ] ) 
	       )
     endif endif
    );


predicate diffn_nonstrict_nonoverlap_k(array[int] of var int: x1, 
                                       array[int] of var int: w1, 
                                       array[int] of var int: x2, 
                                       array[int] of var int: w2) = 
    exists(j in index_set(x1))
        (w1[j] = 0 \/ w2[j] = 0 \/ x1[j] + w1[j] <= x2[j] \/ x2[j] + w2[j] <= x1[j]);
