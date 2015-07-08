
function idx = findElement(n, V),

	% Function which finds scalar n in vector V
	% V(1) should contain number of elements in V
	% Returns the index of first occurence of n in V
	% Returns -1 if n is not present in V
	
	idx = -1;
	
	lengthV = V(1);	% Number of elements currently stored in V
	
	% Use linear search
	for i = [2:1 + lengthV],
		if (V(i) == n)
			idx = i;
			break;
		end;
	end;
	
end;
	
