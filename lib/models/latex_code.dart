import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/models/experience_model.dart';
import 'package:cv_maker/models/projects_model.dart';
import 'package:cv_maker/models/skills_model.dart';

class LatexCode {
  final ContactInfoModel contactInfo;
  final EducationModel educationInfo;
  final ExperienceModel experienceInfo;
  final SkillsModel skillsInfo;
  final List<ProjectModel> projects;

  LatexCode({
    required this.contactInfo,
    required this.educationInfo,
    required this.experienceInfo,
    required this.skillsInfo,
    required this.projects,
  });

  String getLatex() {
    String latexCode = """%-------------------------
% Resume in Latex
% Author : ${contactInfo.fullName}
%------------------------\n""";

    latexCode += r"""
\documentclass[letterpaper,11pt]{article}
\usepackage{latexsym}
\usepackage[empty]{fullpage}
\usepackage{titlesec}
\usepackage{marvosym}
\usepackage[usenames,dvipsnames]{color}
\usepackage{verbatim}
\usepackage{enumitem}
\usepackage[hidelinks]{hyperref}
\usepackage{fancyhdr}
\usepackage[english]{babel}
\usepackage{tabularx}
\usepackage{fontawesome5}
\usepackage{multicol}
\setlength{\multicolsep}{-3.0pt}
\setlength{\columnsep}{-1pt}
\input{glyphtounicode}

\pagestyle{fancy}
\fancyhf{}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Adjust margins
\addtolength{\oddsidemargin}{-0.6in}
\addtolength{\evensidemargin}{-0.5in}
\addtolength{\textwidth}{1.19in}
\addtolength{\topmargin}{-.7in}
\addtolength{\textheight}{1.4in}

\urlstyle{same}
\raggedbottom
\raggedright
\setlength{\tabcolsep}{0in}

% Sections formatting
\titleformat{\section}{
  \vspace{-4pt}\scshape\raggedright\large\bfseries
}{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]

\pdfgentounicode=1

% Custom commands
\newcommand{\resumeItem}[1]{\item\small{#1\vspace{-2pt}}}

% هنا غيرنا عرض العمود الأول إلى 75% من العرض وتنسيق التاريخ بمحاذاة اليمين
\newcommand{\resumeSubheading}[4]{
  \vspace{-2pt}\item
  \begin{tabular*}{1.0\textwidth}[t]{@{}p{0.75\textwidth}@{\extracolsep{\fill}}r@{}}
    \textbf{#1} & \textbf{\small #2} \\
    \textit{\small#3} & \textit{\small #4} \\
  \end{tabular*}\vspace{-7pt}
}

\newcommand{\resumeProjectHeading}[2]{
  \item
  \begin{tabular*}{1.0\textwidth}{@{}p{0.75\textwidth}@{\extracolsep{\fill}}r@{}}
    \textbf{#1} & \textbf{\small #2} \\
  \end{tabular*}\vspace{-5pt}
}

\newcommand{\resumeSubItem}[1]{\resumeItem{#1}\vspace{-4pt}}
\renewcommand\labelitemi{$\vcenter{\hbox{\tiny$\bullet$}}$}
\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}
\newcommand{\resumeSubHeadingListStart}{\begin{itemize}[leftmargin=0.0in, label={}]}
\newcommand{\resumeSubHeadingListEnd}{\end{itemize}}
\newcommand{\resumeItemListStart}{\begin{itemize}}
\newcommand{\resumeItemListEnd}{\end{itemize}\vspace{-5pt}}

\begin{document}
""";

    // Heading
    latexCode += """
\\begin{center}
  {\\Huge \\scshape ${contactInfo.fullName}} \\\\ \\vspace{1pt}
  ${contactInfo.address}, ${contactInfo.city} \\\\ \\vspace{1pt}
  \\small
  \\raisebox{-0.1\\height}{\\faPhone} +2${contactInfo.phone} ~
  \\href{mailto:${contactInfo.email}}{\\raisebox{-0.2\\height}{\\faEnvelope} \\underline{${contactInfo.email}}} ~
  \\href{${contactInfo.linkedIn}}{\\raisebox{-0.2\\height}{\\faLinkedin} \\underline{${contactInfo.fullName}}}
\\end{center}
""";

    // Education
    latexCode += """
\\section{Education}
\\resumeSubHeadingListStart
  \\resumeSubheading
    {${educationInfo.university}, ${educationInfo.faculty}}{${educationInfo.startYear} -- ${educationInfo.endYear}}
    {${educationInfo.degree}}{${contactInfo.city}}""";
    if (educationInfo.gpa != null) {
      latexCode += " \n \n  {CGPA: ${educationInfo.gpa}}/4.0 \n \\vspace{10pt}";
    }
    latexCode += r"""
\resumeSubHeadingListEnd
\vspace{-30pt}
""";

    // Projects
    if (projects.isNotEmpty) {
      latexCode += r"""
\section{Projects}
\vspace{-5pt}
\resumeSubHeadingListStart
""";
      for (var project in projects) {
        latexCode += """
  \\resumeProjectHeading{${project.title}}{${project.date}}
  \\resumeItemListStart
    \\resumeItem{${project.details}}
  \\resumeItemListEnd
""";
      }
      latexCode += r"""\resumeSubHeadingListEnd
\vspace{-13pt}
""";
    }

    // Courses & Trainings
    if (experienceInfo.trainings.isNotEmpty ||
        experienceInfo.courses.isNotEmpty) {
      latexCode += r"""
\section{Courses and Trainings}
\resumeSubHeadingListStart
""";
      for (var t in experienceInfo.trainings) {
        latexCode +=
            """\\resumeItem{\\textbf{${t.name} (${t.date}):} ${t.place}}\n""";
      }
      for (var c in experienceInfo.courses) {
        latexCode +=
            """\\resumeItem{\\textbf{${c.course} (${c.date}):} ${c.place}}\n""";
      }
      latexCode += r"""\resumeSubHeadingListEnd
""";
    }

    // Certifications
    if (skillsInfo.certifications.isNotEmpty) {
      latexCode += r"""
\section{Awards and Certificates}
\resumeSubHeadingListStart
""";
      for (var cert in skillsInfo.certifications) {
        latexCode += """
\\resumeSubheading
  {${cert.title}}{${cert.date}}{}{}
""";
      }
      latexCode += r"""\resumeSubHeadingListEnd
\vspace{-10pt}
""";
    }

    // Skills
    if (skillsInfo.technicalGroups.isNotEmpty ||
        skillsInfo.softSkills.isNotEmpty) {
      latexCode += r"""
\section{Skills}
\begin{multicols}{2}
\resumeItemListStart
""";
      for (var tech in skillsInfo.technicalGroups) {
        latexCode +=
            """\\resumeItem{\\textbf{${tech.title}:} ${tech.skills}}\n""";
      }
      for (var soft in skillsInfo.softSkills) {
        latexCode += """\\resumeItem{${soft}}\n""";
      }
      latexCode += r"""\resumeItemListEnd
\end{multicols}
""";
    }

    // Organizational Experience
    if (experienceInfo.nonTechnicalActivities.isNotEmpty) {
      latexCode += r"""
\section{Organizational Experience}
\resumeSubHeadingListStart
""";
      for (var org in experienceInfo.nonTechnicalActivities) {
        latexCode += """
\\resumeProjectHeading{${org.title}}{${org.date}}
\\resumeItemListStart
  \\resumeItem{${org.description}}
\\resumeItemListEnd
""";
      }
      latexCode += r"""\resumeSubHeadingListEnd
""";
    }

    // Languages
    if (skillsInfo.languages.isNotEmpty) {
      latexCode += r"""
\section{Languages}
\begin{itemize}[leftmargin=0.15in, label={}]
\small{\item{
""";
      for (var lang in skillsInfo.languages) {
        latexCode += """\\textbf{${lang.name}}: ${lang.level} \\\\ \n""";
      }
      latexCode += r"""
}}
\end{itemize}
""";
    }

    // End document
    latexCode += r"""
\end{document}
""";

    return latexCode;
  }
}
