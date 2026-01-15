

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><title>
	Bildungs-Management-System
</title><meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/Styles/style.css" />
    
    
    

    
    
   
    

<link rel="stylesheet" type="text/css" href="/Styles/Bms.css" /><link rel="stylesheet" type="text/css" href="/Styles/tree.css" /><link rel="stylesheet" type="text/css" href="/Styles/spin.css" /><link rel="stylesheet" type="text/css" href="/Styles/jquery/jquery-ui-timepicker-addon-1.6.3.css" /><link rel="stylesheet" type="text/css" href="/Styles/jquery/gray.min-1.4.5.css" /><link rel="stylesheet" type="text/css" href="/Styles/jquery/jquery.dropdown.css" />

	
	<script type="text/javascript" src="/Scripts/jquery-2.2.4.min.js"></script>

	
	

	<script type="text/javascript" src="/Scripts/jquery-ui-1.13.2.min.js"></script>
	<script type="text/javascript" src="/Scripts/jquery-ui-timepicker-addon-1.6.3.js"></script>
	<script type="text/javascript" src="/Scripts/jquery.cookie-1.4.1.js"></script>
	<script type="text/javascript" src="/Scripts/jquery.nestable.js"></script>
	<script type="text/javascript" src="/Scripts/jquery.gray-1.4.5.min.js"></script>

	
	

	
	

	
	<script type="text/javascript" src="/Scripts/tinymce-4.3.13/tinymce.min.js"></script>
	<script type="text/javascript" src="/Scripts/jquery.dropdown.js"></script>

	
	<script type="text/javascript" src="/Scripts/spin.min.js"></script>
	
	<script type="text/javascript" src="/Scripts/Helper.js"></script>
	<script type="text/javascript" src="/Scripts/Common.js"></script>
	<script type="text/javascript" src="/Scripts/ContextMenu.js"></script>
	<script type="text/javascript" src="/Scripts/Help.js"></script>
	<script type="text/javascript" src="/Scripts/DateTimePicker.js"></script>
	<script type="text/javascript" src="/Scripts/Forms.js"></script>
	<script type="text/javascript" src="/Scripts/TabListener.js"></script>
	<script type="text/javascript" src="/Scripts/Dialogs.js"></script>
	<script type="text/javascript" src="/Scripts/Navi.js"></script>
	<script type="text/javascript" src="/Scripts/MultiSelect.js"></script>
	<script type="text/javascript" src="/Scripts/TableRow.js"></script>
	<script type="text/javascript" src="/Scripts/MassActions.js"></script>
	<script type="text/javascript" src="/Scripts/LoadingAnimation.js"></script>
	<!--<script type="text/javascript" src="/Scripts/TreeValidators.js"></script>-->
	<script type="text/javascript">
        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            ShowMessageIfFilled();
        });

		function BeginRequestHandler(sender, args) {
		}

		/* Nach Abschluss eines Async PostBacks */
		function EndRequestHandler(sender, args) {
			ShowMessageIfFilled();
			EnableAllLinks();
			ValidateFields();
			ValidateActions();
			BindContextMenuEvents();
			BindHelpEvents();
			InitTabs();
			InitDateTimePicker();
			InitMoreLinks();
			InitTreeDelayed();
			ShowUsedMoreSearchFieldsets();
			//ggf. vorhandene Modaldialoge neu justieren
			var $objs = $('.modal');
			SetModalSizes($objs);

			BindScrollEvents();
			SetSavedScrollPositions();
		}

		function ChangeColor() {
			$("#colorStyles").attr("href", "/Styles/sw.css");
		}
	</script>
</head>
<body>
	<form method="post" action="./lastminute.aspx" id="ctl01">
<div class="aspNetHidden">
<input type="hidden" name="__SKM_VIEWSTATEID" id="__SKM_VIEWSTATEID" value="639040803539431055-c2f5dc7e-c2cb-42fb-b2ee-6352ac473b55.vs" />
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="" />
</div>


