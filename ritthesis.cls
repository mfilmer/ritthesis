\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ritthesis}[2015/01/06]

%%%%% Handle Options %%%%%
% Create conditionals
\newif\if@twoside
\newif\if@proposal
\newif\if@microsys
\newif\if@nohead
\newcommand{\@toplevel}{chapter}

% Names of things dependent on class options
\newcommand{\documentname}{Thesis}
\newcommand{\degreename}{Master of Science}
\newcommand{\degreefield}{Microelectronic Engineering}

% Font Size
\DeclareOption{10pt}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{11pt}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{12pt}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}

% Paper Size
\DeclareOption{a4paper}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{letterpaper}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}

% Equation Alignment
\DeclareOption{fleqn}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{leqno}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}

% Title page options
\DeclareOption{titlepage}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{notitlepage}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}
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
	\PassOptionsToClass{\CurrentOption}{article}
}

% One or two sided printing
\DeclareOption{oneside}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}

	\@twosidefalse
}
\DeclareOption{twoside}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{\CurrentOption}{article}

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

% Disable page marks. This happens automatically when the 'proposal' option is
% used. This also moves the page numbers to the center of the bottom of each
% page. This might be changed in the future but it will be a bit of work.
\DeclareOption{nohead}{
	\@noheadtrue
}


% Format as a proposal rather than a thesis
\DeclareOption{proposal}{
	\@proposaltrue
	\@noheadtrue
	\renewcommand{\@toplevel}{section}
}

