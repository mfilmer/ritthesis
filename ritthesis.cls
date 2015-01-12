	\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ritthesis}[2015/01/06]

%%%%% Handle Options %%%%%
% Create conditionals
\newif\if@twoside
\newif\if@proposal


% Font Size
\DeclareOption{10pt}{
	\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{11pt}{
	\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{12pt}{
	\PassOptionsToClass{\CurrentOption}{report}
}

% Paper Size
\DeclareOption{a4paper}{
	\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{letterpaper}{
	\PassOptionsToClass{\CurrentOption}{report}
}

% Equation Alignment
\DeclareOption{fleqn}{
	\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{leqno}{
	\PassOptionsToClass{\CurrentOption}{report}
}

% Title page options
\DeclareOption{titlepage}{
	\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{notitlepage}{
	\PassOptionsToClass{\CurrentOption}{report}
}

% Chapter odd or any page start
\DeclareOption{openright}{
	\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{openany}{
	\PassOptionsToClass{\CurrentOption}{report}
}

% Draft mode
\DeclareOption{draft}{
	\PassOptionsToClass{\CurrentOption}{report}
}

% One or two sided printing
\DeclareOption{oneside}{
	\PassOptionsToClass{\CurrentOption}{report}

	\@twosidefalse
}
\DeclareOption{twoside}{
	\PassOptionsToClass{\CurrentOption}{report}

	\@twosidetrue
}

% Line spacing
\DeclareOption{singlespacing}{
	\AtEndOfClass{\singlespacing}
}
\DeclareOption{onehalfspacing}{
	\AtEndOfClass{\onehalfspacing}
}
\DeclareOption{doublespacing}{
	\AtEndOfClass{\doublespacing}
}

\newcommand{\bibspacing}{singlespace}
% Bibliography line spacing
\DeclareOption{singlespacebib}{ %
	\renewcommand{\bibspacing}{singlespace}
}
\DeclareOption{doublespacebib}{ %
	\renewcommand{\bibspacing}{doublespace}
}

% Format as a proposal rather than a thesis
\DeclareOption{proposal}{
	\@proposaltrue
}

% Fallback
\DeclareOption*{
	\ClassWarning{ritthesis}{Unknown option '\CurrentOption'}
}

% Default options
\ExecuteOptions{12pt,oneside,doublespacing,singlespacebib}

% Process options
\ProcessOptions\relax

%%%%% Set up environment based on options %%%%%
\AtEndOfClass{\fancyhf{}}
\if@proposal
	\PassOptionsToPackage{left=1in, right=1in, top=1in, bottom=1in}{geometry}
	\AtEndOfClass{
		\fancyfoot[C]{\thepage}
		\renewcommand{\headrulewidth}{0pt}
	}
\else
	% One or two sided prining (matters for binding purposes)
	\if@twoside
		\PassOptionsToPackage{inner=1.5in, outer=1in, top=1in, bottom=1in}{geometry}
		\AtEndOfClass{
			\fancyfoot[LE,RO]{\thepage}
			\fancyhead[RO]{\footnotesize\textbf\rightmark}
			\fancyhead[LE]{\footnotesize\textbf\leftmark}
			\renewcommand{\headrulewidth}{0.7pt}
			\fancypagestyle{plain}{%
				\fancyhf{}
				\fancyfoot[LE,RO]{\thepage}
				\renewcommand{\headrulewidth}{0pt}
				\renewcommand{\footrulewidth}{0pt}
			}
		}
	\else
		\PassOptionsToPackage{left=1.5in, right=1in, top=1in, bottom=1in}{geometry}
		\AtEndOfClass{
			\fancyfoot[R]{\thepage}
			\fancyhead[L]{\footnotesize\textbf\leftmark}
			\renewcommand{\headrulewidth}{0.7pt}
			\fancypagestyle{plain}{%
				\fancyhf{}
				\fancyfoot[R]{\thepage}
				\renewcommand{\headrulewidth}{0pt}
				\renewcommand{\footrulewidth}{0pt}
			}
		}
	\fi
\fi
\AtEndOfClass{\pagestyle{fancy}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load Base Class %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass{report}

%%%%%%%%%%%%%%%%%%%%
%%%%% Packages %%%%%
%%%%%%%%%%%%%%%%%%%%
% Masters theses at RIT must all be double spaced and look awful
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage[font=small,labelfont={bf,small}]{caption}
\RequirePackage[font=small,labelfont={bf,small}]{subcaption}
\RequirePackage[hidelinks,hyperfootnotes=false]{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Custom Commands %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Commands for names of things
\newcommand{\universityname}{Rochester Institute of Technology}
\newcommand{\collegename}{Kate Gleason College of Engineering}
\newcommand{\departmentname}{Department of Electrical and Microelectronic Engineering}
\newcommand{\logo}{kgcoelogohoriz}
\newcommand{\degreename}{Master of Science}
\newcommand{\degreefield}{Microelectronic Engineering}

% Commands for making the frontmatter
\newcommand{\displaytitle}{\textbf{\Large\@title}}
\newcommand{\displayauthor}{\textsc{\@author}}
\newcommand{\maketitlepage}{
	\thispagestyle{empty}
	\hrule
	\begin{center}
		\
		\vfill
		
		\displaytitle
		
		\hfill\displayauthor\hfill\@advisor{} \textit{Advisor}\hfill{}
		
		\vfill\vfill
		
		\includegraphics[width=15em]{\logo}
		
		\vfill
		
		\textit\departmentname
		
		\textit\collegename
		
		\textit\universityname
		
		\vfill
		\
	\end{center}
	\hrule
	{\clearpage\pagestyle{plain}\cleardoublepage}
}
\newcommand{\makesignaturepage}{
	\phantomsection
	\addcontentsline{toc}{chapter}{Signature Sheet}
	\thispagestyle{plain}
	\begin{doublespace}
	\begin{center}
		\displaytitle
		
		\displayauthor
		
		\vfill
		
		A Thesis \if@proposal Proposal\fi{} Submitted
		
		In Partial Fulfillment
		
		Of the Requirements for the Degree of
		
		\degreename
		
		In
		
		\degreefield
		
		\vfill
		
		\makecommitteetable
		
		\vfill
		
		\textit\universityname
		
		\@date
	\end{center}
	\end{doublespace}
	{\clearpage\pagestyle{plain}\cleardoublepage}
}
\newcommand{\makecopyrightpage}{
	\thispagestyle{plain}
	\begin{doublespace}
	\begin{center}
		\displaytitle
		
		\displayauthor
	\end{center}
	\vspace{3em}
	\begin{singlespace}
	\noindent
	I, \@author{}, hereby grant permission to the Wallace Memorial Library
	of the Rochester Institute of Technology to reproduce this document in
	whole or in part, such that any reproduction will not be for commercial
	use or profit.
	
	\vspace{5em}
	\noindent
	\rule{15em}{0.7pt}\hfill\rule{10em}{0.7pt}
	
	\noindent
	\@author\hfill{}Date
	\end{singlespace}
	\end{doublespace}
	{\clearpage\pagestyle{plain}\cleardoublepage}
}
\if@proposal
	\newcommand{\makefrontmatter}{\maketitlepage\makesignaturepage}
\else
	\newcommand{\makefrontmatter}{\maketitlepage\makesignaturepage\makecopyrightpage}
\fi
\newcommand{\mainmatter}{\pagenumbering{arabic}}
\newcommand{\makealllists}{%
	\phantomsection
	\addcontentsline{toc}{chapter}{Table of Contents}\tableofcontents
	{\clearpage\pagestyle{plain}\cleardoublepage}
	\phantomsection
	\addcontentsline{toc}{chapter}{List of Tables}\listoftables
	{\clearpage\pagestyle{plain}\cleardoublepage}
	\phantomsection
	\addcontentsline{toc}{chapter}{List of Figures}\listoffigures
	{\clearpage\pagestyle{plain}\cleardoublepage}
}
\newcommand{\makecommitteetable}{
	\begin{singlespace}
	\begin{tabular}{rl}
	Approved By:\\
				\@committeetable
	\end{tabular}
	\end{singlespace}
}

% Chapter headings
\setcounter{secnumdepth}{3}
\titleformat{\chapter}[display]
	{\normalfont\bfseries}
	{\LARGE{\chaptertitlename{} \thechapter}}
	{0em}
	{\titlerule[2pt]\vspace{0.25em}\raggedleft\large}
	[\vspace{0.5em}]
\titleformat*{\section}{\normalfont\large\bfseries}
\titleformat*{\subsection}{\normalfont\normalsize\bfseries}
\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries}
\titleformat{name=\chapter,numberless}[display]
	{\bfseries}
	{}
	{-8em}
	{\raggedright\Large}
	[\titlerule]

% Roman numbering
\pagenumbering{roman}

% Header formatting stuff
\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{} \thechapter. #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection{} #1}{}}

% Committee members
\newcommand{\siglinelength}{25em}
\newcommand{\@committeetable}{}
\newcommand{\specialcommittee}[5][Dr.]{\g@addto@macro\@committeetable{
	\\
	#2	& \rule{\siglinelength}{0.7pt}\\
		& #1 #3 #4 \textit{#5}\\
}}
\newcommand{\advisor}[3][Dr.]{
	\providecommand{\@advisor}{#1 \textsc{#2 #3}}
	\specialcommittee[#1]{Prof.}{#2}{#3}{Advisor}
}
\newcommand{\committee}[3][Dr.]{
	\specialcommittee[#1]{Prof.}{#2}{#3}{Committee Member}
}

% Bibliography
\newcommand{\makebibliography}[1]{ %
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{chapter}{Bibliography}
	\bibliographystyle{IEEEtran}
	\begin{\bibspacing}
		\bibliography{#1}
	\end{\bibspacing}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Custom Environments %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewenvironment{abstract}
	{
		\cleardoublepage
		\phantomsection
		\addcontentsline{toc}{chapter}{\abstractname}
		\pagestyle{plain}
		\begin{center}
			\textbf{\large{}\abstractname}
		\end{center}
	}
	{\cleardoublepage}

\newcommand{\acknowledgmentsname}{Acknowledgments}
\newenvironment{acknowledgments}
	{
		\cleardoublepage
		\phantomsection
		\addcontentsline{toc}{chapter}{\acknowledgmentsname}
		\pagestyle{plain}
		\begin{center}
			\textbf{\large{}\acknowledgmentsname}
		\end{center}
	}
	{\cleardoublepage}

\newcommand{\dedicationname}{Dedication}
\newenvironment{dedication}
	{
		\cleardoublepage
		\phantomsection
		\addcontentsline{toc}{chapter}{\dedicationname}
		\pagestyle{plain}
		\ \vfill
	}
	{\vfill\cleardoublepage}

\newcommand{\listofsymbname}{List of Symbols}
\newenvironment{listofsymbols}[3][\listofsymbname]
	{
		\cleardoublepage
		\chapter*{#1}
		\phantomsection
		\addcontentsline{toc}{chapter}{#1}
		\pagestyle{plain}
		\centering
		\begin{longtable}{#2}
			\toprule
			#3\\
			\midrule
			\endhead
			\bottomrule
			\endfoot
	}
	{\end{longtable}\cleardoublepage}

\newenvironment{theappendix}[1]
	{
		\titleformat{\chapter}[display]
		{\normalfont\bfseries}
		{\LARGE{\chaptertitlename{}}}
		{0em}
		{\titlerule[2pt]\vspace{0.25em}\raggedleft\large}
		[\vspace{0.5em}]
		
		\appendix
		\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{}: ##1}{}}
		\chapter{#1}
	}
	{
		\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{} \thechapter. ##1}{}}
	}

% Done
\endinput