<script type="text/javascript">
//<![CDATA[
var __cultureInfo = {"name":"de-DE","numberFormat":{"CurrencyDecimalDigits":2,"CurrencyDecimalSeparator":",","IsReadOnly":true,"CurrencyGroupSizes":[3],"NumberGroupSizes":[3],"PercentGroupSizes":[3],"CurrencyGroupSeparator":".","CurrencySymbol":"€","NaNSymbol":"NaN","CurrencyNegativePattern":8,"NumberNegativePattern":1,"PercentPositivePattern":0,"PercentNegativePattern":0,"NegativeInfinitySymbol":"-∞","NegativeSign":"-","NumberDecimalDigits":2,"NumberDecimalSeparator":",","NumberGroupSeparator":".","CurrencyPositivePattern":3,"PositiveInfinitySymbol":"∞","PositiveSign":"+","PercentDecimalDigits":2,"PercentDecimalSeparator":",","PercentGroupSeparator":".","PercentSymbol":"%","PerMilleSymbol":"‰","NativeDigits":["0","1","2","3","4","5","6","7","8","9"],"DigitSubstitution":1},"dateTimeFormat":{"AMDesignator":"","Calendar":{"MinSupportedDateTime":"\/Date(-62135596800000)\/","MaxSupportedDateTime":"\/Date(253402297199999)\/","AlgorithmType":1,"CalendarType":1,"Eras":[1],"TwoDigitYearMax":2049,"IsReadOnly":true},"DateSeparator":".","FirstDayOfWeek":1,"CalendarWeekRule":2,"FullDateTimePattern":"dddd, d. MMMM yyyy HH:mm:ss","LongDatePattern":"dddd, d. MMMM yyyy","LongTimePattern":"HH:mm:ss","MonthDayPattern":"d. MMMM","PMDesignator":"","RFC1123Pattern":"ddd, dd MMM yyyy HH\u0027:\u0027mm\u0027:\u0027ss \u0027GMT\u0027","ShortDatePattern":"dd.MM.yyyy","ShortTimePattern":"HH:mm","SortableDateTimePattern":"yyyy\u0027-\u0027MM\u0027-\u0027dd\u0027T\u0027HH\u0027:\u0027mm\u0027:\u0027ss","TimeSeparator":":","UniversalSortableDateTimePattern":"yyyy\u0027-\u0027MM\u0027-\u0027dd HH\u0027:\u0027mm\u0027:\u0027ss\u0027Z\u0027","YearMonthPattern":"MMMM yyyy","AbbreviatedDayNames":["So","Mo","Di","Mi","Do","Fr","Sa"],"ShortestDayNames":["So","Mo","Di","Mi","Do","Fr","Sa"],"DayNames":["Sonntag","Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag"],"AbbreviatedMonthNames":["Jan","Feb","Mrz","Apr","Mai","Jun","Jul","Aug","Sep","Okt","Nov","Dez",""],"MonthNames":["Januar","Februar","März","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember",""],"IsReadOnly":true,"NativeCalendarName":"Gregorianischer Kalender","AbbreviatedMonthGenitiveNames":["Jan","Feb","Mrz","Apr","Mai","Jun","Jul","Aug","Sep","Okt","Nov","Dez",""],"MonthGenitiveNames":["Januar","Februar","März","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember",""]},"eras":[1,"n. Chr.",null,0]};//]]>
</script>

<script src="/ScriptResource.axd?d=U7GCJJ_avcu0pu4IoystF1If1Oz4jHh_jgh6ijghYstoqiBZE3gI5cgJYTu4cZ8otZtRrJlSU56Z2Qe3a5pnhPiUOjhVgMkucvc6fEiihlieRU28LY_tZ7O0oZmUubA709r5Vw381dP0UkBd3F3gYa8BOw-xvQ6E0HpDPA_MhS01&amp;t=5c0e0825" type="text/javascript"></script>
		
		<div id="pageArea">
			
    <div class="logoContainer">
        <!-- <a href="/"> -->
        <img id="ContentHeadArea_ImgBackgroundLogo" class="backgroundLogo" src="/Images/logo_background.png" alt="Logo" /></a>
        <div id="ContentHeadArea_UpdatePanel2">
	
                <div id="ContentHeadArea_Div1" class="message"></div>
            
</div>
        <img id="ContentHeadArea_ImgLogo" class="logo" src="/Images/logo_klein.png" alt="Logo" />
        <div class="divTopMessage">
	        <h2 title='Version: 1.5.7.30-ebc7e56d
 / 28.10.2025 16:46:12'>BILDUNGSMANAGEMENTSYSTEM<br/>DER FEUERWEHREN IN BAYERN</h2>
        </div>
    </div>

			
    <div id="topArea">
        <div class="g-L">
            <div class="b-M">
                <ul>
                    
                            <li id="ContentTopArea_RepNavigationMenu_LiItem_0" class="iconLastMinute active">
                                <a id="ContentTopArea_RepNavigationMenu_HlItem_0" href="LastMinute.aspx"><span>RESTPLATZBÖRSE</span></a></li>
                        
                </ul>
            </div>
            <div class="b-XS">
                <ol class="iconList">
                    <li>
                        

                        <a id="ContentTopArea_HlLogin" title="Anmelden" class="iconLogin" href="/Account/Login.aspx"></a>

                        <a id="ContentTopArea_LbtnChgColor" title="Farbe wechseln" class="chgColor" href="javascript:__doPostBack(&#39;ctl00$ctl00$ContentTopArea$LbtnChgColor&#39;,&#39;&#39;)"></a>

                        <a id="ContentTopArea_LbtnTextSizeExtraLarge" title="Schrift größer" class="textExtraLarge" href="javascript:__doPostBack(&#39;ctl00$ctl00$ContentTopArea$LbtnTextSizeExtraLarge&#39;,&#39;&#39;)"></a>

                        <a id="ContentTopArea_LbtnTextSizeLarge" title="Schrift groß" class="textLarge" href="javascript:__doPostBack(&#39;ctl00$ctl00$ContentTopArea$LbtnTextSizeLarge&#39;,&#39;&#39;)"></a>

                        <a id="ContentTopArea_LbtnTextSizeNormal" title="Schrift normal" class="textNormal" href="javascript:__doPostBack(&#39;ctl00$ctl00$ContentTopArea$LbtnTextSizeNormal&#39;,&#39;&#39;)"></a>
                    
                        <a id="ContentTopArea_HlImpressum" title="Impressum" class="textImpressum" href="../../About.aspx?AppArea=2"></a>
                    </li>
                </ol>
            </div>
        </div>
    </div>

			<div id="mainArea">
				<div id="innerArea">
					
	
	<div class="g-L">
		<div id="CM_CM_CtrlCourses_DivMain" class="b-L">
    <div class="head">
        <h3>Restplatzbörse</h3>
        
