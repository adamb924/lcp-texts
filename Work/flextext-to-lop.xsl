<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:abg="http://www.adambaker.org/gloss.php" xmlns:exslt="http://exslt.org/common" xmlns:file="http://expath.org/ns/file" exclude-result-prefixes="abg exslt file" version="2.0">

<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/> 

<xsl:strip-space elements="*"/>

<xsl:param name="export-configuration"></xsl:param>

<xsl:variable name="configuration" select="document($export-configuration)/flextext2html-configuration"/>
<xsl:variable name="meta-writing-system" select="$configuration/meta-language/@lang"/>
<xsl:variable name="title" select="/document/interlinear-text/item[@type='title']/text()"/>
<xsl:variable name="first-line-writing-system" select="/document/interlinear-text/languages/language[@lang=$configuration/line[1]/@writing-system]"/>

<xsl:variable name="definitions">
<definition abbr="EZ">The ezafa marker is a marker that is used to join together nouns and adjectives.</definition>
<definition abbr="PL">The plural marker is used when there is more than one of something.</definition>
<definition abbr="PST">This identifies the past stem of the verb. (The past stem is used to form past tenses, but also participles.)</definition>
<definition abbr="PART">This turns the past stem into a participle.</definition>
<definition abbr="1P">First person plural. In English this would be either “we” or “us.” When this occurs at the end of a verb, it is showing that the subject of the verb is “we.” When this occurs on a noun, it means “our.”</definition>
<definition abbr="1S">First person singular. In English this would be either “I” or “me.” When this occurs at the end of a verb, it is showing that the subject of the verb is “I.” When this occurs on a noun, it means “my.”</definition>
<definition abbr="2P">Second person plural. In English this would be “you.” When this occurs at the end of a verb, it is showing that the subject of the verb is “you.” When this occurs on a noun, it means “your.” (English doesn't have a different word for plural “you” except—for some people—“y'all.”)</definition>
<definition abbr="2S">Second person singular. In English this would be “you.” When this occurs at the end of a verb, it is showing that the subject of the verb is “you.” When this occurs on a noun, it means “your.”</definition>
<definition abbr="3P">Third person plural. In English this would be “they.” When this occurs at the end of a verb, it is showing that the subject of the verb is “they.” When this occurs on a noun, it means “their.”</definition>
<definition abbr="3S">Third person singular. In English this would be either “he,” “she,” or “it.” When this occurs at the end of a verb, it is showing that the subject of the verb is “he,” “she,” or “it.”  When this occurs on a noun, it means “his,” “her,” or “its.”</definition>
<definition abbr="ADJ">Adjectivizer. This turns a noun into an adjective. This isn't used much in English but we do have <em>-ous</em> in “joy”→“joyous” or <em>-al</em> in “foundation”→“foundational.”</definition>
<definition abbr="ADV">Adverb. This turns a word into an adverb, like adding <em>-ly</em> in English (“happy”→“happily”).</definition>
<definition abbr="COMP">Comparative. This turns “strong” into “stronger.”</definition>
<definition abbr="CONT">Continuous. This is the می [me] prefix that occurs in the simple present tense, and the past continuous tense.</definition>
<definition abbr="INDEF">Indefinite. This changes “dog” into “a dog.”</definition>
<definition abbr="INF">Infinitive. This suffix attaches to the past tense stem to make an infinitive, like English <em>to</em> in “to run” or “to swim.”</definition>
<definition abbr="NEG">Negative. This makes a verb negative, like <em>not</em> in English, “I am not going.”</definition>
<definition abbr="NOM">Nominalizer. This turns a word into an abstract noun, like adding <em>-ness</em> or <em>-y</em> in English (“happy”→“happiness” or “modest”→“modesty”). </definition>
<definition abbr="REL">Relativizer. This introduces a relative clause, e.g., “a man <em>who likes sports</em>” or “a book <em>that isn't too long</em>.” A word with this suffix is often followed by که.</definition>
<definition abbr="SUBJ">Subjunctive. This prefix attaches to the present tense stem of the verb and turns it into a subjunctive.</definition>
<definition abbr="SUPER">Superlative. This turns “strong” into “strongest.”</definition>
<definition abbr="DEF">Definite direct object. This marker is placed after a direct object (i.e., the thing that receives the action of the verb) that is something definite, somewhat like the difference betweeen English “the apple” instead of “an apple.”</definition>
</xsl:variable>

