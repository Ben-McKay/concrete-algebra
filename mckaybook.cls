\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mckaybook}[2013/01/25 McKay book LaTeX package for the memoir class]
% Use: 
%    \documentclass{mckaybook}
%    \Title{Odyssey}
%    \Author{Homer}
%    \Location{Ancient Greece}
%    \BibliographyFile{odyssey} % The name of the .bib file, without file extension.
%    \begin{document}
%    \chapter{Preface}
%    % Include the stuff that goes before the table of contents, like the preface, here.
%    \afterpreface
%    % Now put in the chapters, with only first letter capitalised.
%    \chapter{How it all started}
%    It all started ...
%    .
%    .
%    .
%    We can define a term like \emph{hamster}\define{hamster},
%    or say that the term hamster appears again later\SubIndex{hamster}.
%    We add notation like \Notation{omega}{\omega}{A variable called $\omega$}.
% 
%    We add problems by:
%    \begin{problem}{label.for.the.first.problem}
%    What is the point of your life?
%    \end{problem}
%    and answers by:
%    \begin{answer}{label.for.the.first.problem}
%    Your life is pointless.
%    \end{answer}
%    In problem~\ref{problem:label.for.the.first.problem}, we can clearly see ...
%    You have the usual theorem environments, like \texttt{amsthm}.
%    You also have a nice improvement on the \texttt{pmatrix} enviroment:
%    \begin{pmatrix}[1.5] % Optional increase of spacing between rows.
%    1 & 0 \\
%    0 & 1
%    \end{pmatrix}
%    \chapter{The Final Chapter}
% The end.
% \end{document}