<div id="DivMain_CtrlCourses_CM_CM" class="helpArticle">
    
<div id="DivMain_CtrlCourses_CM_CM_Show" class="helpArticleDetails hidden">
    <div class="b-M">
        <div class="head">
            <h3>Hilfe</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_ctl00_CtrlHelpArticleDetails_UpdatePanel1">
	
                    <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$ctl00$CtrlHelpArticleDetails$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_ctl00_CtrlHelpArticleDetails__tbHelpContent" class="htmlEditor" style="height:450px;width:100%;">
</textarea>
                
</div>
        </div>
    </div>
</div>

    
<div id="DivMain_CtrlCourses_CM_CM_Edit" class="helpArticleEdit hidden">
    <div class="b-M">
        <div class="head">
            <h3>
                Hilfe bearbeiten</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_ctl00_CtrlHelpArticleEdit_UpdatePanel1">
	
                    <div>
                        <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$ctl00$CtrlHelpArticleEdit$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_ctl00_CtrlHelpArticleEdit__tbHelpContent" class="htmlEditor _vdMaxLength" data-maxlength="4000" style="height:450px;width:100%;">
</textarea>
                    </div>
                    <div class="butL">
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_ctl00_CtrlHelpArticleEdit_LbtnSave" class="btHelpArticleEditSave" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$ctl00$CtrlHelpArticleEdit$LbtnSave&#39;,&#39;&#39;)">Speichern</a>
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_ctl00_CtrlHelpArticleEdit_LbtnAbort" class="btHelpArticleEditSaveCancel" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$ctl00$CtrlHelpArticleEdit$LbtnAbort&#39;,&#39;&#39;)">Abbrechen</a>
                    </div>
                
</div>
        </div>
    </div>
</div>

</div>

    </div>
    <div class="cont scrollH">
        
        <div class="result ">
