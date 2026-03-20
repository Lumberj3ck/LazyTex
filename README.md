# Project Report Template

A LaTeX academic report template for the Data Science Master's Programme at the University of Skövde.

---

## Project Structure

```
.
├── report.tex              # Main document — start here
├── bibliography.bib        # References database
├── base/
│   ├── packages.tex        # Imported LaTeX packages
│   └── style.tex           # Fonts, colors, section formatting
├── sections/
│   ├── 00_front_page.tex   # Title page — fill in your info
│   ├── 00_abstract.tex     # Abstract (max 200 words)
│   ├── 01_introduction.tex
│   ├── 02_methodology.tex
│   ├── 03_results.tex
│   └── 04_conclusion.tex
├── images/                 # Put your figures here
└── build/                  # Compiled output goes here
```

---

## How to Compile

### Option 1 — latexmk (recommended)

Handles everything automatically (pdflatex + bibtex + reruns):

```bash
latexmk -pdf -output-directory=build report.tex
```

To auto-recompile on save (watch mode):

```bash
latexmk -pdf -output-directory=build -pvc report.tex
```

To clean build artifacts:

```bash
latexmk -output-directory=build -C
```

### Option 2 — Manual (pdflatex + bibtex)

Run these in order:

```bash
pdflatex -output-directory=build report.tex
bibtex build/report
pdflatex -output-directory=build report.tex
pdflatex -output-directory=build report.tex
```

You need to run pdflatex three times: once to generate aux files, once after bibtex to resolve citations, once more to resolve cross-references.

### Option 3 — Overleaf

