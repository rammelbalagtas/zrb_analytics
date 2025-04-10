
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Flight Query'

define transient view entity ZDT187v_RCB_Flight_Query
  provider contract analytical_query
  as projection on ZDT187v_RCB_Flight_Cube
{
          /* Dimensions */

          @AnalyticsDetails.query.axis: #ROWS
          @AnalyticsDetails.query.totals: #HIDE
          AirlineID,

          @AnalyticsDetails.query.axis: #ROWS
          @AnalyticsDetails.query.totals: #HIDE
          ConnectionID,

          @AnalyticsDetails.query.axis: #ROWS
          @AnalyticsDetails.query.totals: #HIDE
          FlightDate,

          @AnalyticsDetails.query.axis: #FREE
          @AnalyticsDetails.query.totals: #HIDE
          PlaneType,

          @AnalyticsDetails.query.axis: #ROWS
          @AnalyticsDetails.query.totals: #SHOW
          AirportFromId,

          @AnalyticsDetails.query.axis: #FREE
          @AnalyticsDetails.query.totals: #HIDE
          AirportToId,

          @AnalyticsDetails.query.axis: #FREE
          @AnalyticsDetails.query.totals: #HIDE
          YearQuarter,

          @AnalyticsDetails.query.axis: #FREE
          @AnalyticsDetails.query.totals: #SHOW
          CalendarYear,

          /* Measures */

          @AnalyticsDetails.query.axis: #COLUMNS
          @Semantics.amount.currencyCode: 'GlobalCurrency'
          @Aggregation.default: #FORMULA
          currency_conversion (
            amount             => curr_to_decfloat_amount( Price ),
            source_currency    => CurrencyCode,
            target_currency    => cast ( 'EUR'      as abap.cuky( 5 ) ) ,
            exchange_rate_date => cast ( '20230101' as abap.dats),
            exchange_rate_type => 'M'
          )                                                          as Price,
  virtual GlobalCurrency : abap.cuky( 5 ),
          CurrencyCode,

          @AnalyticsDetails.query.axis: #COLUMNS
          MaximumSeats,

          @AnalyticsDetails.query.axis: #COLUMNS
          OccupiedSeats,

          @AnalyticsDetails.query.axis: #COLUMNS
          @EndUserText.label: 'Occupation Rate'
          @Aggregation.default: #FORMULA
          @Semantics.quantity.unitOfMeasure: 'unitPercent'
          $projection.occupiedseats / $projection.maximumseats * 100 as OccupationRate,
          cast( '%' as abap.unit )                                   as unitPercent,

          @AnalyticsDetails.query.axis: #COLUMNS
          TotalFlights,

          @AnalyticsDetails.query.axis: #COLUMNS
          Distance,
          DistanceUnit,

          /* Associations */
          _Airline,
          _AirportFrom,
          _AirportTo,
          _Connection,
          _FlightDate
}
