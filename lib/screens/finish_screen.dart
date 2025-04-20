import 'package:cv_maker/models/latex_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/models/experience_model.dart';
import 'package:cv_maker/models/projects_model.dart';
import 'package:cv_maker/models/skills_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FinishScreen extends StatelessWidget {
  final ContactInfoModel contactInfo;
  final EducationModel educationInfo;
  final ExperienceModel experienceInfo;
  final SkillsModel skillsInfo;
  final List<ProjectModel> projects;

  const FinishScreen({
    super.key,
    required this.contactInfo,
    required this.educationInfo,
    required this.experienceInfo,
    required this.skillsInfo,
    required this.projects,
  });
  static Future<void> _openOverleaf() async {
    const url = 'https://www.overleaf.com';
    final success = await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
    if (!success) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Finalize Your CV',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'All steps are completed!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Steps to create your CV:\n'
                '1. Copy the LaTeX code.\n'
                '2. Go to Overleaf, create a new project.\n'
                '4. choose "Blank Project".\n'
                '3. Paste the code, click Compile, then Download.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: const Text("Copy LaTeX Code"),
                onPressed: () async {
                  // final latexCode1 =
                  //     r"""\documentclass[letterpaper,11pt]{article}
                  // \usepackage{latexsym}
                  // \usepackage[empty]{fullpage}
                  // \usepackage{titlesec}
                  // \usepackage{marvosym}
                  // \usepackage[usenames,dvipsnames]{color}
                  // \usepackage{verbatim}
                  // \usepackage{enumitem}
                  // \usepackage[hidelinks]{hyperref}
                  // \usepackage{fancyhdr}
                  // \usepackage[english]{babel}
                  // \usepackage{tabularx}
                  // \usepackage{fontawesome5}
                  // \usepackage{multicol}
                  // \setlength{\multicolsep}{-3.0pt}
                  // \setlength{\columnsep}{-1pt}
                  // \input{glyphtounicode}

                  // \pagestyle{fancy}
                  // \fancyhf{}
                  // \fancyfoot{}
                  // \renewcommand{\headrulewidth}{0pt}
                  // \renewcommand{\footrulewidth}{0pt}

                  // \addtolength{\oddsidemargin}{-0.6in}
                  // \addtolength{\evensidemargin}{-0.5in}
                  // \addtolength{\textwidth}{1.19in}
                  // \addtolength{\topmargin}{-.7in}
                  // \addtolength{\textheight}{1.4in}

                  // \urlstyle{same}
                  // \raggedbottom
                  // \raggedright
                  // \setlength{\tabcolsep}{0in}

                  // \titleformat{\section}{
                  //   \vspace{-4pt}\scshape\raggedright\large\bfseries
                  // }{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]

                  // \pdfgentounicode=1

                  // \newcommand{\resumeItem}[1]{
                  //   \item\small{{#1 \vspace{-2pt}}}
                  // }

                  // \newcommand{\resumeSubheading}[4]{
                  //   \vspace{-2pt}\item
                  //     \begin{tabular*}{1.0\textwidth}[t]{l@{\extracolsep{\fill}}r}
                  //       \textbf{#1} & \textbf{\small #2} \\
                  //       \textit{\small#3} & \textit{\small #4} \\
                  //     \end{tabular*}\vspace{-7pt}
                  // }

                  // \newcommand{\resumeProjectHeading}[2]{
                  //     \item
                  //     \begin{tabular*}{1.001\textwidth}{l@{\extracolsep{\fill}}r}
                  //       \small#1 & \textbf{\small #2}\\
                  //     \end{tabular*}\vspace{-7pt}
                  // }

                  // \newcommand{\resumeSubItem}[1]{\resumeItem{#1}\vspace{-4pt}}

                  // \newcommand{\resumeSubHeadingListStart}{\begin{itemize}[leftmargin=0.0in, label={}]}
                  // \newcommand{\resumeSubHeadingListEnd}{\end{itemize}}
                  // \newcommand{\resumeItemListStart}{\begin{itemize}}
                  // \newcommand{\resumeItemListEnd}{\end{itemize}\vspace{-5pt}}""";

                  // String latexCode2 = """
                  // \\begin{document}

                  // \\begin{center}
                  //     {\\Huge \\scshape ${contactInfo.fullName}} \\\\ \\vspace{1pt}
                  //     ${contactInfo.address}, ${contactInfo.city} \\\\ \\vspace{1pt}
                  //     \\small
                  //     \\raisebox{-0.1\\height}\\faPhone\\ ${contactInfo.phone} ~
                  //     \\href{mailto:${contactInfo.email}}{\\raisebox{-0.2\\height}\\faEnvelope\\ \\underline{${contactInfo.email}}} ~
                  //     \\href{${contactInfo.linkedIn}}{\\raisebox{-0.2\\height}\\faLinkedin\\ \\underline{${contactInfo.fullName}}}  ~
                  // \\end{center}
                  // """;

                  // String latexCode3 = """
                  //         \\section{Objective}
                  //         \\resumeSubHeadingListStart
                  //         \\item
                  //         ${contactInfo.objective}
                  //         \\resumeSubHeadingListEnd""";

                  // String latexCode4 = """
                  //         \\section{Education}
                  //         \\resumeSubHeadingListStart
                  //           \\resumeSubheading
                  //       {${educationInfo.university}, ${educationInfo.faculty}}{${educationInfo.startYear} -- ${educationInfo.endYear}}
                  //             {${educationInfo.degree}}{${contactInfo.city}}
                  //              \\vspace{1pt}""";

                  // if (educationInfo.gpa != null) {
                  //   latexCode4 += """\n
                  //    {CGPA: ${educationInfo.gpa}}
                  //         \\resumeSubHeadingListEnd""";
                  // }

                  // String latexCode5 = "";
                  // if (skillsInfo.technicalGroups.length > 0) {
                  //   latexCode5 = r"""
                  //         \section{Technical Skills}
                  //         \resumeSubHeadingListStart
                  //         """;
                  //   for (
                  //     int i = 0;
                  //     i < skillsInfo.technicalGroups.length;
                  //     i++
                  //   ) {
                  //     latexCode5 +=
                  //         "\\item \\textbf{${skillsInfo.technicalGroups[i].title}:} ${skillsInfo.technicalGroups[i].skills} \\\n";
                  //   }
                  //   latexCode5 += r"\resumeSubHeadingListEnd";
                  // }

                  // final List<String> softSkills =
                  //     skillsInfo.softSkills.map((skill) => skill).toList();

                  // if (softSkills.length > 0) {
                  //   latexCode5 += r""" \section{Soft Skills}
                  //         \resumeSubHeadingListStart""";

                  //   latexCode5 += "\\item \\textbf${softSkills} ";

                  //   latexCode5 += r"\resumeSubHeadingListEnd";
                  // }

                  // if (skillsInfo.languages.length > 0) {
                  //   latexCode5 += r""" \section{Languages}
                  //         \resumeSubHeadingListStart""";
                  //   for (int i = 0; i < skillsInfo.languages.length; i++) {
                  //     latexCode5 +=
                  //         "\\item \\textbf{${skillsInfo.languages[i].name}:} ${skillsInfo.languages[i].level} \\\n";
                  //   }
                  //   latexCode5 += r"\resumeSubHeadingListEnd";
                  // }
                  // String latexCode6 = "";

                  // if (projects.length > 0) {
                  //   latexCode6 += """
                  //          \\section{Projects}
                  //         \\resumeSubHeadingListStart""";

                  //   for (int i = 0; i < projects.length; i++) {
                  //     latexCode6 += """
                  //         \\resumeProjectHeading{\\textbf{${projects[i].title}}}{${projects[i].date}}
                  //         \\resumeItemListStart
                  //           \\resumeItem{${projects[i].details}}
                  //         \\resumeItemListEnd""";
                  //   }
                  //   latexCode6 += r"\resumeSubHeadingListEnd";
                  // }
                  // String latexCode7 = "";

                  // if (experienceInfo.courses.length > 0 &&
                  //     experienceInfo.trainings.length > 0) {
                  //   latexCode7 += r"""
                  //         \section{Courses and Trainings}
                  //         \resumeSubHeadingListStart""";

                  //   for (int i = 0; i < experienceInfo.courses.length; i++) {
                  //     latexCode7 +=
                  //         """\\resumeItem{\\textbf{${experienceInfo.courses[i].course} (${experienceInfo.courses[i].date})} :${experienceInfo.courses[i].place}}""";
                  //   }
                  //   for (int i = 0; i < experienceInfo.trainings.length; i++) {
                  //     latexCode7 +=
                  //         """\\resumeItem{\\textbf{${experienceInfo.trainings[i].name} (${experienceInfo.trainings[i].date})} :${experienceInfo.trainings[i].place}:${experienceInfo.trainings[i].description}}""";
                  //   }
                  // }
                  // String latexCode8 = "";
                  // if (experienceInfo.nonTechnicalActivities.length > 0) {
                  //   latexCode8 += """
                  //         \\section{Organizational Experience}
                  //         \\resumeSubHeadingListStart""";

                  //   for (
                  //     int i = 0;
                  //     i < experienceInfo.nonTechnicalActivities.length;
                  //     i++
                  //   ) {
                  //     latexCode8 += """
                  //         \\resumeProjectHeading{\\textbf{${experienceInfo.nonTechnicalActivities[i].title}}}{${experienceInfo.nonTechnicalActivities[i].date}}
                  //         \\resumeItemListStart
                  //           \\resumeItem{${experienceInfo.nonTechnicalActivities[i].description}}
                  //         \\resumeItemListEnd""";
                  //   }
                  //   latexCode8 += r"\resumeSubHeadingListEnd";
                  // }
                  // String latexCode9 = "";
                  // if (skillsInfo.certifications.length > 0) {
                  //   latexCode9 += r"""
                  //         \section{Certifications}
                  //         \resumeSubHeadingListStart""";

                  //   for (int i = 0; i < skillsInfo.certifications.length; i++) {
                  //     latexCode9 +=
                  //         """ \\resumeItem{${skillsInfo.certifications[i].title} (${skillsInfo.certifications[i].date})}""";
                  //   }

                  //   latexCode9 += r"\resumeSubHeadingListEnd";
                  // }

                  // String latexCode =
                  //     latexCode1 +
                  //     '\n' +
                  //     latexCode2 +
                  //     '\n' +
                  //     latexCode3 +
                  //     '\n' +
                  //     latexCode4 +
                  //     '\n' +
                  //     latexCode5 +
                  //     '\n' +
                  //     latexCode6 +
                  //     '\n' +
                  //     latexCode7 +
                  //     '\n' +
                  //     latexCode8 +
                  //     '\n' +
                  //     latexCode9 +
                  //     '\n' +
                  //     r"\end{document}";
                  await Clipboard.setData(
                    ClipboardData(
                      text:
                          LatexCode(
                            contactInfo: contactInfo,
                            educationInfo: educationInfo,
                            experienceInfo: experienceInfo,
                            skillsInfo: skillsInfo,
                            projects: projects,
                          ).getLatex(),
                    ),
                  );
                  print("Copied: ");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied test text')),
                  );
                  print("${projects.length}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open in Overleaf'),
                onPressed: _openOverleaf,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ElevatedButton(
          
          child: const Text("Test Copy"),
        ), */