<div>
	<table class="list" cellspacing="0" rules="all" border="1" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid" style="border-collapse:collapse;">
		<tr class="headerRow">
			<th scope="col" style="width:10px;"><a title="Nach Typ sortieren" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid&#39;,&#39;Sort$OfferTypeId&#39;)"><span>Typ</span></a><input type="hidden" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl01$HfCurrentlySelectedRow" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_HfCurrentlySelectedRow" /></th><th scope="col"><a title="Nach Terminschlüssel sortieren" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid&#39;,&#39;Sort$CourseKey&#39;)"><span>Terminschlüssel</span></a></th><th scope="col"><a title="Nach Lehrgangsbezeichnung sortieren" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid&#39;,&#39;Sort$OfferTitle&#39;)"><span>Lehrgangsbezeichnung</span></a></th><th class="sorted" scope="col"><a title="Nach Beginn sortieren" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid&#39;,&#39;Sort$Begin&#39;)"><span>Beginn</span><img src="/Images/i_table_sort_ascent.gif" alt="Sortieren"/></a></th><th scope="col"><a title="Nach Ende sortieren" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid&#39;,&#39;Sort$End&#39;)"><span>Ende</span></a></th><th scope="col"><a title="Nach Schulungsort sortieren" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid&#39;,&#39;Sort$LocationBriefDescription&#39;)"><span>Schulungsort</span></a></th><th scope="col"><a title="Nach Freie Plätze sortieren" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid&#39;,&#39;Sort$ParticipantsFreeSeats&#39;)"><span>Freie Pl&#228;tze</span></a></th>
		</tr><tr class="odd">
			<td>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_DivImg_0" class="tableTypeCentralImg tableTypeImgSize" title="zentral"></div>
			</td><td>
				<span id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_0" class="contextMenu" data-id="8302"><div class="context-menu-content"><span><a id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_0_LbtnDetails_0" onclick="return TriggerButtonClick(this, &#39;BtnUpdateDetails&#39;)" class="first">Details</a></span></div></span>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_UpdatePanel_0">
				
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl02$BtnUpdateDetails" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateDetails_0" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl02$BtnUpdateEnrol" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateEnrol_0" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl02$BtnUpdateBook" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateBook_0" class="hidden" />
					
			</div>
				<div class="nowrap">01 02 C40 001 26</div>
			</td><td>Ger&#228;tewart TSF</td><td>
				26.01.2026 10:15 Uhr
			</td><td>
				28.01.2026 14:00 Uhr
			</td><td>SFS-R</td><td class="lastCol">7</td>
		</tr><tr class="even">
			<td>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_DivImg_1" class="tableTypeCentralImg tableTypeImgSize" title="zentral"></div>
			</td><td>
				<span id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_1" class="contextMenu" data-id="8281"><div class="context-menu-content"><span><a id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_1_LbtnDetails_1" onclick="return TriggerButtonClick(this, &#39;BtnUpdateDetails&#39;)" class="first">Details</a></span></div></span>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_UpdatePanel_1">
				
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl03$BtnUpdateDetails" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateDetails_1" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl03$BtnUpdateEnrol" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateEnrol_1" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl03$BtnUpdateBook" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateBook_1" class="hidden" />
					
			</div>
				<div class="nowrap">01 02 C96 001 26</div>
			</td><td>Fachteil f&#252;r Ausbilder f&#252;r Modulare Truppausbildung</td><td>
				26.01.2026 10:15 Uhr
			</td><td>
				30.01.2026 14:00 Uhr
			</td><td>SFS-R</td><td class="lastCol">4</td>
		</tr><tr class="odd">
			<td>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_DivImg_2" class="tableTypeCentralImg tableTypeImgSize" title="zentral"></div>
			</td><td>
				<span id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_2" class="contextMenu" data-id="8577"><div class="context-menu-content"><span><a id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_2_LbtnDetails_2" onclick="return TriggerButtonClick(this, &#39;BtnUpdateDetails&#39;)" class="first">Details</a></span></div></span>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_UpdatePanel_2">
				
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl04$BtnUpdateDetails" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateDetails_2" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl04$BtnUpdateEnrol" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateEnrol_2" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl04$BtnUpdateBook" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateBook_2" class="hidden" />
					
			</div>
				<div class="nowrap">01 04 C40 002 26</div>
			</td><td>Ger&#228;tewart TSF</td><td>
				27.01.2026 09:45 Uhr
			</td><td>
				29.01.2026 17:00 Uhr
			</td><td>SFS-W</td><td class="lastCol">15</td>
		</tr><tr class="even">
			<td>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_DivImg_3" class="tableTypeCentralImg tableTypeImgSize" title="zentral"></div>
			</td><td>
				<span id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_3" class="contextMenu" data-id="8303"><div class="context-menu-content"><span><a id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_3_LbtnDetails_3" onclick="return TriggerButtonClick(this, &#39;BtnUpdateDetails&#39;)" class="first">Details</a></span></div></span>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_UpdatePanel_3">
				
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl05$BtnUpdateDetails" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateDetails_3" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl05$BtnUpdateEnrol" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateEnrol_3" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl05$BtnUpdateBook" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateBook_3" class="hidden" />
					
			</div>
				<div class="nowrap">01 02 C40 002 26</div>
			</td><td>Ger&#228;tewart TSF</td><td>
				28.01.2026 10:15 Uhr
			</td><td>
				30.01.2026 14:00 Uhr
			</td><td>SFS-R</td><td class="lastCol">1</td>
		</tr><tr class="odd">
			<td>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_DivImg_4" class="tableTypeCentralImg tableTypeImgSize" title="zentral"></div>
			</td><td>
				<span id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_4" class="contextMenu" data-id="8282"><div class="context-menu-content"><span><a id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_CtxMenu_4_LbtnDetails_4" onclick="return TriggerButtonClick(this, &#39;BtnUpdateDetails&#39;)" class="first">Details</a></span></div></span>
				<div id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_UpdatePanel_4">
				
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl06$BtnUpdateDetails" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateDetails_4" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl06$BtnUpdateEnrol" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateEnrol_4" class="hidden" />
						<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl06$BtnUpdateBook" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_CtrlGrid_BtnUpdateBook_4" class="hidden" />
					
			</div>
				<div class="nowrap">01 02 C96 002 26</div>
			</td><td>Fachteil f&#252;r Ausbilder f&#252;r Modulare Truppausbildung</td><td>
				02.02.2026 10:15 Uhr
			</td><td>
				06.02.2026 14:00 Uhr
			</td><td>SFS-R</td><td class="lastCol">8</td>
		</tr><tr class="pagingRow">
			<td class="lastCol" colspan="7"><a title="Erste Seite" class="paging first" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl00&#39;,&#39;&#39;)">&nbsp;</a><a title="Vorherige Seite" class="paging prev" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl01&#39;,&#39;&#39;)">&nbsp;</a><input name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl02" type="text" value="1" /><span class="text">von 1&nbsp;&nbsp;</span><a title="Nächste Seite" class="paging next" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl04&#39;,&#39;&#39;)">&nbsp;</a><a title="Letzte Seite" class="paging last" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl05&#39;,&#39;&#39;)">&nbsp;</a><select name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl06">
				<option selected="selected" value="10">10</option>
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>

			</select><span class="text"> Ergebnisse pro Seite</span><span class="text resultNo">Ihre Suche ergab 5 Treffer</span><a class="btn_right" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl09&#39;,&#39;&#39;)">Export</a><a class="btn_right" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$CtrlGrid$ctl08$ctl10&#39;,&#39;&#39;)">PDF-Export</a></td>
		</tr>
	</table>
