\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mmuthesis}[2023/08/07 LaTeX2e class for MMU Copyright (c) 2023 MMU]

\LoadClass[12pt,a4paper,oneside]{memoir}
\RequirePackage{textcomp}

\def\theauthor{\textbf{!INSERT AUTHOR!}}
\def\thetitle{\textbf{!INSERT TITLE!}}
\def\@mtsubmissionmonth{\textbf{!INSERT MONTH!}}
\def\@mtsubmissionyear{\textbf{!INSERT YEAR!}}
\def\@mtfaculty{\textbf{!INSERT FACULTY!}}
\def\@mtdegree{\textbf{!INSERT DEGREE!}}
\def\@mtquali{\textbf{!INSERT QUALIFICATION!}}

\newcommand{\submissionyear}[1]{\def\@mtsubmissionyear{#1}}
\newcommand{\submissionmonth}[1]{\def\@mtsubmissionmonth{#1}}
\newcommand{\faculty}[1]{\def\@mtfaculty{#1}}
\newcommand{\degree}[1]{\def\@mtdegree{#1}}
\newcommand{\qualification}[1]{\def\@mtquali{#1}}


%%%%%%%%%%%%
% Page layout
% Margins: T - 2.54cm; B - 2.49cm; L - 4.06cm; R - 2.49cm
%%%%%%%%%%%%
\settrimmedsize{297mm}{210mm}{*}
\setlrmarginsandblock{4.06cm}{2.49cm}{*}
\setulmarginsandblock{20mm}{40mm}{*}
\setheadfoot{\baselineskip}{25mm}
\addtolength\footskip{-6pt}
\pagestyle{plain}
\makeevenfoot{plain}{}{\fontsize{12pt}{14pt}\selectfont\thepage}{}
\makeoddfoot{plain}{}{\fontsize{12pt}{14pt}\selectfont\thepage}{}
\checkandfixthelayout

%%%%%%%%%%%%
% Simulate MS Windows fonts
%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage{helvet}
\RequirePackage{mathptmx}
%\RequirePackage{courier}
\renewcommand\ttdefault{lmvtt}


%%%%%%%%%%%%
% Line and paragraph spacing
% - 1.5 spacing for normal text 
% - Leave one line between paragraphs
% - 12.7mm paragraph indent
%%%%%%%%%%%%
\DisemulatePackage{setspace}
\RequirePackage{setspace}
\setstretch{1.5}
\abnormalparskip{1.5\onelineskip}
\setlength\parindent{12.7mm}
\RequirePackage{etoolbox}
\patchcmd{\quote}{\rightmargin}{\leftmargin 20mm \rightmargin}{}{}
\patchcmd{\quotation}{\rightmargin}{\leftmargin 20mm \rightmargin}{}{}

%%%%%%%%%%%%
% Footnotes
% - Font size = 8pt = \tiny for 12pt body font in memoir
% - Double spacing between footnotes
%%%%%%%%%%%%
\renewcommand{\foottextfont}{\tiny}
\setlength\footnotesep{\onelineskip}
\RequirePackage{endnotes}
\renewcommand\enotesize{\tiny}
\renewcommand\enoteheading{\chapter{\notesname}\mbox{}\vskip-4\onelineskip}
\renewcommand\enoteformat{\rightskip\z@ \leftskip\z@ \parindent=1.8em
  \leavevmode\llap{\makebox[1.8em][l]{\theenmark.}}}

%%%%%%%%%%%%%
% Algorithms
%%%%%%%%%%%%%
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{caption}
\DeclareCaptionFormat{algorithm}{\vspace{0ex}{%
   \parbox[c][1.75em][c]{\textwidth}{#1#2\hspace{1em}#3}}\par}
\captionsetup[algorithm]{format=algorithm}
\captionsetup[figure]{font=bf,justification=centering,singlelinecheck=false}
\captionsetup[table]{font=bf,position=top,justification=centering,singlelinecheck=false}

\AtBeginEnvironment{algorithmic}{\setstretch{1.5}}

\RequirePackage[breaklinks,pdfborder={0 0 0},bookmarksopen,bookmarksnumbered,pdfprintscaling=None]{hyperref}
\addtoiargdef\author{}{\hypersetup{pdfauthor={\theauthor}}}
\addtoiargdef\title{}{\hypersetup{pdftitle={\thetitle}}}


%%%%%%%%%%%%
% 10pt = \footnotesize for backmatter
% And add a PDF bookmark
%%%%%%%%%%%%
\cftinsertcode{narrowertoc}{\setlength\cftbeforechapterskip{.75em}}

\patchcommand{\backmatter}{}{\footnotesize%
\cftinserthook{toc}{narrowertoc}%
\renewcommand\chapter{\@ifstar{\mystarchap}{\mychap}}
\ifpdf\pdfbookmark[-1]{Back Matter}{back}\fi}
\patchcommand{\frontmatter}{}{\ifpdf\pdfbookmark[-1]{Front Matter}{front}\fi}
\patchcommand{\mainmatter}{}{\ifpdf\pdfbookmark[-1]{Main Chapters}{main}\fi}

%%%%%%%%%%%%
% The Cover and Title page
%%%%%%%%%%%%
\newcommand{\makecoverandtitlepage}{%
\ignorespaces
\changepage{-40mm}{-15mm}{15mm}{0em}{0em}{0mm}{0em}{0em}{0em}
\begin{titlingpage}
\centering\SingleSpacing%
\renewcommand\ttdefault{lmtt}%
\fontfamily{phv}\fontseries{mc}%
\fontsize{18pt}{20pt}%
\selectfont%
\MakeUppercase{\thetitle}\par%
\vfill%
\MakeUppercase{\theauthor}\par%
\vfill%
\MakeUppercase{\@mtdegree}\par%
\vfill
MULTIMEDIA UNIVERSITY\par%
\MakeUppercase{\@mtsubmissionmonth}\hbox{ }\@mtsubmissionyear\par%
\end{titlingpage}%
{\centering\thispagestyle{empty}\setcounter{page}{1}%
{\SingleSpacing\LARGE\MakeUppercase{\thetitle}\par}%
\vfill%
{\setstretch{2} BY\\%
{\fontsize{16pt}{18pt}\selectfont\MakeUppercase{\theauthor}}\\\@mtquali\par}%
\vfill%
{\setstretch{2} THESIS SUBMITTED IN FULFILMENT OF THE\\%
REQUIREMENT FOR THE DEGREE OF\\%
\MakeUppercase{\@mtdegree}\\%
(By Research)\\%
in the\\%
\@mtfaculty\par}%
\vfill%
{\SingleSpacing\fontsize{16pt}{18pt}\selectfont MULTIMEDIA UNIVERSITY\\[1em]%
MALAYSIA}\\[1em]%
\@mtsubmissionmonth\ \@mtsubmissionyear%\\[3em]%
\par\clearpage}%
\changepage{40mm}{15mm}{-15mm}{0em}{0em}{0mm}{0em}{0em}{0em}
\renewcommand\ttdefault{lmvtt}%
}


%%%%%%%%%%%%
% The Copyright page
%%%%%%%%%%%%
\newcommand{\copyrightpage}{\hspace{1em}%
\phantomsection%
\begin{vplace}[1]
\fontsize{12pt}{16pt}\selectfont 
\setlength{\parindent}{0pt}
\textcopyright \@mtsubmissionyear{} Universiti Telekom Sdn.\ Bhd. ALL RIGHTS RESERVED.\par
Copyright of this thesis belongs to Universiti Telekom Sdn.\ Bhd. as qualified by Regulation 7.2 (c) of the Multimedia University Intellectual Property and Commercialisation Policy. No part of this publication may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Universiti Telekom Sdn.\ Bhd. Due acknowledgement shall always be made of the use of any material contained in, or derived from, this thesis.
\end{vplace}\clearpage%
}


%%%%%%%%%%%%
% The Declaration page
%%%%%%%%%%%%
\newcommand{\declarationpage}{%
\chapter{Declaration}\vskip-\onelineskip
I hereby declare that the work has been done by myself and no portion of the work contained in this Thesis has been submitted in support of any application for any other degree or qualification on this or any other university or institution of learning.\\[3\onelineskip]
\newlength\siglinelength
\settowidth{\siglinelength}{\text{I hereby declare that the work}}
\noindent\rule{\siglinelength}{.6pt}\\{\theauthor}\\
1141327949\\
\@mtfaculty \\
Multimedia University\\
Date: 13 July 2026\par\clearpage
}

%%%%%%%%%%%%
% Acknowledgements 
%%%%%%%%%%%%
\newcommand{\acknowledgements}[1]{\chapter{Acknowledgements}\vskip-\onelineskip #1\newpage}
\newcommand{\acknowlfromfile}[1]{\acknowledgements{\input{#1}}}

%%%%%%%%%%%%
% Abstract
%%%%%%%%%%%%
\abstractintoc
\renewcommand*\abstractname{\texorpdfstring{ABSTRACT}{Abstract}}
\renewcommand*\absnamepos{center}
%\setlength\abstitleskip{0pt}
\setlength\abstitleskip{-\onelineskip}
\renewcommand\abstractnamefont{\normalsize\bfseries}
\renewcommand\abstracttextfont{\normalsize}
\setlength\absleftindent{0pt}
\setlength\absrightindent{0pt}
\newcommand{\abstractfromfile}[1]{\begin{abstract}\input{#1}\end{abstract}}

%%%%%%%%%%%%
% Chapter headings
%%%%%%%%%%%%
\renewcommand\chapterheadstart{\normalsize\vskip\beforechapskip}
\setlength\beforechapskip{0pt}
\setlength\midchapskip{0.5\onelineskip}
\setlength\afterchapskip{0.5\onelineskip}%2\onelineskip minus \onelineskip}
\renewcommand*\chapnamefont{\normalsize\bfseries}
\renewcommand*\chapnumfont{\normalsize\bfseries\centering}
\renewcommand*\chaptitlefont{\normalsize\bfseries\centering}
\renewcommand{\printchaptername}{{\chapnamefont\MakeUppercase{\chaptername}}}
\renewcommand*{\afterchapternum}{\vskip\midchapskip}
\renewcommand*{\printchaptertitle}[1]{{\chaptitlefont\MakeUppercase{#1}\par}}


%%%%%%%%%%%%
% Appendices
%%%%%%%%%%%%
\renewcommand{\appendixpagename}{APPENDICES}
\newcommand{\listapdxname}{LIST OF APPENDICES}
\newlistof{listofapdx}{loa}{\listapdxname}
\newlistentry{apdx}{loa}{0}
\patchcommand{\appendix}{}{
\footnotesize%
\renewcommand\chaptername{\appendixname}%
\ifpdf\pdfbookmark[-1]{Appendices}{appendix}\fi%
\let\normalchapter\chapter
\renewcommand{\chapter}[1]{
    \addtocounter{apdx}{1}  %add to list of appendices
    \renewcommand\theapdx{\Alph{apdx}}
    \addcontentsline{loa}{apdx}{\protect Appendix \numberline{\theapdx:} ##1}
    \normalchapter{##1}\normalsize}
}

%%%%%%%%%%%%
% Sectional headings
%%%%%%%%%%%%
\setsecnumdepth{subsubsection}
\setsecheadstyle{\normalsize\bfseries}
\setbeforesecskip{\onelineskip}
\setaftersecskip{\onelineskip}
\setsubsecheadstyle{\normalsize\bfseries}
\setbeforesubsecskip{\onelineskip}
\setaftersubsecskip{\onelineskip}
\setsubsubsecheadstyle{\normalsize\itshape}
\setbeforesubsubsecskip{\onelineskip}
% \renewcommand\thesubsubsection{\thesubsection\space(\alph{subsubsection})}
\renewcommand\thesubsubsection{\thesubsection.\arabic{subsubsection}}
\setsubsubsecheadstyle{\normalsize\itshape}
\setbeforesubsubsecskip{\onelineskip}
\setaftersubsubsecskip{\onelineskip}


%%%%%%%%%%%
% ToC etc
%%%%%%%%%%%
\newsubfloat{figure}
\setcounter{lofdepth}{2}
\newsubfloat{table}
\setcounter{lotdepth}{2}
\settocdepth{subsection}
\renewcommand*\contentsname{\texorpdfstring{TABLE OF CONTENTS}{Table of Contents}}
\renewcommand*\listtablename{\texorpdfstring{LIST OF TABLES}{List of Tables}}
\renewcommand*\listfigurename{\texorpdfstring{LIST OF FIGURES}{List of Figures}}
\renewcommand*\indexname{\texorpdfstring{INDEX}{Index}}
\renewcommand*\glossaryname{\texorpdfstring{LIST OF ABBREVIATIONS/SYMBOLS}{List of Abbreviations/Symbols}}
\renewcommand\cftdotsep{\cftnodots}
\setrmarg{3.55em plus 1fil}
\renewcommand*{\cftchaptername}{\MakeUppercase{\chaptername}\space}
\renewcommand*{\cftchapterafterpnum}{\vspace*{4pt}}
\renewcommand*{\cftappendixname}{\MakeUppercase{\appendixname}\space}
\setlength\cftsectionindent{0pt}
\let\orichapter\chapter
\renewcommand\chapter{\@ifstar{\mystarchap}{\mychap}}
\newcommand\mychap[1]{\orichapter[\texorpdfstring{\MakeUppercase{#1}}{#1}]{#1}}
\newcommand\mystarchap[1]{\orichapter*{#1}}
\setlength\cftbeforechapterskip{2em}
\setlength\cftbeforesectionskip{\onelineskip}
\setlength\cftbeforesubsectionskip{\onelineskip}
\setlength\cftsubsectionindent{\cftsectionnumwidth}
\renewcommand*\cftfigurename{\figurename\space}
\newlength\fignamelength
\settowidth\fignamelength{\cftfigurename}
\setlength\cftsubfigureindent{\fignamelength}
\setlength\cftsubfigurenumwidth{2em}
\setlength\cftbeforefigureskip{3pt}
\setlength\cftbeforesubfigureskip{3pt}
\renewcommand*\cfttablename{\tablename\space}
\newlength\tabnamelength
\settowidth\tabnamelength{\cfttablename}
\setlength\cftsubtableindent{\tabnamelength}
\setlength\cftbeforetableskip{3pt}
\setlength\cftbeforesubtableskip{3pt}

\addtodef{\insertchapterspace}{}%
{\addtocontents{toc}{\protect\vspace*{-4pt}}}


%%%%%%%%%%%%
% Bibliograpy
% - Font size = 10pt = \footnotesize
% - Double spacing between entries
%%%%%%%%%%%%
\RequirePackage[nosectionbib]{apacite}
\bibliographystyle{apacite}
\renewcommand\bibliographytypesize{\footnotesize}
\setlength\bibitemsep{\onelineskip}
\setlength\bibleftmargin{0em}
\setlength\bibindent{0em}%{-\bibleftmargin}
% Add a counter label to each bibitem 
%\def\@lbibitem[#1]#2{%
%    \def\BBA{\BBAA}%    
%    \item[\hyper@natanchorstart{#2\APAC@extra@b@citeb}%
%          \@biblabel{#1}{\protect\makebox[\bibleftmargin][l]{[\arabic{lbibcount}]}}% added numeric label here
%          \hyper@natanchorend]%
%    \if@filesw{%
%        \def\BBA{\string\BBA}%
%        \let\protect\noexpand
%        \immediate\write\@newciteauxhandle{\string\bibcite{#2}{#1}}%
%        \immediate\write\@newciteauxhandle{\string\APACbibcite{#2}{#1}}%
%        \def\BBA{\BBAA}%
%    }%
%    \fi
%    \ignorespaces
%}
%\patchcommand{\bibitem}{\addtocounter{lbibcount}{1}}{}
%\addtoiargdef{\thebibliography}{}{\setcounter{lbibcount}{0}\labelwidth=0pt}
\renewcommand{\bibliographyprenote}{\vspace*{-\onelineskip}} 
\AtBeginDocument{\renewcommand*\bibname{\texorpdfstring{REFERENCES}{References}}}

\RequirePackage{multibib}

\newcites{jour,conf}{Journals,Conference}
\bibliographystylejour{apacite}
\bibliographystyleconf{apacite}
\newcounter{lbibcount} 
\newcommand\ownpubs{%
%
% Unlike Reference list, self-publication list needs numbering
\setlength\bibleftmargin{2em}
\setlength\bibindent{-\bibleftmargin}
% Add a counter label to each bibitem 
\def\@lbibitem[##1]##2{%
    \def\BBA{\BBAA}%    
    \item[\hyper@natanchorstart{##2\APAC@extra@b@citeb}%
          \@biblabel{##1}{\protect\makebox[\bibleftmargin][l]{[\arabic{lbibcount}]}}% added numeric label here
          \hyper@natanchorend]%
    \if@filesw{%
        \def\BBA{\string\BBA}%
        \let\protect\noexpand
        \immediate\write\@newciteauxhandle{\string\bibcite{##2}{##1}}%
        \immediate\write\@newciteauxhandle{\string\APACbibcite{##2}{##1}}%
        \def\BBA{\BBAA}%
    }%
    \fi
    \ignorespaces
}%
\patchcommand{\bibitem}{\addtocounter{lbibcount}{1}}{}%
\addtoiargdef{\thebibliography}{}{\setcounter{lbibcount}{0}\labelwidth=0pt}%
%
\settocdepth{chapter}
\chapter{List of Publications}
\undef\chapter
}

\RequirePackage[toc,nonumberlist,acronym,nomain,style=super,sort=def]{glossaries}
\renewcommand*{\acrnameformat}[2]{#2 (\acronymfont{#1})}
\renewcommand{\glsgroupskip}{}
\renewcommand{\glossarypreamble}{\normalsize\onehalfspacing\vspace*{-\onelineskip}}
\renewcommand{\glossarypostamble}{\normalsize}
\makeglossaries

%%%%%%%%%%%%
% Floats
%%%%%%%%%%%%
\setlength{\intextsep}{2\onelineskip}
\setlength{\textfloatsep}{2\onelineskip}
\setlength{\floatsep}{2\onelineskip}

%\AtEndDocument{\clearpage\hspace{1em}\thispagestyle{empty}\clearpage} % removed: unwanted blank page at the end of the thesis
