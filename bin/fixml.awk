#!/usr/bin/gawk -f
{
	foo = $0
	if (match($0, "\\<if\\>") || match($0, "\\<while\\>") || match($0, "\\<elseif\\>")) {  
		foo = gensub(/([^&])&([^&])/, "\\1\\&\\&\\2", "g", foo);
		foo = gensub(/([^\|])\|([^\|])/, "\\1\\|\\|\\2", "g", foo);
		if (foo != $0) {
			printf("making short-circuit substitution, %20.20s, line %i.\n", FILENAME, NR) > "/dev/stderr";
			printf("  ORIG:  %s\n", $0)  > "/dev/stderr";
			printf("  NOW :  %s\n", foo)  > "/dev/stderr";
		}
	}
	print foo
}
	