</div></div>
<div id="CM_CM_CtrlCourses_CtrlCoursesList_UpMassAction">
	<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$BtnMassModal" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_BtnMassModal" class="hidden" /><input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCoursesList$BtnMassModalAll" value="" id="CM_CM_CtrlCourses_CtrlCoursesList_BtnMassModalAll" class="hidden" />
</div>
    </div>
</div>




<div id="CM_CM_CtrlCourses_UpDetails" class="modal">
	
        
<div class="b-M">
    <div class="head">
        <h3>
            Lehrgangstermindetails</h3>
        
    </div>
    <div class="cont">
        

<div class="b-M shortDetails">
    <div class="head">
        <h3>Lehrgangsdetails</h3>
    </div>
    <div class="cont">
        <table id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_CtrlBmsTable" cellspacing="0" cellpadding="1" style="border-collapse:collapse;">
		<tr id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_TableRow1">
			<td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc1ShortDescription" class="label width_4_1">Lehrgangsnummer</td><td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc2ShortDescription" class="value width_4_2"></td><td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc1Title" class="label width_4_3">Lehrgangsbezeichnung</td><td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc2Title" class="value lastCol width_4_4"></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_TableRow2">
			<td class="label width_4_1">Ausbildungsdauer (Tage)</td><td class="value width_4_2"></td><td class="label width_4_3">Teilnehmerkreis</td><td class="value lastCol width_4_4"></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_TableRow3">
			<td class="label width_4_1">Vorausgesetzte Ausbildung</td><td class="value width_4_2"></td><td class="label width_4_3">Sonstige Voraussetzungen</td><td class="value lastCol width_4_4"></td>
		</tr><tr>
			<td class="label width_4_1">Mitzubringende Ausstattung</td><td class="value width_4_2"></td><td class="label width_4_3">Ausbildungsziel</td><td class="value lastCol width_4_4"></td>
		</tr><tr>
			<td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc1Content" class="label width_4_1">Ausbildungsinhalte</td><td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc2Content" class="value width_4_2"></td><td class="label width_4_3">Ausbildungsstätte</td><td class="value lastCol width_4_4"></td>
		</tr><tr>
			<td class="label width_4_1">Hinweise</td><td class="value lastCol" colspan="3"></td>
		</tr><tr>
			<td class="label width_4_1">Teilnehmerzahl</td><td class="value lastCol" colspan="3"></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_TableRowForeign">
			<td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc1ForeignId" class="label width_4_1">Leveso-Id</td><td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc2ForeignId" class="value width_4_2"></td><td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc1OfferPlanningCycleAssignments" class="label width_4_3">Planungszyklen</td><td id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlOfferDetailsShort_Tc2OfferPlanningCycleAssignments" class="value lastCol width_4_4"></td>
		</tr>
	</table>
    </div>
</div>

        <div class="b-M">
            <div class="head">
                <h3>Lehrgangstermin</h3>
                
<div id="CtrlCourseDetailsLong_CtrlCourses_CM_CM" class="helpArticle">
    
<div id="CtrlCourseDetailsLong_CtrlCourses_CM_CM_Show" class="helpArticleDetails hidden">
    <div class="b-M">
        <div class="head">
            <h3>Hilfe</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_ctl00_CtrlHelpArticleDetails_UpdatePanel1">
		
                    <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCourseDetailsLong$ctl00$CtrlHelpArticleDetails$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_ctl00_CtrlHelpArticleDetails__tbHelpContent" class="htmlEditor" style="height:450px;width:100%;">
</textarea>
                
	</div>
        </div>
    </div>
</div>

    
<div id="CtrlCourseDetailsLong_CtrlCourses_CM_CM_Edit" class="helpArticleEdit hidden">
    <div class="b-M">
        <div class="head">
            <h3>
                Hilfe bearbeiten</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_ctl00_CtrlHelpArticleEdit_UpdatePanel1">
		
                    <div>
                        <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlCourseDetailsLong$ctl00$CtrlHelpArticleEdit$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_ctl00_CtrlHelpArticleEdit__tbHelpContent" class="htmlEditor _vdMaxLength" data-maxlength="4000" style="height:450px;width:100%;">
</textarea>
                    </div>
                    <div class="butL">
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_ctl00_CtrlHelpArticleEdit_LbtnSave" class="btHelpArticleEditSave" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCourseDetailsLong$ctl00$CtrlHelpArticleEdit$LbtnSave&#39;,&#39;&#39;)">Speichern</a>
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_ctl00_CtrlHelpArticleEdit_LbtnAbort" class="btHelpArticleEditSaveCancel" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlCourseDetailsLong$ctl00$CtrlHelpArticleEdit$LbtnAbort&#39;,&#39;&#39;)">Abbrechen</a>
                    </div>
                
	</div>
        </div>
    </div>
</div>

</div>

            </div>
            <div class="cont">
                <table id="CM_CM_CtrlCourses_CtrlCourseDetailsLong_CtrlBmsTable" cellspacing="0" cellpadding="1" style="border-collapse:collapse;">

	</table>
            </div>
        </div>
    </div>