<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
<html>
<head>
<meta charset="utf-8" />
<title><xsl:value-of select="$title"/></title>
<script type="text/javascript" src="script-text.js"></script>
</head>
<body>
<h1><xsl:value-of select="$title"/></h1>
<xsl:text>&#xa;</xsl:text>
<div class="text"><xsl:text>
</xsl:text><xsl:apply-templates/>
</div>
<div style="height: 200px;"> </div>
</body>
</html>
</xsl:template>

<xsl:template match="/document/interlinear-text/paragraphs">
	<div class="paragraphs">
		<xsl:apply-templates/>
	</div>
</xsl:template>

<xsl:template match="/document/interlinear-text/paragraphs/paragraph">
<xsl:text>&#xa;</xsl:text>
	<xsl:choose>
		<xsl:when test="@abg:title and string-length(@abg:title) &gt; 0">
			<div class="header">
			<xsl:apply-templates select="phrases/phrase[1]"/>
			</div>
			<xsl:if test="count(phrases/phrase) &gt; 1">
				<div class="paragraph">
					<xsl:apply-templates select="phrases/phrase[position() &gt; 1]"/>
				</div>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<div class="paragraph">
			<xsl:apply-templates select="phrases/phrase"/>
			</div>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="phrases/phrase/words/word/abg:annotation[string-length(abg:annotation-header/text()) = 0]">
		<div>
			<ul class="annotations">
				<xsl:apply-templates mode="end-annotations" select="phrases/phrase/words/word/abg:annotation[string-length(abg:annotation-header/text()) = 0]"/>
			</ul>
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="/document/interlinear-text/paragraphs/paragraph/phrases/phrase">
<xsl:text>&#xa;</xsl:text>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="abg:annotation" mode="end-annotations">
<li><xsl:apply-templates select="abg:annotation-text"/></li>
</xsl:template>

<xsl:template match="/document/interlinear-text/paragraphs/paragraph/phrases/phrase/words/word">
	<xsl:variable name="word-node" select="."/>
	<xsl:text>&#xa;</xsl:text>
	<div>
		<xsl:choose>
			<xsl:when test="item[@type='punct']">
				<xsl:attribute name="class">punct<xsl:if test="item/text() = (')','،','؛','!','؟','&quot;.','.','.&quot;','...',':',']') "> following-space</xsl:if><xsl:if test="item/text() = ('(','[') "> preceding-space</xsl:if></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">word</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="$configuration/line">
			<xsl:choose>
				<xsl:when test="@type='gls' or @type='txt'">
					<xsl:if test="$word-node/item[ (@lang = current()/@writing-system or @lang='arb-Arab') and (@type = current()/@type or @type = 'punct')]">
						<span>
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="$word-node/@abg:baseline-writing-system='arb-Arab'">
										<xsl:text>arb-Arab</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@writing-system"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text> </xsl:text>
								<xsl:value-of select="@type"/>
								</xsl:attribute>
							<xsl:if test="$word-node/@abg:baseline-writing-system='arb-Arab'">
								<xsl:attribute name="title">This is an Arabic word. See the notes for a translation.</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="$word-node/item[ (@lang = current()/@writing-system or @lang='arb-Arab') and (@type = current()/@type or @type = 'punct')]"/>
						</span>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="$word-node/morphemes[@*[local-name()='lang' and namespace-uri()='http://www.adambaker.org/gloss.php'] = current()/@baseline-writing-system]" mode="morpheme-processor">
						<xsl:with-param name="writing-system" select="@display-writing-system"/>
						<xsl:with-param name="type" select="@line-type"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>&#xa;</xsl:text>
		</xsl:for-each>
		<xsl:apply-templates mode="inline-annotations" select="abg:annotation[string-length(abg:annotation-header/text()) &gt; 0]"/>
	</div>