Upload the whole folder to [Overleaf](https://www.overleaf.com), set `report.tex` as the main file, and hit Compile. No local install needed.

### Requirements (local)

- TeX Live 2020+ or MiKTeX
- Packages: `natbib`, `geometry`, `titlesec`, `listings`, `mdframed`, `hyperref`, `amsmath`, `inconsolata` (all included in TeX Live full)

---

## Getting Started

1. Edit `sections/00_front_page.tex` — fill in your name, title, course, etc.
2. Write your abstract in `sections/00_abstract.tex`
3. Add content to the section files under `sections/`
4. Put images in `images/`
5. Add references to `bibliography.bib`
6. Compile with latexmk

---

## LaTeX Cheatsheet

### Document Structure

```latex
\section{Introduction}          % numbered heading
\subsection{Background}         % sub-heading
\subsubsection{Details}         % sub-sub-heading
\section*{Unnumbered Section}   % * removes the number
```

### Text Formatting

```latex
\textbf{bold text}
\textit{italic text}
\underline{underlined}
\texttt{monospace / code}
\emph{emphasized}               % italic in normal text, normal in italic text

% Font sizes (smallest to largest)
\tiny  \scriptsize  \footnotesize  \small  \normalsize
\large  \Large  \LARGE  \huge  \Huge
```

### Lists

```latex
% Bullet list
\begin{itemize}
  \item First item
  \item Second item
\end{itemize}

% Numbered list
\begin{enumerate}
  \item First
  \item Second
\end{enumerate}

% Description list
\begin{description}
  \item[Term] Definition goes here
\end{description}
```

### Math

```latex
% Inline math
The formula $E = mc^2$ is inline.

% Display math (centered, no number)
\[
  \sum_{i=1}^{n} x_i = \frac{a}{b}
\]

% Numbered equation
\begin{equation}
  f(x) = \int_0^\infty e^{-x^2} \, dx
  \label{eq:gaussian}
\end{equation}

% Common symbols
^{superscript}    _{subscript}
\frac{top}{bottom}
\sqrt{x}          \sqrt[3]{x}
\sum  \prod  \int
\alpha \beta \gamma \delta \theta \lambda \mu \sigma
\leq  \geq  \neq  \approx  \in  \notin  \subset
\cdot  \times  \pm  \infty
```

### Figures

```latex
\begin{figure}[h]               % h=here, t=top, b=bottom, H=force here
  \centering
  \includegraphics[width=0.8\textwidth]{images/myfigure.png}
  \caption{This is the caption.}
  \label{fig:myfigure}
\end{figure}

% Reference it in text:
As shown in Figure~\ref{fig:myfigure}, ...
```

### Tables

```latex
\begin{table}[h]
  \centering
  \begin{tabular}{|l|c|r|}     % l=left, c=center, r=right, |=vertical line
    \hline
    Header 1  & Header 2  & Header 3  \\ \hline
    Row 1 Col 1 & Row 1 Col 2 & Row 1 Col 3 \\ \hline
    Row 2 Col 1 & Row 2 Col 2 & Row 2 Col 3 \\ \hline
  \end{tabular}
  \caption{Table caption.}
  \label{tab:mytable}
\end{table}

% Reference it:
See Table~\ref{tab:mytable}.
```

### Code Listings

This template uses the `listings` package. Use the `\lstinputlisting` command or inline:

```latex
% Inline code block
\begin{lstlisting}[language=Python, caption=My script]
def hello():
    print("Hello, world!")
\end{lstlisting}

% From a file
\lstinputlisting[language=Python]{code/myscript.py}
```

Supported languages: Python, R, Java, C, C++, Bash, SQL, and more.

### Citations & References

This template uses `natbib` with numbered citations.

```latex
% In text
\cite{authorYear}              % [1]
\citep{authorYear}             % (Author, Year) — parenthetical
\citet{authorYear}             % Author (Year) — textual

% Add to bibliography section automatically
\nocite{key}                   % include in references without citing in text
\nocite{*}                     % include all entries from .bib
```

Adding a reference to `bibliography.bib`:

```bibtex
@article{berners1994www,
  author  = {Berners-Lee, Tim},
  title   = {The World Wide Web},
  journal = {Scientific American},
  year    = {1994},
  volume  = {276},
  pages   = {76--83}
}

@book{author2020title,
  author    = {Last, First},
  title     = {Book Title},
  publisher = {Publisher},
  year      = {2020}
}

@misc{website,
  author = {Author Name},
  title  = {Page Title},
  year   = {2024},
  url    = {https://example.com},
  note   = {Accessed: 2024-01-01}
}
```

### Cross-References

```latex
% Label anything: figures, tables, equations, sections
\label{sec:intro}
\label{fig:results}
\label{tab:data}
\label{eq:loss}

% Reference it anywhere
See Section~\ref{sec:intro}.
% The ~ is a non-breaking space — keeps "Section 1" on one line
```

### Useful Snippets

```latex
% Horizontal line
\hrule
\noindent\rule{\linewidth}{0.4pt}

% Page break
\newpage
\clearpage    % also flushes all pending floats (figures/tables)

% Blank line / vertical space
\vspace{1cm}
\medskip  \bigskip

% No indent on a paragraph
\noindent This paragraph has no indent.

% Comment (not rendered)
% This is a comment

% Special characters (must be escaped)
\%  \$  \&  \#  \_  \{  \}  \^{}  \~{}  \textbackslash
```

### Note Box (custom to this template)

```latex
\begin{mdframed}[backgroundcolor=yellow!20]
  \textbf{Note:} Something worth highlighting.
\end{mdframed}
```

### Multi-column Layout

```latex
\begin{multicols}{2}
  Left column content...
  \columnbreak
  Right column content...
\end{multicols}
```

---

## Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `Undefined control sequence` | Typo in command or missing package | Check spelling; add package to `base/packages.tex` |
| `Missing $ inserted` | Math symbol used outside math mode | Wrap in `$...$` |
| `File not found` | Wrong image path | Check path relative to `report.tex` |
| `Citation undefined` | Key not in `.bib` or bibtex not run | Run bibtex, then pdflatex twice |
| `Label undefined` | `\ref` before `\label` or not compiled twice | Compile again |
| Overfull `\hbox` (warning) | Text/image too wide | Reduce `\includegraphics` width or add `\sloppy` |
