@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Cube'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE
@Analytics.internalName: #LOCAL

define view entity ZDT187v_RCB_Flight_Cube
  as select from /DMO/I_Flight
  association [0..1] to ZDT187v_RCB_Airline_Dim    as _Airline     on  _Airline.CarrierId = $projection.AirlineID
  association [0..1] to ZDT187v_RCB_Connection_Dim as _Connection  on  _Connection.CarrierId    = $projection.AirlineID
                                                                   and _Connection.ConnectionId = $projection.ConnectionID
  association [0..1] to I_CalendarDate             as _FlightDate  on  _FlightDate.CalendarDate = $projection.FlightDate
  /* start optional associations */
  association [0..1] to ZDT187v_RCB_Airport_Dim    as _AirportFrom on  _AirportFrom.AirportId = $projection.airportfromid
  association [0..1] to ZDT187v_RCB_Airport_Dim    as _AirportTo   on  _AirportTo.AirportId = $projection.airporttoid
  /* end optional associations */
{
      @ObjectModel.foreignKey.association: '_Airline'
  key AirlineID,

      @ObjectModel.foreignKey.association: '_Connection'
  key ConnectionID,

      @ObjectModel.foreignKey.association: '_FlightDate'
  key FlightDate,

      PlaneType,

      /* start optional dimensions */
      @ObjectModel.foreignKey.association: '_AirportFrom'
      _Connection.AirportFromId,

      @ObjectModel.foreignKey.association: '_AirportTo'
      _Connection.AirportToId,

      @EndUserText.label: 'Flight Quarter'
      @Semantics.calendar.yearQuarter: true
      @ObjectModel.value.derivedFrom: [ 'FlightDate' ]
      _FlightDate.YearQuarter,

      @EndUserText.label: 'Flight Year'
      @Semantics.calendar.year: true
      @ObjectModel.value.derivedFrom: [ 'FlightDate' ]
      _FlightDate.CalendarYear,
      /* end optional dimensions */

      /* Measures */

      CurrencyCode,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @Aggregation.default: #MAX
      Price,

      @Aggregation.default: #SUM
      MaximumSeats,

      @Aggregation.default: #SUM
      OccupiedSeats,

      @Aggregation.default: #SUM
      cast (1 as abap.int4) as TotalFlights,

      _Connection.DistanceUnit,

      /* start optional measure */
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @Aggregation.default: #MAX
      _Connection.Distance,
      /* end optional measure */


      /* Associations for Dimensions */

      _Airline,
      _Connection,

      /* start optional associations */
      _AirportFrom,
      _AirportTo,
      _FlightDate
      /* end optional associations */
}
