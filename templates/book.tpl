$if(context-lang)$
\mainlanguage[$context-lang$]
$endif$
$if(context-dir)$
\setupalign[$context-dir$]
\setupdirections[bidi=on,method=two]
$endif$
% Enable hyperlinks
\setupinteraction
  [state=start,
$if(title)$
  title={$title$},
$endif$
$if(subtitle)$
  subtitle={$subtitle$},
$endif$
$if(author)$
  author={$for(author)$$author$$sep$; $endfor$},
$endif$
$if(keywords)$
  keyword={$for(keywords)$$keywords$$sep$; $endfor$},
$endif$
  style=$linkstyle$,
  color=$linkcolor$,
  contrastcolor=$linkcontrastcolor$]

% make chapter, section bookmarks visible when opening document
\placebookmarks[chapter, section, subsection, subsubsection, subsubsubsection, subsubsubsubsection][chapter, section]
\setupinteractionscreen[option=bookmark]

$if(papersize)$
\setuppapersize[$for(papersize)$$papersize$$sep$,$endfor$]
$endif$
$if(layout)$
\setuplayout[$for(layout)$$layout$$sep$,$endfor$]
$endif$
$if(pagenumbering)$
\setuppagenumbering[$for(pagenumbering)$$pagenumbering$$sep$,$endfor$]
$else$
\setuppagenumbering[location={footer,middle}]
$endif$
$if(pdfa)$
% attempt to generate PDF/A
\setupbackend
  [format=PDF/A-$pdfa$,
   profile={$if(pdfaiccprofile)$$for(pdfaiccprofile)$$pdfaiccprofile$$sep$,$endfor$$else$sRGB.icc$endif$},
   intent=$if(pdfaintent)$$pdfaintent$$else$sRGB IEC61966-2.1$endif$]
$endif$
\setupbackend[export=yes]
\setupstructure[state=start,method=auto]

% use microtypography
\definefontfeature[default][default][script=latn, protrusion=quality, expansion=quality, itlc=yes, textitalics=yes, onum=yes, pnum=yes]
\definefontfeature[smallcaps][script=latn, protrusion=quality, expansion=quality, smcp=yes, onum=yes, pnum=yes]
\setupalign[hz,hanging]
\setupitaliccorrection[global, always]

\setupbodyfontenvironment[default][em=italic] % use italic as em, not slanted

\definefallbackfamily[mainface][rm][CMU Serif][preset=range:greek, force=yes]
\definefontfamily[mainface][rm][$if(mainfont)$$mainfont$$else$Latin Modern Roman$endif$]
\definefontfamily[mainface][mm][$if(mathfont)$$mathfont$$else$Latin Modern Math$endif$]
\definefontfamily[mainface][ss][$if(sansfont)$$sansfont$$else$Latin Modern Sans$endif$]
\definefontfamily[mainface][tt][$if(monofont)$$monofont$$else$Latin Modern Typewriter$endif$][features=none]
\setupbodyfont[mainface$if(fontsize)$,$fontsize$$endif$]

\setupwhitespace[$if(whitespace)$$whitespace$$else$medium$endif$]
$if(indenting)$
\setupindenting[$for(indenting)$$indenting$$sep$,$endfor$]
$endif$
$if(interlinespace)$
\setupinterlinespace[$for(interlinespace)$$interlinespace$$sep$,$endfor$]
$endif$

\setuphead[chapter]            [style=\tfd,header=empty]
\setuphead[section]            [style=\tfc]
\setuphead[subsection]         [style=\tfb]
\setuphead[subsubsection]      [style=\bf]
\setuphead[subsubsubsection]   [style=\sc]
\setuphead[subsubsubsubsection][style=\it]

$if(headertext)$
\setupheadertexts$for(headertext)$[$headertext$]$endfor$
$endif$
$if(footertext)$
\setupfootertexts$for(footertext)$[$footertext$]$endfor$
$endif$
$if(number-sections)$
$else$
\setuphead[chapter, section, subsection, subsubsection, subsubsubsection, subsubsubsubsection][number=no]
$endif$

\definedescription
  [description]
  [headstyle=bold, style=normal, location=hanging, width=broad, margin=1cm, alternative=hanging]

\setupitemize[autointro]    % prevent orphan list intro
\setupitemize[indentnext=no]

\setupfloat[figure][default={here,nonumber}]
\setupfloat[table][default={here,nonumber}]

\setupthinrules[width=15em] % width of horizontal rules

\setupxtable[frame=off]
\setupxtable[head][topframe=on,bottomframe=on]
\setupxtable[body][]
\setupxtable[foot][bottomframe=on]

$if(csl-refs)$
\definemeasure[cslhangindent][1.5em]
\definenarrower[hangingreferences][left=\measure{cslhangindent}]
\definestartstop [cslreferences] [
	$if(csl-hanging-indent)$
	before={%
	  \starthangingreferences[left]
      \setupindenting[-\leftskip,yes,first]
      \doindentation
  	},
  	after=\stophangingreferences,
	$endif$
]
$endif$
$if(includesource)$
$for(sourcefile)$
\attachment[file=$curdir$/$sourcefile$,method=hidden]
$endfor$
$endif$
$for(header-includes)$
$header-includes$
$endfor$

\starttext
$if(title)$
\startalignment[middle]
  {\tfd\setupinterlinespace $title$}
$if(subtitle)$
  \smallskip
  {\tfa\setupinterlinespace $subtitle$}
$endif$
$if(author)$
  \smallskip
  {\tfa\setupinterlinespace $for(author)$$author$$sep$\crlf $endfor$}
$endif$
$if(date)$
  \smallskip
  {\tfa\setupinterlinespace $date$}
$endif$
  \bigskip
\stopalignment
$endif$
$if(abstract)$
\midaligned{\it Abstract}
\startnarrower[2*middle]
$abstract$
\stopnarrower
\blank[big]
$endif$
$for(include-before)$
$include-before$
$endfor$
$if(toc)$
\completecontent
$endif$
$if(lot)$
\completelistoftables
$endif$
$if(lof)$
\completelistoffigures
$endif$

$body$

$for(include-after)$
$include-after$
$endfor$
\stoptext
