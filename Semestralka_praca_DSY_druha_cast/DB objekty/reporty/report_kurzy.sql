<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="118f5495-019e-1000-8015-c0a86427d26b" type="" style="Table" enable="true">
	<name><![CDATA[report_vyuzite_kurzov]]></name>
	<description><![CDATA[]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[horizontal]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[select c.id_centra, c.nazov_centra, c.adresa from centrum_vc c]]></sql>
	</query>
	<display id="null" type="" style="Table" enable="true">
		<name><![CDATA[kurzy_v_centre]]></name>
		<description><![CDATA[]]></description>
		<tooltip><![CDATA[]]></tooltip>
		<drillclass><![CDATA[]]></drillclass>
		<CustomValues>
			<TYPE><![CDATA[horizontal]]></TYPE>
		</CustomValues>
		<query>
			<sql><![CDATA[select kc.id_centra, k.id_kurz, k.nazov_kurzu, k.kapacita_kurzu, count (uk.os_cislo) as pocet_prihlasenych
from kurz_centra kc join kurz k on kc.id_kurz = k.id_kurz
left join ucastnik_kurzy uk on k.id_kurz = uk.id_kurz 
where kc.id_centra = :ID_CENTRA
group by kc.id_centra, k.id_kurz, k.nazov_kurzu, k.kapacita_kurzu]]></sql>
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
		<name><![CDATA[vyuzitie_kurzov]]></name>
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
			<XAXIS_LINE_WIDTH><![CDATA[THINNEST]]></XAXIS_LINE_WIDTH>
			<DATA_MAP_COLUMNS><![CDATA[\,"POCET"]]></DATA_MAP_COLUMNS>
			<Y1AXIS_SCALE_MAXIMUM><![CDATA[60.0]]></Y1AXIS_SCALE_MAXIMUM>
			<XAXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></XAXIS_TITLE_ALIGNMENT>
			<XAXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></XAXIS_TICK_LABEL_ROTATE>
			<Y1AXIS_LOGARITHMIC_BASE><![CDATA[BASE_10]]></Y1AXIS_LOGARITHMIC_BASE>
			<TYPE><![CDATA[BAR_VERT_CLUST]]></TYPE>
			<GRID_WIDTH><![CDATA[THINNER]]></GRID_WIDTH>
			<PLOT_DATALABELS_BAR_POSITION><![CDATA[ABOVE]]></PLOT_DATALABELS_BAR_POSITION>
			<FOOTNOTE_ALIGNMENT><![CDATA[LEFT]]></FOOTNOTE_ALIGNMENT>
			<XAXIS_TICK_LABEL_SKIP_MODE><![CDATA[AUTOMATIC]]></XAXIS_TICK_LABEL_SKIP_MODE>
			<DATA_MAP_COLNAMES><![CDATA[\,"NAZOV_KURZU","OBSADENOST","POCET"]]></DATA_MAP_COLNAMES>
			<DATA_MAP_SERIES><![CDATA[\,"NAZOV_KURZU"]]></DATA_MAP_SERIES>
			<Y2AXIS_LOGARITHMIC_BASE><![CDATA[BASE_10]]></Y2AXIS_LOGARITHMIC_BASE>
			<STYLE><![CDATA[Default]]></STYLE>
			<TITLE_ALIGNMENT><![CDATA[LEFT]]></TITLE_ALIGNMENT>
			<Y2AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y2AXIS_TICK_LABEL_ROTATE>
			<Y2AXIS_SCALE_MINIMUM><![CDATA[10.0]]></Y2AXIS_SCALE_MINIMUM>
			<Y2AXIS_LINE_WIDTH><![CDATA[THINNEST]]></Y2AXIS_LINE_WIDTH>
			<DATA_MAP_VALUES><![CDATA[\,"OBSADENOST"]]></DATA_MAP_VALUES>
			<Y1AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y1AXIS_TICK_LABEL_ROTATE>
			<Y2AXIS_SCALE_INCREMENT><![CDATA[20.0]]></Y2AXIS_SCALE_INCREMENT>
			<PLOT_VGRID_WIDTH><![CDATA[THINNER]]></PLOT_VGRID_WIDTH>
			<Y2AXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></Y2AXIS_TITLE_ALIGNMENT>
			<SUBTITLE_ALIGNMENT><![CDATA[LEFT]]></SUBTITLE_ALIGNMENT>
		</CustomValues>
		<query>
			<sql><![CDATA[select k.nazov_kurzu, round((count(uk.os_cislo) / k.kapacita_kurzu) * 100, 2) as obsadenost, 'skupina' as pocet from kurz_centra kc
join kurz k on kc.id_kurz = k.id_kurz
left join ucastnik_kurzy uk on uk.id_kurz = k.id_kurz
where kc.id_centra = :ID_CENTRA
group by k.nazov_kurzu, k.kapacita_kurzu]]></sql>
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