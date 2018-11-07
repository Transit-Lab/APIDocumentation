# Orders

## Submit Order

```shell
curl "https://api.transitinc.com/v1/orders"
  -X POST
  -H "Authorization: Basic YourAuthTokenBase64"
  -H "Content-Type: application/json"
  -d '{
    "purchaseOrder": "123456",
    "shipToLanguageNo": "EN",
    "shipToName": "John Doe",
    "shipToPhone": "(514) 432-4323",
    "shipToEmail": "johndoe@hotmail.com",
    "shipToAddressLine1": "123, Fake street",
    "shipToAddressLine2": null,
    "shipToCity": "Montreal",
    "shipToState": "QC",
    "shipToZip": "D6G 9J4",
    "shipToCountry": "CA",
    "shipToNote": "LAISSER SUR PLACE SI PERSONNE",
    "details": [
        { "product": "8-56140", "qty": 2 },
        { "product": "LOP-LP5", "qty": 1 }
    ]
}'
```

> The above command returns JSON structured like this:

```json
{
  "success": true
}
```

This endpoint submits a new order to Transit.

### HTTP Request

`POST https://api.transitinc.com/v1/orders`

### Query Parameters

Parameter | Required | Description
--------- | -------- | -----------
purchaseOrder | yes | Unique alphanumeric order number, will be set as the PO on the Transit Invoice for this order. Max 10 characters.
shipToLanguageNo | yes | Packing Slip Language. Must be EN, or FR.
shipToName | yes | Ship to name, on carrier label, packing slip
shipToPhone | yes	|	Ship to phone, for carrier
shipToEmail | no	| Ship to email, for carrier
shipToAddressLine1 | yes |	Ship to address line 1
shipToAddressLine2 | no | Ship to address line 2
shipToCity | yes | Ship to city
shipToState | yes	|	Ship to state (2 char)
shipToZip | yes	|	Ship to zip/postal code
shipToCountry | yes	|	Ship to country must always be CA.
shipToNote | yes |	Ship to note (for carrier/customer) max 100 caracters.
product | yes	|	Transit part number
qty | yes	| Order Qty

### Error codes

See the [Errors](#errors) section to know how to read error codes.

Error Code | Message
---------- | -------
2000 | Order not created because the request contains error(s).
2001 | purchaseOrder must be unique.
2002 | shipToLanguageNo must be EN or FR.
2003 | product XXX is invalid.
2004 | product XXX qty XXX is not available.
2005 | product XXX qty XXX must be greater than 0.
2006 | purchaseOrder must be alphanumeric only.
2007 | purchaseOrder must be less than 11 characters.
2008 | product XXX Qty XXX must be a factor of XXX.
2009 | shipToState must be 2 letters. Quebec = QC.
2010 | shipToCountry must be CA.
2101 | purchaseOrder is required.
2102 | shipToLanguageNo is required.
2103 | shipToName is required.
2104 | shipToPhone is required.
2105 | shipToAddressLine1 is required.
2106 | shipToCity is required.
2107 | shipToState is required.
2108 | shipToZip is required.
2109 | shipToCountry is required.
2110 | A product is required.
2112 | shipTo address is invalid.

## Get Order

```shell
curl "https://api.transitinc.com/v1/orders/123456"
  -H "Authorization: Basic YourAuthTokenBase64"
```

> The above command returns JSON structured like this:

```json
{
   "purchaseOrder": "123456",
   "status": "Shipped",
   "carrier": "Nationex", 
   "carrierService": null,
   "carrierTrackingNo": "123456789",
   "shipToName": "John Doe",
   "shipToPhone": "(514) 432-4323",
   "shipToEmail": "johndoe@hotmail.com",
   "shipToAddressLine1": "123, Fake street",
   "shipToAddressLine2": null,
   "shipToCity": "Montreal",
   "shipToState": "QC",
   "shipToZip": "D6G 9J4",
   "shipToCountry": "CA",
   "details": [
        { "product": "8-56140", "orderQty": 2, "shipQty": 2 },
        { "product": "LOP-LP5", "orderQty": 1, "shipQty": 0 }
    ]
}
```

This endpoint retrieves an order.

### HTTP Request

`GET https://api.transitinc.com/v1/orders/<purchaseOrder>`

### Query Parameters

Parameter | Required | Description
--------- | -------- | -----------
purchaseOrder | yes | Supplied purchaseOrder when the order was submitted.

### Error codes

See the [Errors](#errors) section to know how to read error codes.

Error Code | Message
---------- | -------
5001 | Order not found.
5002 | Order details not found.