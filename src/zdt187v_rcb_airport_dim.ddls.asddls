
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Airport Dimension'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.internalName: #LOCAL
@Analytics.dataCategory: #DIMENSION
@ObjectModel.representativeKey: 'AirportId'

define view entity ZDT187v_RCB_Airport_Dim
  as select from /dmo/airport
{
      @ObjectModel.text.element: ['Name']
  key airport_id as AirportId,
      name       as Name,
      city       as City,
      country    as Country
}
