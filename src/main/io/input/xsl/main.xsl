<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions">

    <xsl:template match="document">
        <fo:root font-family="TimesNewRoman">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-variant-0" page-height="29.7cm" page-width="21cm" margin-top="2cm" margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
                    <fo:region-body/>
                </fo:simple-page-master>

                <fo:simple-page-master master-name="A4-variant-1" page-height="29.7cm" page-width="22.5cm" margin-top="2cm" margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
                    <fo:region-body/>
                </fo:simple-page-master>

            </fo:layout-master-set>
            <fo:page-sequence master-reference="A4-variant-0">
                <fo:flow flow-name="xsl-region-body">

                    <!-- PAGE 0                   -->
                    <fo:block font-size="12pt">
                        <xsl:call-template name="page0"/>
                    </fo:block>

                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="A4-variant-1">
                <fo:flow flow-name="xsl-region-body">

                    <!-- PAGE1                   -->
                    <fo:block font-size="10pt" page-break-before="always">
                        <xsl:call-template name="page1"/>
                    </fo:block>

                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template name="default-page">

    </xsl:template>

    <xsl:template name="page0">
        <xsl:call-template name="default-page"/>
        <fo:block text-align="right" font-weight="600" font-size="12">Форма Ф-48</fo:block>
        <fo:list-block font-size="12" line-height="2.0" font-weight="600">
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        Подрядная организация______________________________
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-left="135px">
                        <xsl:value-of select="/document/orgExecutorOfWork"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        ____________________________________________________
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block>

                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        Строительство (реконструкция)_______________________
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-left="180px">
                        <xsl:value-of select="/document/permanentObjectInfo/permanentObjectName"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        ____________________________________________________
                    </fo:block>
                    <fo:block font-size="10" line-height="0.5" margin-left="65px">(наименование и месторасположение,</fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block>
                        <xsl:value-of select="/document/permanentObjectInfo/permanentObjectAddress/buildingAddress/federationSubject"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/permanentObjectInfo/permanentObjectAddress/buildingAddress/localityName"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/permanentObjectInfo/permanentObjectAddress/buildingAddress/сounty"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/permanentObjectInfo/permanentObjectAddress/buildingAddress/territory"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/permanentObjectInfo/permanentObjectAddress/buildingAddress/street"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/permanentObjectInfo/permanentObjectAddress/buildingAddress/building"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        ____________________________________________________
                    </fo:block>
                    <fo:block font-size="8" line-height="1.0" margin-left="120px">км, ПК)</fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block>

                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>

        <fo:block text-align="center" margin-top="130px" font-weight="600" font-size="12">
            <fo:list-block>
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block>ЖУРНАЛ №________ ИЗГОТОВЛЕНИЯ И ОСВИДЕТЕЛЬСТВОВАНИЯ</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block margin-right="210px">
                            <xsl:value-of select="/document/number"/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
            <fo:block>АРМАТУРНЫХ КАРКАСОВ ДЛЯ БЕТОНИРОВАНИЯ МОНОЛИТНЫХ И </fo:block>
            <fo:block>СБОРНЫХ ЖЕЛЕЗОБЕТОННЫХ КОНСТРУКЦИЙ НА СТРОИТЕЛЬСТВЕ</fo:block>
            <fo:block>(РЕКОНСТРУКЦИИ)</fo:block>
        </fo:block>

        <fo:list-block font-size="12" line-height="1.5" margin-top="140px" text-align="right" font-weight="600">

            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        Начат «___» _________________ 20____ г.
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block text-align="start" relative-align="baseline" line-height="1.25">
                        <fo:inline-container inline-progression-dimension="20%"  margin-left="307px">
                            <fo:block>
                                <xsl:value-of select="substring-after(substring-after(/document/journalInfoDate/beginDate, '-'), '-')"/>
                            </fo:block>
                        </fo:inline-container>
                        <fo:inline-container inline-progression-dimension="20%" margin-left="280px">
                            <fo:block>
                                <xsl:value-of select="substring-before(substring-after(/document/journalInfoDate/beginDate, '-'), '-')"/>
                            </fo:block>
                        </fo:inline-container>
                        <fo:inline-container inline-progression-dimension="20%" margin-left="260px">
                            <fo:block>
                                <xsl:value-of select="substring(substring-before(/document/journalInfoDate/beginDate, '-'), 3, 4)"/>
                            </fo:block>
                        </fo:inline-container>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>

            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        Окончен «___» _________________ 20____ г.
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block text-align="start" relative-align="baseline"  line-height="1.25">
                        <fo:inline-container inline-progression-dimension="20%"  margin-left="307px">
                            <fo:block>
                                <xsl:value-of select="substring-after(substring-after(/document/journalInfoDate/endDate, '-'), '-')"/>
                            </fo:block>
                        </fo:inline-container>
                        <fo:inline-container inline-progression-dimension="20%" margin-left="280px">
                            <fo:block>
                                <xsl:value-of select="substring-before(substring-after(/document/journalInfoDate/endDate, '-'), '-')"/>
                            </fo:block>
                        </fo:inline-container>
                        <fo:inline-container inline-progression-dimension="20%" margin-left="260px">
                            <fo:block>
                                <xsl:value-of select="substring(substring-before(/document/journalInfoDate/endDate, '-'), 3, 4)"/>
                            </fo:block>
                        </fo:inline-container>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>

        <fo:list-block font-size="12" line-height="1.5" margin-top="30px" text-align="right" font-weight="600">

            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        В журнале прошнуровано
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-left="120px">

                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>

            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        и пронумеровано_____стр.
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-right="25px">
                        <xsl:value-of select="/document/installers/installer/number"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>

        <fo:block font-size="12" line-height="1.5"  margin-top="30px" text-align="left" font-weight="600">Ответственный за</fo:block>
        <fo:list-block font-size="12" line-height="1.5" font-weight="600">
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        ведение журнала _________________________
                    </fo:block>
                    <fo:block font-size="10" line-height="1.0" margin-left="95px">(фамилия, инициалы, подпись)</fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-left="100px">
                        <xsl:value-of select="/document/installers/installer/fio/firstName"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/installers/installer/fio/lastName"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/installers/installer/fio/middleName"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>

        <fo:block line-height="2.0" font-weight="600">М.П.</fo:block>

        <fo:block text-align="right" margin-top="20px" font-weight="600">105</fo:block>

    </xsl:template>

    <xsl:template name="page1">
        <xsl:call-template name="default-page"/>
        <fo:table text-align="center" font-size="12" table-layout="fixed">
            <fo:table-body wrap-option="inherit">
                <fo:table-row border="solid 1px black">
                    <fo:table-cell number-rows-spanned="2" border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[1]/tableCell[1]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-rows-spanned="2" border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[1]/tableCell[2]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-rows-spanned="2" border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[1]/tableCell[3]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-rows-spanned="2" border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[1]/tableCell[4]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-rows-spanned="2" border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[1]/tableCell[5]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-columns-spanned="5" border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[1]/tableCell[6]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="solid 1px black">
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[2]/tableCell[1]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[2]/tableCell[2]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[2]/tableCell[3]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[2]/tableCell[4]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[2]/tableCell[5]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="solid 1px black">
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[1]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[2]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[3]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[4]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[5]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[6]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[7]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[8]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[9]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="solid 1px black">
                        <fo:block>
                            <xsl:call-template name="intersperse-with-zero-spaces">
                                <xsl:with-param name="str" select="/document/steelTable/tableBody/tableRow[3]/tableCell[10]"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>

        <fo:block font-size="12" margin-top="160px">Начальник участка</fo:block>
        <fo:list-block font-size="12" line-height="1.5">
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        (ст. прораб)_______________________________________________
                    </fo:block>
                    <fo:block font-size="10" line-height="1.0" margin-left="120px">(фамилия, инициалы, подпись)</fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-left="80px">
                        <xsl:value-of select="/document/workRecords/workRecord[1]/signOfResponsible/lastName"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/workRecords/workRecord[1]/signOfResponsible/initials"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/workRecords/workRecord[1]/signOfResponsible/sign"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>

        <fo:block margin-top="30px" font-size="12">Начальник производственно-</fo:block>
        <fo:list-block font-size="12" line-height="1.5">
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        технического отдела_______________________________________
                    </fo:block>
                    <fo:block font-size="10" line-height="1.0" margin-left="120px">(фамилия, инициалы, подпись)</fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block margin-left="120px">
                        <xsl:value-of select="/document/workRecords/workRecord[2]/signOfResponsible/lastName"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/workRecords/workRecord[2]/signOfResponsible/initials"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/document/workRecords/workRecord[2]/signOfResponsible/sign"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>

    </xsl:template>



    <xsl:template match="text()">
        <xsl:call-template name="intersperse-with-zero-spaces">
            <xsl:with-param name="str" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="intersperse-with-zero-spaces">
        <xsl:param name="str"/>
        <xsl:variable name="spacechars">
            &#x9;&#xA;
            &#x2000;&#x2001;&#x2002;&#x2003;&#x2004;&#x2005;
            &#x2006;&#x2007;&#x2008;&#x2009;&#x200A;&#x200B;
        </xsl:variable>

        <xsl:if test="string-length($str) &gt; 0">
            <xsl:variable name="c1" select="substring($str, 1, 1)"/>
            <xsl:variable name="c2" select="substring($str, 2, 1)"/>

            <xsl:value-of select="$c1"/>
            <xsl:if test="$c2 != '' and
        not(contains($spacechars, $c1) or
        contains($spacechars, $c2))">
                <xsl:text>&#x200B;</xsl:text>
            </xsl:if>

            <xsl:call-template name="intersperse-with-zero-spaces">
                <xsl:with-param name="str" select="substring($str, 2)"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>


</xsl:stylesheet>