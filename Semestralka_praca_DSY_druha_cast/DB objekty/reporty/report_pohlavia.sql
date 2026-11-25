<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="117551ba-019e-1000-8001-c0a86427d26b" type="" style="Table" enable="true">
	<name><![CDATA[report_centra_ucastnici]]></name>
	<description><![CDATA[Vypise centra, detail o ucastnikoch a ich pohlavie v pie charte]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[horizontal]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[select c.id_centra, c.nazov_centra, count (uc.os_cislo_ucastnik) as pocet_ucastnikov from centrum_vc c 
left join ucastnik_centra uc on uc.id_centra = c.id_centra
group by c.id_centra, c.nazov_centra]]></sql>
	</query>
	<display id="null" type="" style="Table" enable="true">
		<name><![CDATA[detail_ucastnici]]></name>
		<description><![CDATA[]]></description>
		<tooltip><![CDATA[]]></tooltip>
		<drillclass><![CDATA[]]></drillclass>
		<CustomValues>
			<TYPE><![CDATA[horizontal]]></TYPE>
		</CustomValues>
		<query>
			<sql><![CDATA[select uc.id_centra, uc.os_cislo_ucastnik, uc.dat_odhlasenia, uc.dat_prihlasenia from ucastnik_centra uc where uc.id_centra = :ID_CENTRA]]></sql>
			<binds>
				<bind id="ID_CENTRA">
					<prompt><![CDATA[ID_CENTRA]]></prompt>
					<tooltip><![CDATA[ID_CENTRA]]></tooltip>
					<value><![CDATA[NULL_VALUE]]></value>
					<bracket><![CDATA[null]]></bracket>
				</bind>
			</binds>
		</query>
	</display>
	<display id="null" type="" style="Chart" enable="true">
		<name><![CDATA[pohlavia_pie_chart]]></name>
		<description><![CDATA[]]></description>
		<tooltip><![CDATA[]]></tooltip>
		<drillclass><![CDATA[]]></drillclass>
		<CustomValues>
			<PLOT_HGRID_WIDTH><![CDATA[THINNER]]></PLOT_HGRID_WIDTH>
			<Y1AXIS_SCALE_INCREMENT><![CDATA[10.0]]></Y1AXIS_SCALE_INCREMENT>
			<Y2AXIS_SCALE_MAXIMUM><![CDATA[80.0]]></Y2AXIS_SCALE_MAXIMUM>
			<Y1AXIS_LINE_WIDTH><![CDATA[THINNEST]]></Y1AXIS_LINE_WIDTH>
			<Y1AXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></Y1AXIS_TITLE_ALIGNMENT>
			<LEGEND_LOCATION><![CDATA[AUTOMATIC]]></LEGEND_LOCATION>
			<LEGEND_ALIGNMENT><![CDATA[LEFT]]></LEGEND_ALIGNMENT>
			<PLOT_DATALABELS_SLICE_POSITION><![CDATA[OUTSIDE_SLICE_LINE]]></PLOT_DATALABELS_SLICE_POSITION>
			<XAXIS_LINE_WIDTH><![CDATA[THINNEST]]></XAXIS_LINE_WIDTH>
			<DATA_MAP_COLUMNS><![CDATA[\,"SKUPINA",]]></DATA_MAP_COLUMNS>
			<Y1AXIS_SCALE_MAXIMUM><![CDATA[60.0]]></Y1AXIS_SCALE_MAXIMUM>
			<XAXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></XAXIS_TITLE_ALIGNMENT>
			<XAXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></XAXIS_TICK_LABEL_ROTATE>
			<Y1AXIS_LOGARITHMIC_BASE><![CDATA[BASE_10]]></Y1AXIS_LOGARITHMIC_BASE>
			<TYPE><![CDATA[PIE]]></TYPE>
			<GRID_WIDTH><![CDATA[THINNER]]></GRID_WIDTH>
			<PLOT_DATALABELS_BAR_POSITION><![CDATA[ABOVE]]></PLOT_DATALABELS_BAR_POSITION>
			<FOOTNOTE_ALIGNMENT><![CDATA[LEFT]]></FOOTNOTE_ALIGNMENT>
			<XAXIS_TICK_LABEL_SKIP_MODE><![CDATA[AUTOMATIC]]></XAXIS_TICK_LABEL_SKIP_MODE>
			<DATA_MAP_COLNAMES><![CDATA[\,"POCET","POHLAVIE","SKUPINA"]]></DATA_MAP_COLNAMES>
			<DATA_MAP_SERIES><![CDATA[\,"POHLAVIE",]]></DATA_MAP_SERIES>
			<Y2AXIS_LOGARITHMIC_BASE><![CDATA[BASE_10]]></Y2AXIS_LOGARITHMIC_BASE>
			<DATA_MAP_COUNT><![CDATA[2]]></DATA_MAP_COUNT>
			<STYLE><![CDATA[Default]]></STYLE>
			<TITLE_ALIGNMENT><![CDATA[LEFT]]></TITLE_ALIGNMENT>
			<XAXIS_SCALE_INCREMENT><![CDATA[20.0]]></XAXIS_SCALE_INCREMENT>
			<PLOT_DATALABELS_SLICE_TYPE><![CDATA[PERCENT_VALUE]]></PLOT_DATALABELS_SLICE_TYPE>
			<Y2AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y2AXIS_TICK_LABEL_ROTATE>
			<Y2AXIS_SCALE_MINIMUM><![CDATA[10.0]]></Y2AXIS_SCALE_MINIMUM>
			<Y2AXIS_LINE_WIDTH><![CDATA[THINNEST]]></Y2AXIS_LINE_WIDTH>
			<DATA_MAP_VALUES><![CDATA[\,"POCET",]]></DATA_MAP_VALUES>
			<Y1AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y1AXIS_TICK_LABEL_ROTATE>
			<Y2AXIS_SCALE_INCREMENT><![CDATA[20.0]]></Y2AXIS_SCALE_INCREMENT>
			<PLOT_VGRID_WIDTH><![CDATA[THINNER]]></PLOT_VGRID_WIDTH>
			<Y2AXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></Y2AXIS_TITLE_ALIGNMENT>
			<SUBTITLE_ALIGNMENT><![CDATA[LEFT]]></SUBTITLE_ALIGNMENT>
		</CustomValues>
		<query>
			<sql><![CDATA[select o.pohlavie as pohlavie, count(*) as pocet, 'pohlavie' as skupina
from ucastnik_centra uc
join ucastnik u on uc.os_cislo_ucastnik = u.os_cislo_ucastnik
join osoba o on o.rod_cislo = u.rod_cislo
where uc.id_centra = :ID_CENTRA
group by o.pohlavie]]></sql>
			<binds>
				<bind id="ID_CENTRA">
					<prompt><![CDATA[ID_CENTRA]]></prompt>
					<tooltip><![CDATA[ID_CENTRA]]></tooltip>
					<value><![CDATA[NULL_VALUE]]></value>
					<bracket><![CDATA[null]]></bracket>
				</bind>
			</binds>
		</query>
	</display>
</display>
</displays>