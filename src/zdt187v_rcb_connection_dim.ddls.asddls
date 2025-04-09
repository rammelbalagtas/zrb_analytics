
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection Dimension'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #DIMENSION
@Analytics.internalName: #LOCAL
@ObjectModel.representativeKey: 'ConnectionId'

define view entity ZDT187v_RCB_Connection_Dim
  as select from /dmo/connection
  association [1] to ZDT187v_RCB_Airline_Dim as _Airline on $projection.CarrierId = _Airline.CarrierId
{
      @ObjectModel.foreignKey.association: '_Airline'
  key carrier_id                                           as CarrierId,
      @ObjectModel.text.element: ['Trip']
  key connection_id                                        as ConnectionId,
      airport_from_id                                      as AirportFromId,
      airport_to_id                                        as AirportToId,
      concat(airport_from_id, concat('->', airport_to_id)) as Trip,
      departure_time                                       as DepartureTime,
      arrival_time                                         as ArrivalTime,
      distance                                             as Distance,
      distance_unit                                        as DistanceUnit,
      _Airline
}