</div>
<a href="#" class="btn_right close">Schließen</a> 
    
</div>
<div id="CM_CM_CtrlCourses_UpBookEnrol" class="modal">
	
        <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_DivTabs" class="b-M">
    <input type="hidden" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$HfSelectedTabIndex" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_HfSelectedTabIndex" value="0" />
    <input type="hidden" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$HfSelectedTabId" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_HfSelectedTabId" />
    
    <div class="cont">
        <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_DivTabsHeader"></div>
        <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TabCommonContent"><div class="registration user-details">
					
				</div>
<div class="b-M shortDetails course">
	<div class="head">
		<h3>
			Lehrgangstermindetails
		</h3>
	</div>
	<div class="cont">
		<table id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlCourseDetailsShort_CtrlBmsTable" cellspacing="0" cellpadding="1" style="border-collapse:collapse;">

	</table>
	</div>
</div>
<br></br><div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_DivRegToCancel" class="b-M">
					<div class="head">
						<h3>Auszutauschender Teilnehmer</h3>
						
<div id="DivRegToCancel_TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM" class="helpArticle">
    
<div id="DivRegToCancel_TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM_Show" class="helpArticleDetails hidden">
    <div class="b-M">
        <div class="head">
            <h3>Hilfe</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl03_CtrlHelpArticleDetails_UpdatePanel1">
		
                    <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl03$CtrlHelpArticleDetails$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl03_CtrlHelpArticleDetails__tbHelpContent" class="htmlEditor" style="height:450px;width:100%;">
</textarea>
                
	</div>
        </div>
    </div>
</div>

    
<div id="DivRegToCancel_TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM_Edit" class="helpArticleEdit hidden">
    <div class="b-M">
        <div class="head">
            <h3>
                Hilfe bearbeiten</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl03_CtrlHelpArticleEdit_UpdatePanel1">
		
                    <div>
                        <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl03$CtrlHelpArticleEdit$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl03_CtrlHelpArticleEdit__tbHelpContent" class="htmlEditor _vdMaxLength" data-maxlength="4000" style="height:450px;width:100%;">
</textarea>
                    </div>
                    <div class="butL">
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl03_CtrlHelpArticleEdit_LbtnSave" class="btHelpArticleEditSave" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl03$CtrlHelpArticleEdit$LbtnSave&#39;,&#39;&#39;)">Speichern</a>
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl03_CtrlHelpArticleEdit_LbtnAbort" class="btHelpArticleEditSaveCancel" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl03$CtrlHelpArticleEdit$LbtnAbort&#39;,&#39;&#39;)">Abbrechen</a>
                    </div>
                
	</div>
        </div>
    </div>
</div>

</div>

					</div>
					<div class="cont">
						<table id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_BmsTable1" cellspacing="0" cellpadding="1" style="border-collapse:collapse;">
		<tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TableRow1">
			<td class="label width_2_1">Name</td><td class="value lastCol width_2_2"></td>
		</tr>
	</table>
					</div>
				</div><div class="b-M user-registration">
					<div class="head">
						<h3>Lehrgangsanmeldungsdaten</h3>
						
<div id="TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM" class="helpArticle">
    
<div id="TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM_Show" class="helpArticleDetails hidden">
    <div class="b-M">
        <div class="head">
            <h3>Hilfe</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl05_CtrlHelpArticleDetails_UpdatePanel1">
		
                    <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl05$CtrlHelpArticleDetails$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl05_CtrlHelpArticleDetails__tbHelpContent" class="htmlEditor" style="height:450px;width:100%;">
</textarea>
                
	</div>
        </div>
    </div>
</div>

    
<div id="TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM_Edit" class="helpArticleEdit hidden">
    <div class="b-M">
        <div class="head">
            <h3>
                Hilfe bearbeiten</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl05_CtrlHelpArticleEdit_UpdatePanel1">
		
                    <div>
                        <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl05$CtrlHelpArticleEdit$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl05_CtrlHelpArticleEdit__tbHelpContent" class="htmlEditor _vdMaxLength" data-maxlength="4000" style="height:450px;width:100%;">
</textarea>
                    </div>
                    <div class="butL">
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl05_CtrlHelpArticleEdit_LbtnSave" class="btHelpArticleEditSave" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl05$CtrlHelpArticleEdit$LbtnSave&#39;,&#39;&#39;)">Speichern</a>
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl05_CtrlHelpArticleEdit_LbtnAbort" class="btHelpArticleEditSaveCancel" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$ctl05$CtrlHelpArticleEdit$LbtnAbort&#39;,&#39;&#39;)">Abbrechen</a>
                    </div>
                
	</div>
        </div>
    </div>
</div>

