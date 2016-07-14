CREATE PROCEDURE [dbo].[sp_init_station_iata]
AS
BEGIN

	BEGIN TRAN;

		TRUNCATE TABLE dbo.station_iata;

		WITH cte
		AS (
			SELECT s.id
				,s.latitude
				,s.longitude
				,s.elevation
				,s.state
				,s.name
				,s.gsn_flag
				,s.hcn_crn_flag
				,s.wmo_id
				,a.iata_code
				,a.city
				,ROW_NUMBER() OVER (PARTITION BY s.id ORDER BY s.geo.STDistance(a.geo)) AS nearest_iata_rank
			FROM dbo.station s
			LEFT JOIN dbo.airport a ON s.geo.STDistance(a.geo) < 1609 * 25
		)

		INSERT dbo.station_iata (
			 id
			,latitude
			,longitude
			,elevation
			,state
			,name
			,gsn_flag
			,hcn_crn_flag
			,wmo_id
			,iata_code
			,iata_city
		)

		SELECT id
			,latitude
			,longitude
			,elevation
			,state
			,name
			,gsn_flag
			,hcn_crn_flag
			,wmo_id
			,iata_code
			,city
		FROM cte
		WHERE nearest_iata_rank = 1

	COMMIT TRAN;
END