</xsl:template>

<xsl:template match="abg:annotation" mode="inline-annotations">
<span class="inline-annotation">
<span class="header"><xsl:value-of select="abg:annotation-header"/></span>
<span class="text"><xsl:apply-templates select="abg:annotation-text"/></span>
</span>
</xsl:template>

<xsl:template match="abg:annotation-text">
<xsl:variable name="first" select="replace(text(), '\\gl\{([^\}]*)\}', '‘$1’')"/>
<xsl:variable name="second" select="replace($first, '\\p\{([^\}]*)\}', '$1')"/>
<xsl:value-of select="$second"/>
</xsl:template>

<!-- Begin morphological analysis output templates -->
<xsl:template match="morphemes" mode="morpheme-processor">
	<xsl:param name="writing-system"/>
	<xsl:param name="type"/>
	<span>
		<xsl:attribute name="class">ma <xsl:value-of select="$writing-system"/><xsl:text> </xsl:text><xsl:value-of select="$type"/></xsl:attribute>
		<xsl:apply-templates select="morph/item[@lang=$writing-system and @type=$type]" mode="morpheme-processor"/>
	</span>
</xsl:template>

<xsl:template match="item" mode="morpheme-processor">
	<xsl:variable name="txt" select="text()"/>
	<xsl:choose>
		<xsl:when test="@lang='en-latin' and ancestor::morph[@type='Suffix' or @type='Prefix' or @type='Enclitic' or @type='Proclitic']">
			<xsl:call-template name="definition">
				<xsl:with-param name="abbreviation" select="text()"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="text() = 'DEF'">
					<xsl:call-template name="definition">
						<xsl:with-param name="abbreviation" select="'DEF'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="contains(text(),'.PST')">
					<xsl:value-of select="substring-before(text(),'PST')"/>
					<xsl:call-template name="definition">
						<xsl:with-param name="abbreviation" select="'PST'"/>
					</xsl:call-template>
					<xsl:value-of select="substring-after(text(),'PST')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="parent::morph/following-sibling::morph">
		<xsl:choose>
			<xsl:when test="parent::morph/following-sibling::morph[1]/@type = 'Proclitic' or parent::morph/following-sibling::morph[1]/@type = 'Enclitic'">=</xsl:when>
			<xsl:otherwise>-</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

<xsl:template name="definition">
	<xsl:param name="abbreviation"/>
	<span class="definable">
		<xsl:value-of select="$abbreviation"/>
	</span>
	<span class="definition">
		<xsl:apply-templates mode="copy-definition" select="exslt:node-set($definitions)/definition[@abbr=$abbreviation]"/>
	</span>

</xsl:template>

<xsl:template match="*" mode="copy-definition">
	<xsl:choose>
		<xsl:when test="local-name() = 'definition'">
			<xsl:apply-templates mode="copy-definition" select="node()"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy>
				<xsl:apply-templates mode="copy-definition" select="node()"/>
			</xsl:copy>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- End morphological analysis output templates -->

<xsl:template match="item" mode="word-processor">
<xsl:text>&#xa;</xsl:text>
	<span>
		<xsl:attribute name="class"><xsl:value-of select="@lang"/><xsl:text> </xsl:text><xsl:value-of select="@type"/></xsl:attribute>
		<xsl:value-of select="text()"/>
	</span>
</xsl:template>

<xsl:template match="/document/interlinear-text/languages/language" mode="writing-systems">
.<xsl:value-of select="@lang"/> {
	font-family: <xsl:value-of select="@font"/>;
	font-size: <xsl:value-of select="@*[local-name()='font-size' and namespace-uri()='http://www.adambaker.org/gloss.php']"/>pt;
	direction: <xsl:choose><xsl:when test="@RightToLeft='true'">rtl</xsl:when><xsl:otherwise>ltr</xsl:otherwise></xsl:choose>;
	text-align: <xsl:choose><xsl:when test="$first-line-writing-system/@RightToLeft = 'true'">right</xsl:when><xsl:otherwise>left</xsl:otherwise></xsl:choose>;
	
}
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>