\DeclareOption{ContainsChinese}{\def\ChineseTextInThisDocument{}}
\DeclareOption*{%
\PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax

\LoadClass{memoir}

\RequirePackage{xparse}

\def\emptystring{}

\edef\mckaybook@title{\emptystring}
\edef\mckaybook@subtitle{\emptystring}
\edef\mckaybook@author{\emptystring}
\edef\mckaybook@location{\emptystring}
\edef\mckaybook@bibliography{\emptystring}

\NewDocumentCommand\Title{m}{\global\def\mckaybook@title{#1}}
\NewDocumentCommand\Subtitle{m}{\global\def\mckaybook@subtitle{#1}}
\NewDocumentCommand\Author{m}{\global\def\mckaybook@author{#1}}
\NewDocumentCommand\Location{m}{\global\def\mckaybook@location{#1}}
\NewDocumentCommand\BibliographyFile{m}{\global\def\mckaybook@bibliography{#1}}

% For handling names like Benjamin McKay, where the letter c should be raised up, type in as Benjamin \scotsMc{}Kay.
\makeatletter
\DeclareRobustCommand{\scotsMc}{\scotsMcx{c}}
\DeclareRobustCommand{\scotsMC}{\scotsMcx{\textsc{c}}}
\DeclareRobustCommand{\scotsMcx}[1]{%
  M%
  \raisebox{\dimexpr\fontcharht\font`M-\height}{%
    \check@mathfonts\fontsize{\sf@size}{0}\selectfont
    \kern.3ex\underline{\kern-.3ex #1\kern-.3ex}\kern.3ex
  }%
}
\expandafter\def\expandafter\@uclclist\expandafter{%
  \@uclclist\scotsMc\scotsMC
}
\makeatother

\RequirePackage{etex}
% Before we load any packages, we must load etex,
% in order to allow more than 256 registers,
% because this book has a lot of dimensions.

\RequirePackage[orthodox,l2tabu]{nag}		% Complain about common TeX errors
\RequirePackage[mathletters]{ucs}			% Unicode characters
\RequirePackage{newunicodechar}

\ifdefined\ChineseTextInThisDocument
\RequirePackage[utf8]{inputenc} % Default input file encoding
\RequirePackage{CJKutf8}
\let\I\relax
\NewDocumentCommand\Chinese{m}{\begin{CJK*}{UTF8}{gbsn}#1\end{CJK*}}
\else 
\RequirePackage[utf8x]{inputenc} % Default input file encoding
\fi

\RequirePackage[T1]{fontenc}		% Default font encoding
\RequirePackage{strict}
\RequirePackage{lmodern}			% Nice fonts.
\RequirePackage{fixmath}			% Make Greek letters look right.
\RequirePackage[mathscr]{eucal}

\RequirePackage[%
activate={true,nocompatibility},%
final,%
tracking=true,%
kerning=true,%
spacing=true,%
factor=1100,%
stretch=10,%
shrink=10]{microtype}
\microtypecontext{spacing=nonfrench}

%% American Mathematical Society symbols, theorem and
%% commutative diagram packages.
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{braket}
\RequirePackage{mathtools}
\mathtoolsset{showonlyrefs,showmanualtags,centercolon,mathic}

% If we need more room between rows of matrices and arrays, we can write
% \begin{pmatrix}[1.5]
% instead of 
% \begin{pmatrix}
\makeatletter
\RenewDocumentCommand\env@matrix{O{\arraystretch}}
{%
\edef\arraystretch{#1}%
  \hskip -\arraycolsep
  \let\@ifnextchar\new@ifnextchar
  \array{*\c@MaxMatrixCols c}
}%
\makeatother
\NewDocumentCommand\tallmatrix{}{1.5}

\RequirePackage{varioref}		% References to sections and theorems with page numbering.
\RequirePackage{longtable}		% Tables
\RequirePackage{multicol}		% Multiple columns
\setmarginnotes{2em}{3cm}{.5cm}

% Indices
\newcommand{\NotationIndexName}{List of notation}
\makeindex
\makeglossary[not]
\changeglossnum[not]{\thepage}
\changeglossnumformat[not]{|hyperpage}%% for hyperlinks
\renewcommand*{\glossaryname}{\NotationIndexName}
\renewcommand*{\glossarymark}{\markboth{\glossaryname}{}}
\renewcommand{\begintheglossaryhook}
{%
\begin{longtable}[c]{lp{9cm}}%
\endfirsthead%
\endhead%
\endfoot%
\endlastfoot%
}%
\renewcommand{\atendtheglossaryhook}
{%
\end{longtable}%
}%
\renewcommand{\glossitem}[4]{#1 & #2, #4 \\[4pt]}
\renewcommand{\glossaryspace}{}
\newcommand{\paddedpagenumber}%
% Returns the current page number, zero padded, 
% so page 3 is 003, page 12 is 012, page 101 is 101
{%%
\ifnum\value{page}<100 0\fi%
\ifnum\value{page}<10 0\fi%
\arabic{page}%
}%%

\newcounter{howmany@notation}
\setcounter{howmany@notation}{0}
\newcommand{\Notation}[3]%%
%%use: \Notation{Nonmathmode token for comparing}{math mode expression}{description}
{\glossary[not](\paddedpagenumber){\(#2\)}{#3}%
\stepcounter{howmany@notation}%
}

\newcounter{howmany@indexentries}
\setcounter{howmany@indexentries}{0}
\newcommand{\SubIndex}[1]%
{%
\stepcounter{howmany@indexentries}%
\index{#1}%
}%
% There is a serious problem with Notation. You can't
% use absolute value signs or floor or ceiling signs anywhere. Replace them
% with the following:
\newcommand{\leftAbs}{\left"|}
\newcommand{\rightAbs}{\right"|}
\newcommand{\leftDoubleAbs}{"| "| }
\newcommand{\rightDoubleAbs}{"| "| }
\newcommand{\normNotation}[1]{\leftDoubleAbs#1\rightDoubleAbs}
\newcommand{\orderForNotationIndex}[1]{\leftAbs{#1}\rightAbs}
\newcommand{\lengthForNotationIndex}[1]{\leftDoubleAbs{#1}\rightDoubleAbs}
\newcommand{\normForNotationIndex}[1]{\leftDoubleAbs{#1}\rightDoubleAbs}
\newcommand{\lcl}{
\rule[-2.5pt]{.4pt}{1em}
\rule[6.4pt]{2pt}{.4pt}
}
\newcommand{\rcl}{
\rule[6.4pt]{2pt}{.4pt}
\rule[-2.5pt]{.4pt}{1em}
}
\newcommand{\lflr}{
\rule[-2.5pt]{.4pt}{1em}
\rule[-2.5pt]{2pt}{.4pt}
}
\newcommand{\rflr}{
\rule[-2.5pt]{2pt}{.4pt}
\rule[-2.5pt]{.4pt}{1em}
}
\newcommand{\ceilForNotationIndex}[1]{\lcl{#1}\rcl}
\newcommand{\floorForNotationIndex}[1]{\lflr{#1}\rflr}

% For the subject index:
% Example:
%    \define{interest rate}
% puts into the Subject index a reference
% to the current page saying that this is
% where the term ``interest rate'' is defined.
\newcommand{\FancyIndexEntry}[1]{\emph{\textbf{\hyperpage{#1}}}}
\newcommand{\define}[1]
{%
\stepcounter{howmany@indexentries}%
\index{#1|FancyIndexEntry}%
}%
%% PDF Output
\ifpdf
  \pdfoutput=1
  \makeatletter
  \RequirePackage[plainpages=false,
    hyperfigures,
    pdftitle={\mckaybook@title},
    pdfauthor={\mckaybook@author},
    colorlinks=true,
    pdfpagelabels=true,
    bookmarksnumbered,
    hidelinks,
    pagebackref,
    pdftex]
    {hyperref}
  \makeatother
  \RequirePackage{memhfixc}
% Hyperref uses very bright colours to highlight links. Change them:
  \RequirePackage[svgnames]{xcolor}
  \definecolor{dark-red}{rgb}{0.4,0.15,0.15}
  \definecolor{dark-blue}{rgb}{0.15,0.15,0.4}
  \definecolor{medium-blue}{rgb}{0,0,0.5}
  \hypersetup{
    colorlinks, linkcolor={dark-red},
    citecolor={dark-blue}, urlcolor={medium-blue}
  }
\fi

\newcommand{\idxmark}[1]{#1\markboth{#1}{#1}}
\newcommand{\doidxbookmark}[1]{{\def\@tempa{Symbols}\def\@tempb{#1}%
\ifx\@tempa\@tempb %
Analphabetics
\phantomsection%
\pdfbookmark[0]{Analphabetics}{Analphabetics-idx}%
\else
#1%
\phantomsection%
\pdfbookmark[0]{#1}{#1-idx}%
\fi%
\vskip\onelineskip\par}}

\newcommand\doglobookmark[1]{%
}%

%......Figures
\newcommand{\stdFigSize}{1in}
\newsubfloat{figure} % Memoir class, instead of subfigure class.
\let\subfigure\subbottom
\newcommand{\subfigcapskip}{3em}
\setfloatadjustment{figure}{\scriptsize\centering}
\setfloatadjustment{marginfigure}{\scriptsize\centering}
\setmpjustification{\scriptsize\RaggedLeft}{\scriptsize\RaggedRight}
\captionnamefont{\scriptsize}
\captiontitlefont{\scriptsize}
\newcommand{\heading}{\sffamily}

\newcommand{\chapterSummary}[1]{{\small{#1}}\vspace{0.5cm}}

\makechapterstyle{bobo}{%
\aliaspagestyle{part}{empty}
\renewcommand{\partnamefont}{\raggedleft\normalfont\huge\heading}
\renewcommand{\partnumfont}{\normalfont\huge\heading}
\renewcommand{\printpartnum}{}
\renewcommand{\partname}{}
\renewcommand*{\parttitlefont}{\huge\heading}
\setlength{\beforechapskip}{0pt}
\renewcommand*{\chapnamefont}{\large\centering}
\renewcommand*{\chapnumfont}{\large}
\renewcommand*{\printchapternonum}{%
\vphantom{\printchaptername}%
\vphantom{\chapnumfont 1}%
\afterchapternum}
\renewcommand*{\chaptitlefont}{\Large\heading}
\renewcommand*{\printchaptertitle}[1]{%
\centering\smallcolouredbox\chaptitlefont ##1}}

\chapterstyle{bobo}

\setsecheadstyle{\large\heading\raggedright}
\setsubsecheadstyle{\heading\raggedright}
\setsubsubsecheadstyle{\heading\raggedright}

%\setheadfoot{14pt}{14pt}
\setheadfoot{2\onelineskip}{3\onelineskip}

\newcommand{\optionalSection}[1]%
{%%
\section{#1}
{\small{This section can be omitted without loss of continuity.}}%
\medskip\par\noindent%
}%%

%......Table of contents
% depth of numbering of sectioning commands:
\setsecnumdepth{chapter}
\maxsecnumdepth{chapter}
%% depth of table of contents:  
\setcounter{tocdepth}{0}

\RenewDocumentCommand\cftpartfont{}{\heading\small}
\RenewDocumentCommand\cftpartpagefont{}{\normalfont\small}

\RenewDocumentCommand\cftchapterfont{}{\heading\small}
\RenewDocumentCommand\cftchapterpagefont{}{\normalfont\small}

\setlength{\cftbeforechapterskip}{3pt}
\RenewDocumentCommand\cftchapterleader{}{\quad}
\setpnumwidth{1em}
\RenewDocumentCommand\cftchapterafterpnum{}{\cftparfillskip}

\setlength{\cftbeforepartskip}{10pt}
\RenewDocumentCommand\cftpartleader{}{\quad}
\setpnumwidth{1em}
\RenewDocumentCommand\cftpartafterpnum{}{\cftparfillskip}


%......Title page
\pretitle{\begin{center}\HUGE}
\posttitle{\end{center}}
\preauthor{\vspace{2cm}\begin{center}}
\postauthor{\end{center}}
\predate{\begin{center}}
\postdate{\end{center}}

\usepackage{tcolorbox}
\tcbuselibrary{breakable}
\tcbuselibrary{skins}

%......Theorem Styles
%\newtheoremstyle{RegularStyle}% name
%  {}%      Space above, empty = `usual value'
%  {}%      Space below
%  {\normalfont}% Body font
%  {}%         Indent amount (empty = no indent, \parindent = para indent)
%  {\normalfont\scshape}% Thm head font
%  {.}%        Punctuation after thm head
%  {.5em}%     Space after thm head: " " = normal interword space;
%        %       \newline = linebreak
%  {} % {\thmnote{#3}}% Thm head spec
%\theoremstyle{RegularStyle}
%{%
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{proposition}[theorem]{Proposition}

%\NewDocumentEnvironment{examples}{}{\begin{itemize}}{\end{itemize}}
%\NewDocumentEnvironment{example}{}{\begin{itemize}\item}{\end{itemize}}

%% Examples code, using the tcolorbox package.
%\definecolor{example-color}{gray}{.95}
%\definecolor{example-border-color}{gray}{.8}
%\definecolor{example-color}{RGB}{255,255,255}
%\definecolor{example-border-color}{RGB}{180,180,180}
\tikzset{exampleStyle/.style={black!50,thin,rounded corners}}
\newcommand{\exampleBorderWidth}{2mm}
\newtcolorbox{example}
{
empty,
before=\par\medskip\noindent,
parbox=false,
boxsep=0pt,
left=0mm,
right=0mm,
top=0pt,
bottom=0pt,
breakable,
pad at break*=0mm,
vfill before first,
before upper={\widowpenalties=3 10000 10000 150},
overlay unbroken
={\draw[exampleStyle] (frame.north west)--([xshift=-\exampleBorderWidth]frame.north west)--([xshift=-\exampleBorderWidth]frame.south west)--(frame.south west); },
overlay first
={\draw[exampleStyle] (frame.north west)--([xshift=-\exampleBorderWidth]frame.north west)--([xshift=-\exampleBorderWidth]frame.south west); },
overlay middle
={\draw[exampleStyle] ([xshift=-\exampleBorderWidth]frame.north west)--([xshift=-\exampleBorderWidth]frame.south west); },
overlay last
={\draw[exampleStyle] ([xshift=-\exampleBorderWidth]frame.north west)--([xshift=-\exampleBorderWidth]frame.south west)--(frame.south west); },
}
%\NewDocumentEnvironment{example}{}{
%\begin{tcolorbox}[
%empty,
%before=\par\medskip\noindent,
%parbox=false,
%boxsep=0pt,
%left=4mm,
%right=3mm,
%top=0pt,
%bottom=0pt,
%breakable,
%pad at break*=0mm,
%vfill before first,
%overlay unbroken
%={\draw[exampleStyle] ([xshift=2mm]frame.north west)--(frame.north west)--(frame.south west)--([xshift=2mm]frame.south west); },
%overlay first
%={\draw[exampleStyle] ([xshift=2mm]frame.north west)--(frame.north west)--(frame.south west); },
%overlay middle
%={\draw[exampleStyle] (frame.north west)--(frame.south west); },
%overlay last
%={\draw[exampleStyle] (frame.north west)--(frame.south west)--([xshift=2mm]frame.south west); },
%%enhanced,
%%breakable,
%%colframe=example-border-color,
%%colback=white,
%%leftrule=10mm,
%%toprule=3mm,
%%bottomrule=3mm,
%%rightrule=10mm,
%%pad at break*=1mm,
%%toprule at break=-1mm,bottomrule at break=-1mm,
%%before upper={\widowpenalties=3 10000 10000 150}]
%%%colback=example-color,colframe=example-border-color,
%%%breakable,pad at break*=1mm,
%%%toprule=1.2mm,bottomrule=1.2mm,leftrule=1mm,rightrule=1mm,toprule at break=-1mm,bottomrule at break=-1mm,
%%%before upper={\widowpenalties=3 10000 10000 150}]%
%}{\end{tcolorbox}}
\NewDocumentEnvironment{examples}{}{
%\begin{tcolorbox}[
%empty,
%before=\par\medskip\noindent,
%parbox=false,
%boxsep=0pt,
%left=4mm,
%right=3mm,
%top=0pt,
%bottom=0pt,
%breakable,
%pad at break*=0mm,
%vfill before first,
%overlay unbroken
%={\draw[exampleStyle] ([xshift=2mm]frame.north west)--(frame.north west)--(frame.south west)--([xshift=2mm]frame.south west); },
%overlay first
%={\draw[exampleStyle] ([xshift=2mm]frame.north west)--(frame.north west)--(frame.south west); },
%overlay middle
%={\draw[exampleStyle] (frame.north west)--(frame.south west); },
%overlay last
%={\draw[exampleStyle] (frame.north west)--(frame.south west)--([xshift=2mm]frame.south west); },
%%enhanced,
%%breakable,
%%colframe=example-border-color,
%%colback=white,
%%leftrule=10mm,
%%toprule=3mm,
%%bottomrule=3mm,
%%rightrule=10mm,
%%%colback=example-color,colframe=example-border-color,
%%%breakable,
%%pad at break*=1mm,
%%toprule at break=-1mm,bottomrule at break=-1mm,
%%%toprule=1.2mm,bottomrule=1.2mm,leftrule=1mm,rightrule=1mm,toprule at break=-1mm,bottomrule at break=-1mm,
%%before upper={\widowpenalties=3 10000 10000 150}]%
%]
\begin{example}
\begin{itemize}
}%
{
\end{itemize}
\end{example}}

% In the middle of an example, the background color is not white. If you need a white background to put an image on it, it looks best to use an imageborderinexample.
\definecolor{image-border-color}{gray}{.975}
\NewDocumentCommand\imageborderinexample{m}{\begin{center}%\tcbox[colframe=image-border-color, colback=white]
{#1}\end{center}}
\NewDocumentCommand\includegraphicsinexample{om}%
{\IfValueTF{#1}{\imageborderinexample{\includegraphics[#1]{#2}}}{\imageborderinexample{\includegraphics{#2}}}}
\NewDocumentCommand\inputinexample{m}{\imageborderinexample{\input{#1}}}


%......Problems
% To define a new problem, use: 
% \begin{problem}{<label>} <statement> \end{problem}
% To give a solution to that problem:
% \begin{answer{<label>} <statement> \end{answer}
% using the same <label>.
% The label is for use in \ref{problem:label}, to refer to the problem.
% To say that a problem is exceptionally important, write
% \begin{problem*}{<label>} <statement> \end{problem*}
\NewDocumentEnvironment{ReviewExercises}{}{\section{Review~problems}}{}
\NewDocumentEnvironment{subproblems}{}{\begin{enumerate}}{\end{enumerate}}
\swapnumbers
\newtheoremstyle{ProblemStyle}% name
  {}%             Space above, empty = `usual value'
  {}%             Space below
  {\normalfont}%  Body font
  {}%             Indent amount (empty = no indent, \parindent = para indent)
  {\bfseries}%    Theorem head font
  {}%             Punctuation after thm head
  {.5em}%         Space after thm head: " " = normal interword space; \newline = linebreak
  {}%             Theorem head specification
\newtheoremstyle{HardProblemStyle}% name
  {}%             Space above, empty = `usual value'
  {}%             Space below
  {\normalfont}%  Body font
  {}%             Indent amount (empty = no indent, \parindent = para indent)
  {\bfseries}%    Theorem head font
  {\({}^*\)}%     Punctuation after thm head
  {.5em}%         Space after thm head: " " = normal interword space; \newline = linebreak
  {}%             Theorem head spec

{%
    \theoremstyle{ProblemStyle}
    \newtheorem{problemTheorem}{}[chapter]
    \theoremstyle{HardProblemStyle}
    \newtheorem{HardProblemTheorem}[problemTheorem]{}
}%
\swapnumbers
\NewDocumentEnvironment{problem}{m}{\begin{problemTheorem}\label{problem:#1}}{\end{problemTheorem}}
\NewDocumentEnvironment{problem*}{m}{\begin{HardProblemTheorem}\label{problem:#1}}{\end{HardProblemTheorem}}
\newoutputstream{ansout}
\NewDocumentCommand\printanswers{}{\closeoutputstream{ansout}\input{\jobname.ans}}
% Unfortunately, some complications involving `at' signs 
% and protection make it apparently necessary to define a
% \newparagraph symbol, which will later expand to \par. 
% Otherwise, we get mysterious errors. We could probably
% just make use of \protect here.
\let\newparagraph=\par
\makeatletter
\NewDocumentEnvironment{@nswer}{m}{\@bsphack\IfStreamOpen{ansout}{}{\openoutputfile{\jobname.ans}{ansout}}
\addtostream{ansout}{\smallskip\newparagraph\noindent\textbf{\protect\ref{problem:#1}.}}}{\@esphack}
\newcounter{howmany@answers}
\setcounter{howmany@answers}{0}
\NewDocumentEnvironment{answer}{m}%
{\stepcounter{howmany@answers}\@bsphack\@nswer{#1}\writeverbatim{ansout}}{\par\endwriteverbatim\end@nswer\@esphack}
\makeatother

% Colour for the rulings in tables:
\RequirePackage{colortbl}
\arrayrulecolor{gray!30}
\makeatletter
    \def\rulecolor#1#{\CT@arc{#1}}
    \def\CT@arc#1#2{%
      \ifdim\baselineskip=\z@\noalign\fi
      {\gdef\CT@arc@{\color#1{#2}}}}
    \let\CT@arc@\relax
\rulecolor{gray!30}
\makeatother

\RequirePackage{enumitem}
\setlist[enumerate,1]{label=\emph{\alph*.}}
\setlist[enumerate,2]{label=\arabic*.,
ref=\theenumi.\emph{\alph*}}
\setlist[enumerate,3]{label=\roman*), ref=\theenumii.\roman*}
%\RequirePackage{epigraph-keys}







\makeatletter
\NewDocumentCommand\writetitlepage{}
{%
    \ifx\mckaybook@title\emptystring
    \else
    		\begingroup
    		\raggedleft
    		\vspace*{\baselineskip}
    		{\Large \mckaybook@author
    		}\\[0.167\textheight]
    		\ifx\mckaybook@subtitle\emptystring%
			\Huge\heading\mckaybook@title\\[\baselineskip]%
		\else%
			\Huge\heading\mckaybook@title\\[\baselineskip]%
	    		\Large\heading\mckaybook@subtitle\\[\baselineskip]%
    		\fi
		\normalfont
    		\vfill
    		{\Large \today}\par
    		\vspace*{3\baselineskip}
    		\endgroup
    \fi
}%
\makeatother



%% \newclr generates a colour based on the current chapter number, so we execute it every time we create a new chapter. It saves that colour in a global color variable called chpclr. This colour is used to highlight the chapter name at the beginning of the chapter and in all of the headings at the top of each page.
\newcommand*{\newcolr}%%
{%%
\newcount\mycount
% First mod out by 15:
\mycount=\value{chapter}
\divide\mycount by 15
\multiply\mycount by 15
\multiply\mycount by -1
\advance\mycount by \value{chapter}
% Second, choose which color scheme to interpolate:
\ifnum\mycount>9 
	\advance\mycount -10 
	\multiply\mycount by 20
	\xglobal\colorlet{chpclr}{colorAAA!\the\mycount!colorCCC}
\else
	\ifnum\mycount>4 
		\advance\mycount -5 
		\multiply\mycount by 20
		\xglobal\colorlet{chpclr}{colorCCC!\the\mycount!colorBBB}
	\else
		\multiply\mycount by 20
		\xglobal\colorlet{chpclr}{colorBBB!\the\mycount!colorAAA}
	\fi
\fi
}%%
\newlength{\smallboxh}
\newlength{\smallboxd}
\newlength{\smallboxw}
\setlength{\smallboxw}{.1mm}
\settoheight{\smallboxh}{l}
\settodepth{\smallboxd}{l}
\newcommand*{\blanksp}{\phantom{\rule[\smallboxd]{\smallboxw}{\smallboxh}}}

\newif\ifchaptercolours
\chaptercoloursfalse

\NewDocumentCommand\smallcolouredbox{}%
{%%
\ifchaptercolours\,{\colorbox{chpclr}{\blanksp}}\,\else\fi
}%%
\RenewDocumentCommand\chapnamefont{m}{\newcolr\large\centering#1}

\definecolor{colorAAA}{rgb}{.75,1,1}
\definecolor{colorBBB}{rgb}{1,.75,1}
\definecolor{colorCCC}{rgb}{1,1,.75}



\makeatletter
\AtBeginDocument%
{%%
\frontmatter
% Title page
\ifx\mckaybook@title\emptystring
\else
    \ifx\mckaybook@subtitle\emptystring%
        \title{\MakeUppercase{\mckaybook@title}}
	\else
        \title{\MakeUppercase{\mckaybook@title} \\ \MakeUppercase{\mckaybook@subtitle}}
    \fi
    \ifx\mckaybook@author\emptystring%
    \else
		\author
		{%
    	    		{%
	    	        \LARGE{\mckaybook@author}
	        }%
			\\
    			{{\mckaybook@location}}
	    }%
	\fi
\fi
\makeatother
\writetitlepage
\thispagestyle{empty}
\pagenumbering{roman}
\makeheadrule{companion}{\headwidth}{0pt}
\makeevenhead{companion}%
{\normalfont\thepage}{}{\small\heading\leftmark\smallcolouredbox\negphantom{\smallcolouredbox}}
\makeoddhead{companion}%
{\small\negphantom{\smallcolouredbox}\smallcolouredbox\heading\rightmark}{}{\normalfont\thepage}

\setlength{\cftchapterindent}{4cm}
\setlength{\cftpartindent}{4cm}
%\addtocontents{toc}{\protect\begin{adjustwidth}{8em}{8em}}%
\pagestyle{empty}
\clearpage{\footnotesize\vspace*{18cm}\par\noindent{}This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.}
\clearpage
\pagestyle{companion}
}%%

\NewDocumentCommand\negphantom{m}{\settowidth{\dimen0}{#1}\hspace*{-\dimen0}}

\NewDocumentCommand\afterpreface{}
{%
\clearpage
\tableofcontents*
\mainmatter
\chaptercolourstrue
\pagenumbering{arabic}
}%

\AtEndDocument%
{%%

\backmatter
\chaptercoloursfalse
\ifnum\value{howmany@answers}>0
% Hints for the problems
% Lets add a space in the table of contents.
%%\addtocontents{toc}{\protect\medskip}
\chapter{Hints}\label{chp:Hints}
\printanswers
\fi

\makeatletter
\ifx\mckaybook@bibliography\emptystring
\else
% Bibliography
\bibliographystyle{amsplain}
\bibliography{\mckaybook@bibliography}
\flushbottom
\fi
\makeatother

% Notation Index
\ifnum\value{howmany@notation}>0
\indexintoc
{\RenewDocumentCommand{\indexspace}{}{}\small{\printglossary[not]}}
\cleardoublepage
\fi

%\addtocontents{toc}{\protect\end{adjustwidth}}

% Index
\ifnum\value{howmany@indexentries}>0
\indexintoc
\RenewDocumentCommand\indexname{}{Index}
{\small{\printindex}}
\fi


}%% AtEndDocument
