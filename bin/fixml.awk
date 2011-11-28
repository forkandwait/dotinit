
{
	foo = $0
	if (match($0, "[:space:]*if")){
		foo = gensub(/([^&])&([^&])/, "\\1\\&\\&\\2", "g", foo);
		foo = gensub(/([^\|])\|([^\|])/, "\\1\\|\\|\\2", "g", foo);
		if (foo != $0) {
			printf("making short-circuit substitution, %20.20s, line %i.\n", FILENAME, NR) > "/dev/stderr";
			printf("  ORIG:  %s\n", $0)  > "/dev/stderr";
			printf("  NOW :  %s\n", foo)  > "/dev/stderr";
		}
	}
	if (match($0, "\<ismemberc\>")){
		foo = gensub(/\<ismemberc\>/, "ismember", "g", foo)
		printf("making ismemberc substitution, %20.20s, line %i.\n", FILENAME, NR) > "/dev/stderr";
	}
	print foo
}
	
