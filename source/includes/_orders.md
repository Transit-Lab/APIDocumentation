# Orders

## Submit Order

```shell
curl "https://api.transitinc.com/v1/orders"
  -X POST
  -H "Authorization: Basic YourAuthTokenBase64"
  -H "Content-Type: application/json"
  -d '{
    "purchaseOrder": "123456",
    "isPickup": false,
    "shipTo": {
      "LanguageNo": "EN",
      "Name": "John Doe",
      "Phone": "(514) 432-4323",
      "Email": "johndoe@hotmail.com",
      "AddressLine1": "123, Fake street",
      "AddressLine2": null,
      "City": "Montreal",
      "State": "QC",
      "Zip": "D6G 9J4",
      "Country": "CA",
      "Note": "LAISSER SUR PLACE SI PERSONNE"
    },
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
isPickup | yes | false if you want Transit to ship the order. true for a customer pickup at Transit Warehouse.
shipTo | no | Don't specify the shipTo object for pickup orders or if you want to keep the default shipto configured in the linked Transit Customer Zone account.
shipTo.LanguageNo | yes | Packing Slip Language. Must be EN, or FR.
shipTo.Name | yes | Ship to name, on carrier label, packing slip
shipTo.Phone | yes	|	Ship to phone, for carrier
shipTo.Email | no	| Ship to email, for carrier
shipTo.AddressLine1 | yes |	Ship to address line 1
shipTo.AddressLine2 | no | Ship to address line 2
shipTo.City | yes | Ship to city
shipTo.State | yes	|	Ship to state (2 char)
shipTo.Zip | yes	|	Ship to zip/postal code
shipTo.Country | yes	|	Ship to country must be CA or US.
shipTo.Note | yes |	Ship to note (for carrier/customer) max 100 caracters.
details.product | yes	|	Transit part number
details.qty | yes	| Order Qty

### Error codes

See the [Errors](#errors) section to know how to read error codes.

Error Code | Message
---------- | -------
2000 | Order not created because the request contains error(s).
2001 | purchaseOrder must be unique.
2002 | shipTo LanguageNo must be EN or FR.
2003 | product XXX is invalid.
2004 | product XXX qty XXX is not available.
2005 | product XXX qty XXX must be greater than 0.
2006 | purchaseOrder must be alphanumeric only.
2007 | purchaseOrder must be less than 11 characters.
2008 | product XXX Qty XXX must be a factor of XXX.
2009 | shipTo State must be 2 letters.
2010 | shipTo Country must be CA or US.
2101 | purchaseOrder is required.
2102 | shipTo LanguageNo is required.
2103 | shipTo Name is required.
2104 | shipTo Phone is required.
2105 | shipTo AddressLine1 is required.
2106 | shipTo City is required.
2107 | shipTo State is required.
2108 | shipTo Zip is required.
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