</div>

					</div>
					<div class="cont">
						<table id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlTable" cellspacing="0" cellpadding="1" style="border-collapse:collapse;">
		<tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrUserOrgUnitAssignment">
			<td class="label width_2_1"><span id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_LblName">Teilnehmerdaten</span>
									<span class="fieldLoading"></span>
								</td><td class="value lastCol width_2_2"></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrBillingAddress">
			<td class="label width_2_1"><span Mode="Encode">Rechnungsanschrift</span></td><td class="value lastCol width_2_2"><div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl07">
				
									
												
			</div></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrArrivalDate">
			<td class="label width_2_1">Anreise außerhalb der normalen Geschäftszeiten (wenn nein, leer lassen)</td><td class="value lastCol width_2_2"><input name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$DtpArrivalDate$TbDatePicker" type="text" maxlength="16" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_DtpArrivalDate_TbDatePicker" class="_dateTimePicker" data-options="||||||" data-pickertype="DateTimePicker" />
</td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrRequirements">
			<td class="label width_2_1">Voraussetzungen*</td><td class="value lastCol width_2_2"><span class="_vdRequiredIfVisible _vdaSave"><input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbRequirementsFulfilled" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbRequirementsFulfilled" /><label for="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbRequirementsFulfilled">erfüllt</label></span></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrMealInfo">
			<td class="label width_2_1">Gewünschte Mahlzeiten</td><td class="value lastCol width_2_2">
									<label>
										<input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbBreakfast" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbBreakfast" />
										Frühstück
									</label>
									<br />
									<label>
										<input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbLunch" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbLunch" />
										Mittag
									</label>
									<br />
									<label>
										<input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbDinner" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbDinner" />
										Abendessen
									</label>
								</td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrDietInfo">
			<td class="label width_2_1">Besondere Verpflegungsangaben</td><td class="value lastCol width_2_2">
									<label>
										<input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbVegetarian" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbVegetarian" />
										Vegetarier
									</label>
									<br />
									<label>
										<input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbVegan" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbVegan" />
										Veganer
									</label>
									<br />
									<span>Besonderheiten  </span><input name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$TbSpecialDietInfo" type="text" maxlength="200" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TbSpecialDietInfo" style="width:500px;" /></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrWlan">
			<td class="label width_2_1">WLAN</td><td class="value lastCol width_2_2">
									<label>
										<input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbWlan" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbWlan" />WLAN gewünscht
								
									</label>
									<br />
								</td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrStatements">
			<td class="label width_2_1">Erklärungen</td><td class="value lastCol width_2_2"><div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl10">
				
											
												<label class="multilineCheckboxLabel">
													<input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbPublishData" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbPublishData" />
													Ich bin damit einverstanden, dass mein Name, meine Mailadresse und meine Telefonnummer zum Zweck der Bildung von Fahrgemeinschaften anderen Personen mitgeteilt oder angezeigt wird.
									
												</label>
												<br />
											
											<label class="multilineCheckboxLabel">
												<span class="_vdaSaveRegistration_CM_CM_CtrlCourses_CtrlRegistrationEdit"><input id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CbAgb" type="checkbox" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CbAgb" /></span>
												Hiermit bestätige ich, die
												Allgemeinen Gesch&#228;ftsbedingungen<a id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_HlAgb" title="Zu den AGB" class="link" target="_blank">Allgemeinen Geschäftsbedingungen</a>
												zur Kenntnis genommen zu haben.
											</label>
										
			</div></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrComment">
			<td class="label width_2_1">Bemerkungen</td><td class="value lastCol width_2_2"><div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl12">
				
											<textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$TbComment" rows="3" cols="20" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TbComment" class="_vdMaxLength _vdaSave" data-maxlength="1000">
</textarea>
										
			</div></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrState">
			<td class="label width_2_1">Status</td><td class="value lastCol width_2_2"><div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_UpDdlState">
				
											<select name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$DdlState" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_DdlState" class="_vdRequiredIfVisible _vdaSaveRegistration_CM_CM_CtrlCourses_CtrlRegistrationEdit" onchange="RegistrationStateChanged(this);">

				</select>
											
										
			</div></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrMessage">
			<td class="error label width_2_1">ACHTUNG</td><td class="error value lastCol width_2_2"></td>
		</tr><tr id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_TrInfo">
			<td class="error label width_2_1">HINWEIS</td><td class="error value lastCol width_2_2">
									Bitte beachten Sie, dass die Lehrgangsteilnahme nach Bestätigung verbindlich ist!<br/>
									Sollte Ihre Teilnahme am Lehrgangstermin nach erfolgter Bestätigung nicht möglich sein, informieren Sie bitte Ihren zuständigen Vorgesetzten!
								</td>
		</tr>
	</table>
						<div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl15">
		
								
<div class="b-M shortDetails">
    <div class="head">
        <h3>Historie</h3>
    </div>
    <div class="cont">
        
    </div>
</div>

							
	</div>
					</div>
				</div><div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl17">
		
						

<div class="b-M">
    <div class="head">
        <h3>Mitzeichnungen</h3>
        
<div id="CtrlSignatureListEdit_TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM" class="helpArticle">
    
