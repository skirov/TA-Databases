<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method='html' version='1.0' encoding='UTF-8' indent='yes' />

  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;
</xsl:text>
    <html>
      <body style="font-family:Arial;font-size:12pt;background-color:#EEEEEE">
        <xsl:for-each select="class/student">
          <div>
            <p style="background-color:teal;color:white;padding:4px">
              Information about <xsl:value-of select="name"/>
            </p>
            <ul>
              <li>
                Name: <xsl:value-of select="name"/>
              </li>
              <li>
                Gender: <xsl:value-of select="gender"/>
              </li>
              <li>
                Birth date<xsl:value-of select="birthDate"/>
              </li>
              <li>
                Phone number: <xsl:value-of select="phoneNumber"/>
              </li>
              <li>
                Email: <xsl:value-of select="email"/>
              </li>
              <li>
                Course: <xsl:value-of select="course"/>
              </li>
              <li>
                Specialty: <xsl:value-of select="specialty"/>
              </li>
              <li>
                Faculty Number: <xsl:value-of select="facultyNumber"/>
              </li>
              <li>
                Taken Exams:
                <xsl:for-each select="takenExams/exam">
                  <ol>
                    <li>
                      Exam: <xsl:value-of select="examName"/>
                    </li>
                    <li>
                      Tutor: <xsl:value-of select="examTutor"/>
                    </li>
                    <li>
                      Score: <xsl:value-of select="score"/>
                    </li>
                  </ol>
                  <br />
                </xsl:for-each>
              </li>
              <li>
                Enrollment information:
                <xsl:for-each select="enrollmentInfo">
                  <ol>
                    <li>
                      Enrollment Date: <xsl:value-of select="enrollmentDate"/>
                    </li>
                    <li>
                      Exam Score: <xsl:value-of select="examScore"/>
                    </li>
                  </ol>
                </xsl:for-each>
              </li>
              <li>
                Teacher Endorsements:
                <xsl:for-each select="teacherEndorsements">
                  <ol>
                    <li>
                      <xsl:value-of select="endorsedBy"/>
                    </li>
                  </ol>
                </xsl:for-each>
              </li>
            </ul>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
