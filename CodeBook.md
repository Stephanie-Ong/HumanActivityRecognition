<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=Generator content="Microsoft Word 14 (filtered)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:10.0pt;
	margin-left:0cm;
	line-height:115%;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{font-family:"Calibri","sans-serif";}
.MsoPapDefault
	{margin-bottom:10.0pt;
	line-height:115%;}
@page WordSection1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
-->
</style>

</head>

<body lang=MS>

<div class=WordSection1>

<p class=MsoNormal>Codebook</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>Variable list and descriptions</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>Variables of Tidy Data (TidyData)</p>

<p class=MsoNormal>Variable name                                 Description</p>

<p class=MsoNormal>-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</p>

<p class=MsoNormal>SubjectId                                           The
Identifier of the Subject who performed the activity. Its range is from 1 to
30.</p>

<p class=MsoNormal>ActivityId                                            The
Identifier of the Activity. eg. 1,2,3,4,5,6</p>

<p class=MsoNormal>ActivityLabel                                     The
Activity Name that is unique to the ActivityId. eg. WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING,  LAYING </p>

<p class=MsoNormal>FeatureDomain                               eg. t = Time, f
= Frequency</p>

<p class=MsoNormal>FeatureType                                     eg. Gravity,
Body</p>

<p class=MsoNormal>FeatureMeasure                            eg. Acc, Gyro,
AccJerk, GyroJerk, AccMag, GyroMag, AccJerkMag, GyroJerkMag</p>

<p class=MsoNormal>FeatureAxial                                     eg.
X,Y,Z,&quot;&quot;</p>

<p class=MsoNormal>AverageMean                                  The Mean Value
of a Feature in the specific Domain, Axial and Measure.</p>

<p class=MsoNormal>AverageStandardDeviation        The Standard Deviation of a
Feature in the specific Domain, Axial and Measure.</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>str(TidyData)</p>

<p class=MsoNormal>'data.frame':     5940 obs. of  9 variables:</p>

<p class=MsoNormal> $ SubjectId                                       : int  1
1 1 1 1 1 1 1 1 1 ...</p>

<p class=MsoNormal> $ ActivityId                                        : int 
1 1 1 1 1 1 1 1 1 1 ...</p>

<p class=MsoNormal> $ ActivityLabel                                 : Factor w/
6 levels &quot;LAYING&quot;,&quot;SITTING&quot;,..: 4 4 4 4 4 4 4 4 4 4 ...</p>

<p class=MsoNormal> $ FeatureDomain                           : Factor w/ 2
levels &quot;f&quot;,&quot;t&quot;: 1 1 1 1 1 1 1 1 1 1 ...</p>

<p class=MsoNormal> $ FeatureType                                 : Factor w/ 2
levels &quot;Body&quot;,&quot;Gravity&quot;: 1 1 1 1 1 1 1 1 1 1 ...</p>

<p class=MsoNormal> $ FeatureMeasure                        : Factor w/ 8
levels &quot;Acc&quot;,&quot;AccJerk&quot;,..: 1 1 1 2 2 2 3 4 5 5 ...</p>

<p class=MsoNormal> $ FeatureAxial                                 : Factor w/
4 levels &quot;&quot;,&quot;X&quot;,&quot;Y&quot;,&quot;Z&quot;: 2 3 4 2 3 4 1
1 2 3 ...</p>

<p class=MsoNormal> $ AverageMean                             : num  -0.2028
0.0897 -0.3316 -0.1705 -0.0352 ...</p>

<p class=MsoNormal> $ AverageStandardDeviation    : num  -0.319 0.056 -0.28
-0.134 0.107 ...</p>

</div>

</body>

</html>
