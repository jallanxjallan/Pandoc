$if(titleblock)$
$titleblock$


$endif$
$for(header-includes)$
$header-includes$

$endfor$
$for(include-before)$
$include-before$

$endfor$
$if(toc)$
$table-of-contents$

$endif$
**$date$ - $location$**
$body$
$for(include-after)$

$include-after$
$endfor$
