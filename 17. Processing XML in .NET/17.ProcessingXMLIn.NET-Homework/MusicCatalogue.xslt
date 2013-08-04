<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <body>
        <h2>Catalog</h2>
        <table border="1">
          <tr bgcolor="#9acd32">
            <th>Name</th>
            <th>Artist</th>
            <th>year</th>
            <th>producer</th>
            <th>price</th>
            <th>songs</th>
          </tr>
          <xsl:for-each select="catalog/album">
            <tr>
              <td>
                <xsl:value-of select="name"/>
              </td>
              <td>
                <xsl:value-of select="artist"/>
              </td>
              <td>
                <xsl:value-of select="year"/>
              </td>
              <td>
                <xsl:value-of select="producer"/>
              </td>
              <td>
                <xsl:value-of select="price"/>
              </td>
              <td>
                <table>
                  <xsl:for-each select="./songs">
                    <xsl:for-each select="./song">
                      <tr>
                        <td>
                          <xsl:value-of select="title"/>
                        </td>
                        <td>
                          - <xsl:value-of select="duration"/> min
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:for-each>
                </table>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>