% Use Microsystems PhD Signature Sheet Format
\DeclareOption{microsys}{
	\@microsystrue
	\renewcommand\documentname{Dissertation}
	\renewcommand\degreename{Doctorate of Philosophy}
	\renewcommand\degreefield{Microsystems Engineering}
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
\if@nohead
	\AtEndOfClass{
		\fancyfoot[C]{\thepage}
		\renewcommand{\headrulewidth}{0pt}
	}
\else
\fi
\if@proposal
	\PassOptionsToPackage{left=1in, right=1in, top=1in, bottom=1in}{geometry}
\else
	% One or two sided prining (matters for binding purposes)
	\if@twoside
		\PassOptionsToPackage{inner=1.5in, outer=1in, top=1in, bottom=1in}{geometry}
		\if@nohead
		\else
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
		\fi
	\else
		\PassOptionsToPackage{left=1.5in, right=1in, top=1in, bottom=1in}{geometry}
		\if@nohead
		\else
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
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load Base Class %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\if@proposal
	\LoadClass{article}
\else
	\LoadClass{report}
\fi

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
% If using the subcaption (preferred) package for subfigures, the caption
% formatting is used
% If using the subfig package instead, the settings must be coppied over.
\PassOptionsToPackage{font=small,labelfont={bf,small}}{subfig}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Custom Commands %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Misc. commands
\providecommand{\phantomsection}{}		% Make work with or without hyperref

% Commands for names of things
\newcommand{\universityname}{Rochester Institute of Technology}
\newcommand{\collegename}{Kate Gleason College of Engineering}
\newcommand{\departmentname}{Department of Electrical and Microelectronic Engineering}
\newcommand{\logo}{kgcoelogohoriz}

% Commands for making the frontmatter
\newcommand{\displaytitle}{\textbf{\Large\@title}}
\newcommand{\displayauthor}{\textsc{\@author}}
\newcommand{\maketitlepage}{
	\thispagestyle{empty}
	\hrule
	\begin{center}
		\if@microsys
			\
			\vfill
			
			\displaytitle
			
			\hfill\displayauthor\hfill\@advisor{} \textit{Advisor}\hfill{}
			
			\vfill
			
			A \MakeLowercase{\documentname} submitted in partial fulfillment of the requirements\\
			for the degree of \degreename{} in \degreefield{}
			
			\vfill
			
			\degreefield{} Program
			
			\collegename
			
			\vfill
			
			\textit\universityname
			
			\textit\@date
			
			\vfill
		\else
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
		\fi
	\end{center}
	\hrule
	\cleardoublepage
}

\newcommand{\makesignaturepage}{
	\phantomsection
	\addcontentsline{toc}{\@toplevel}{Signature Sheet}
	\thispagestyle{plain}
	\begin{doublespace}
	\if@microsys
		\begin{center}
			\displaytitle
			
			by
			
			\displayauthor
		\end{center}
		
		\noindent\textbf{Committee Approval:}
		
		\begin{singlespace}
			\noindent We, the undersigned committee memmbers, certify that we have advised advised and/or supervides the candidate on the work described in this dissertation. We further certify that we have reviewed the dissertation manuscript and approve it in partial fulfillment of the requirementns of the degree of \degreename{} in \degreefield{}.
		\end{singlespace}
		
		\vfill
		
		\makecommitteetable
				
		\vfill
	\else
		\begin{center}
			\displaytitle
			
			\displayauthor
			
			\vfill
			
			A \documentname{} \if@proposal Proposal\fi{} Submitted
			
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
	\fi
	\end{doublespace}
	\cleardoublepage
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
	\cleardoublepage
}
\if@proposal
	\newcommand{\makefrontmatter}{\maketitlepage\makesignaturepage}
\else
	\newcommand{\makefrontmatter}{\maketitlepage\makesignaturepage\makecopyrightpage}
\fi
\newcommand{\mainmatter}{\pagenumbering{arabic}}
\newcommand{\makealllists}{%
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{\@toplevel}{Table of Contents}\tableofcontents
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{\@toplevel}{List of Tables}\listoftables
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{\@toplevel}{List of Figures}\listoffigures
	\cleardoublepage
}
\newcommand{\makecommitteetable}{
	\begin{singlespace}
	\if@microsys
		\begin{tabular}{p{0.8\linewidth}r}
			\@committeetable
		\end{tabular}
	\else
		\begin{tabular}{rl}
			Approved By:\\
						\@committeetable
		\end{tabular}
	\fi
	\end{singlespace}
}

% Chapter headings
\setcounter{secnumdepth}{3}
\if@proposal
\else
	\titleformat{\chapter}[display]
		{\normalfont\LARGE\bfseries}
		{\chaptertitlename{} \thechapter}
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
\fi

% Roman numbering
\pagenumbering{roman}

% Header formatting stuff
\if@nohead
\else
	\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{} \thechapter. #1}{}}
	\renewcommand{\sectionmark}[1]{\markright{\thesection{} #1}{}}
\fi

% Committee members
\newcommand{\siglinelength}{25em}
\newcommand{\@committeetable}{}
\newcommand{\specialcommittee}[5][Dr.]{\g@addto@macro\@committeetable{
	\if@microsys
	\\
	\hline
	\\
	#1 #3 #4 \textit{#5}		& Date\\
	#2\\
	\\
	\else
	\\
		#2	& \rule{\siglinelength}{0.7pt}\\
			& #1 #3 #4 \textit{#5}\\
	\fi
}}
\newcommand{\advisor}[3][Dr.]{
	\providecommand{\@advisor}{#1 \textsc{#2 #3}}
	\specialcommittee[#1]{Prof.}{#2}{#3}{Advisor}
}
\newcommand\setadvisor[3][Dr.]{
	\providecommand{\@advisor}{#1 \textsc{#2 #3}}
}
\newcommand{\committee}[3][Dr.]{
	\specialcommittee[#1]{Prof.}{#2}{#3}{Committee Member}
}

% Bibliography
\newcommand{\makebibliography}[1]{ %
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{\@toplevel}{Bibliography}
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
		\addcontentsline{toc}{\@toplevel}{\abstractname}
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
		\addcontentsline{toc}{\@toplevel}{\acknowledgmentsname}
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
		\addcontentsline{toc}{\@toplevel}{\dedicationname}
		\pagestyle{plain}
		\ \vfill
	}
	{\vfill\cleardoublepage}

\newcommand{\listofsymbname}{List of Symbols}
\newenvironment{listofsymbols}[3][\listofsymbname]
	{
		\cleardoublepage
		\phantomsection
		\if@proposal
			\section*{#1}
		\else
			\chapter*{#1}
		\fi
		\addcontentsline{toc}{\@toplevel}{#1}
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


% Setting the chapter title formatting different for appenndices
\let\@original@appendix\appendix
\renewcommand\appendix{\@setappendixtitleformat\@original@appendix}
\newcommand\@setappendixtitleformat{
	\titleformat{\chapter}[hang]
		{\vspace{-15ex}\normalfont\Large\bfseries}
		{\chaptertitlename{} \thechapter:}
		{1em}
		{\Large}
		[\vspace{0ex}]
	\titleformat*{\section}{\normalfont\large\bfseries}
	\titleformat*{\subsection}{\normalfont\normalsize\bfseries}
	\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries}
	\titleformat{name=\chapter,numberless}[display]
		{\bfseries}
		{}
		{-8em}
		{\raggedright\Large}
		[\titlerule]
}


\newenvironment{theappendix}[1]
	{
		% Note: This is very broken for proposals. In fact, it is probably better
		% to just not even use this single appendix environment when writing one
		\if@proposal
			%\titleformat{\section}[display]
			%{\normalfont\bfseries}
			%{\LARGE{Appendix}}
			%{0em}
			%{\titlerule[2pt]\vspace{0.25em}\raggedleft\large}
			%[\vspace{0.5em}]
		\else
			\titleformat{\chapter}[hang]
				{\vspace{-15ex}\normalfont\Large\bfseries}
				{\chaptertitlename{} \thechapter:}
				{1em}
				{\Large}
				[\vspace{0ex}]
		\fi
		
		\@original@appendix
		\if@nohead
		\else
			\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{}: ##1}{}}
		\fi
		\chapter{#1}
	}
	{
		\if@nohead
		\else
			\renewcommand{\chaptermark}[1]{\markboth{\chaptertitlename{} \thechapter. ##1}{}}
		\fi
	}

% Done
\endinput