<div id="CtrlSignatureListEdit_TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM_Show" class="helpArticleDetails hidden">
    <div class="b-M">
        <div class="head">
            <h3>Hilfe</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_ctl00_CtrlHelpArticleDetails_UpdatePanel1">
			
                    <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CtrlSignatureListEdit$ctl00$CtrlHelpArticleDetails$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_ctl00_CtrlHelpArticleDetails__tbHelpContent" class="htmlEditor" style="height:450px;width:100%;">
</textarea>
                
		</div>
        </div>
    </div>
</div>

    
<div id="CtrlSignatureListEdit_TabCommonContent_PhTabs_DivTabs_CtrlBmsTabs_CtrlRegistrationEdit_CtrlCourses_CM_CM_Edit" class="helpArticleEdit hidden">
    <div class="b-M">
        <div class="head">
            <h3>
                Hilfe bearbeiten</h3>
        </div>
        <div class="cont">
            <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_ctl00_CtrlHelpArticleEdit_UpdatePanel1">
			
                    <div>
                        <textarea name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CtrlSignatureListEdit$ctl00$CtrlHelpArticleEdit$_tbHelpContent" rows="2" cols="20" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_ctl00_CtrlHelpArticleEdit__tbHelpContent" class="htmlEditor _vdMaxLength" data-maxlength="4000" style="height:450px;width:100%;">
</textarea>
                    </div>
                    <div class="butL">
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_ctl00_CtrlHelpArticleEdit_LbtnSave" class="btHelpArticleEditSave" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CtrlSignatureListEdit$ctl00$CtrlHelpArticleEdit$LbtnSave&#39;,&#39;&#39;)">Speichern</a>
                        <a onclick="CloseHelpEdit();" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_ctl00_CtrlHelpArticleEdit_LbtnAbort" class="btHelpArticleEditSaveCancel" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$CtrlSignatureListEdit$ctl00$CtrlHelpArticleEdit$LbtnAbort&#39;,&#39;&#39;)">Abbrechen</a>
                    </div>
                
		</div>
        </div>
    </div>
</div>

</div>

    </div>
    <div class="cont">
        <table id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_CtrlBmsTable" cellspacing="0" cellpadding="1" style="border-collapse:collapse;">
			<tr>
				<td class="label width_2_1">Mitzeichnung</td><td class="value lastCol width_2_2"><div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_CtrlSignatureListEdit_ctl03">
					
                                
                            
				</div></td>
			</tr>
		</table>
    </div>
</div>

					
	</div></div>
        <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_DivTabsFooter"></div>
        <div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_ctl19">
		
				<div class="butL">
					
					<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$BtnSave" value="Speichern" onclick="StartSave(this);" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_BtnSave" class="noDisable _noLoadingAnimation _vdaSave _vdaSaveRegistration_CM_CM_CtrlCourses_CtrlRegistrationEdit" />

					
					<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$BtnCancel" value="Abbrechen" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_BtnCancel" class="_noLoadingAnimation" />
					<input type="submit" name="ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$BtnClose" value="Schließen" id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_BtnClose" />

					
					<a id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_LbtnAbort" href="javascript:__doPostBack(&#39;ctl00$ctl00$CM$CM$CtrlCourses$CtrlRegistrationEdit$CtrlBmsTabs$LbtnAbort&#39;,&#39;&#39;)">Abbrechen</a>
					<div id="CM_CM_CtrlCourses_CtrlRegistrationEdit_CtrlBmsTabs_UpdateScript">

		</div>
				</div>
			
	</div>
    </div>
</div>

<script type="text/javascript">
	/**
	 * @param {HTMLElement} obj
	 */
	function StartSave(obj) {
		/** @type {jQuery} */
		var $container = $(obj);

		/** @type {jQuery} */
		var $parent = $container.closest("div.butL");

		$parent.find("[id$='BtnSave']").hide();
		$parent.find("[id$='LbtnAbort']").hide();
		$parent.find("[id$='BtnStop']").show();

		StartLoadingAnimation($container);
	}

	/**
	 * @param {string} objId
	 */
	function StartLoadingAnimationById(objId) {
		StartLoadingAnimation($("#" + objId));
	}
	
	/**
	 * @param {string} objId
	 */
	function StopLoadingAnimationById(objId){
		StopLoadingAnimation($("#" + objId));
	}

	/**
	 * @param {jQuery} $obj
	 */
	function StartLoadingAnimation($obj) {
		if ($obj.length === 0) return;

		var $regParent = $obj.closest("div.b-M");
		$regParent.find("span.fieldLoading").each(function () {
			InitFieldLoading($(this), "#000");
		});
	}
	
	/**
	 * @param {jQuery} $obj
	 */
	function StopLoadingAnimation($obj) {
		if ($obj.length === 0) return;
        
		var $regParent = $obj.closest("div.b-M");
		
		// remove any spinner element from field loading container
		$regParent.find("span.fieldLoading").empty();
	}
</script>

    
</div>

	</div>


				</div>
			</div>
			

			<div id="confirmDialog" title="Bestätigung">
				<p>
					<span class="ui-icon ui-icon-help" style="float: left; margin: 0 7px 20px 0;"></span>
					<span id="questionText">Wirklich ?</span>
				</p>
			</div>
		</div>
	</form>
</body>
</html>