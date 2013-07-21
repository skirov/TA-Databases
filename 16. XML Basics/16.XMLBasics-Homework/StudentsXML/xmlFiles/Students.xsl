<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <body style="font-family:Arial;font-size:12pt;background-color:#EEEEEE">
        <xsl:for-each select="class/student">
          <div style="background-color:teal;color:white;padding:4px">
            <ul>
              <li>
                <xsl:value-of select="name"/>
              </li>
              <li>
                <xsl:value-of select="gender"/>
              </li>
              <li>
                <xsl:value-of select="birthDate"/>
              </li>
              <li>
                <xsl:value-of select="phoneNumber"/>
              </li>
              <li>
                <xsl:value-of select="email"/>
              </li>
              <li>
                <xsl:value-of select="course"/>
              </li>
              <li>
                <xsl:value-of select="specialty"/>
              </li>
              <li>
                <xsl:value-of select="facultyNumber"/>
              </li>
              <li>
                Taken Exams:
                <ol>
                  <xsl:for-each select="student/takenExams">
                    <li>
                      <xsl:value-of select="examName"/>
                      <xsl:value-of select="examTutor"/>
                      <xsl:value-of select="score"/>
                    </li>
                  </xsl:for-each>
                </ol>
              </li>
              <li>
                Enrollment information:
                <ol>
                  <xsl:for-each select="student/enrollmentInfo">
                    <li>
                      <xsl:value-of select="enrollmentDate"/>
                      <xsl:value-of select="examScore"/>
                    </li>
                  </xsl:for-each>
                </ol>
              </li>
              <li>
                Taken Exams:
                <ol>
                  <xsl:for-each select="student/teacherEndorsements">
                    <li>
                      <xsl:value-of select="endorsedBy"/>
                    </li>
                  </xsl:for-each>
                </ol>
              </li>
            </ul>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
