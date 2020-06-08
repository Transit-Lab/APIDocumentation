# Orders

## Submit Order

```shell
curl "https://api.transitinc.com/v2/orders"
  -X POST
  -H "Authorization: Basic YourAuthTokenBase64"
  -H "Content-Type: application/json"
  -d '{
	"whse": "001",
	"whsePickup": "001",
	"purchaseOrder": "123456",
	"shippingService": "UPSGround",
	"transitNote": "transit note",
	"documentNote": "document note",
	"shipTo": {
		"languageNo": "EN",
		"name": "John Doe",
		"phone": "(514) 432-4323",
		"email": "johndoe@hotmail.com",
		"addressLine1": "123, Fake street",
		"addressLine2": null,
		"addressLine3": null,
		"city": "Montreal",
		"state": "QC",
		"zip": "D6G 9J4",
		"country": "CA",
		"note": "LAISSER SUR PLACE SI PERSONNE"
	},
	"details": [
		{
			"product": "8-56140",
			"crossReference": "ref#"
			"qty": 2,
			"keepBo": true,
			"declaredValue": 9.99
		},
		{
			"product": "LOP-LP5",
			"crossReference": "ref#"
			"qty": 1,
			"keepBo": true,
			"declaredValue": 9.99
		}
	]
}'
```

> The above command returns JSON structured like this:

```json
{
  "success": true,
  "warnings": []
}
```

With status code `201` (Created) and a Location header containing the relative path to the newly created order.

This endpoint submits a new order to Transit.

### HTTP Request

`POST https://api.transitinc.com/v2/orders`

### Query Parameters

Parameter | Required | Description
--------- | -------- | -----------
whse | no |  Warehouse at which you wish to submit your order, will default to your default warehouse.
whsePickup | no | For pickup orders, Warehouse at which you wish to pickup your order.
purchaseOrder | yes | Unique alphanumeric order number, will be set as the PO on the Transit Invoice for this order. (22 chars max)
shippingService | no | For shipped orders, the desired shipping service.
transitNote | no | Transit **will** take note of this. This note will not be printed on any document. The nature of this note may cause delays. (960 chars max)
documentNote | no | Transit **will not** take note of this. This note will be printed on the documents related to this order. (960 chars max)
shipTo | no | Don't specify the shipTo object for pickup orders or if you want to keep the default shipto configured in the linked Transit Customer Zone account.
shipTo.languageNo | yes | Packing Slip Language. Must be EN, or FR.
shipTo.name | yes | Ship to name, on carrier label, packing slip
shipTo.phone | yes | Ship to phone, for carrier
shipTo.email | no	| Ship to email, for carrier
shipTo.addressLine1 | yes | Ship to address line 1
shipTo.addressLine2 | no | Ship to address line 2
shipTo.addressLine3 | no | Ship to address line 3
shipTo.city | yes | Ship to city
shipTo.state | yes | Ship to state (2 chars)
shipTo.zip | yes | Ship to zip/postal code
shipTo.country | yes | Ship to country must be CA or US.
shipTo.note | yes | Ship to note (for carrier/customer) max 30 chars.
details | yes | List of products you wish to order.
details.product | yes | Transit part number
details.qty | yes | Order Qty in **stocking units** (With a P10 product, request 1 to get a pack of 10)
details.crossReference | no | Reference number for the product.
details.keepBo | no | Keep back order if there is not enough stock to fullfill your order.
details.declaredValue | no | Declared valued of the product. For international dropship orders.

### Error codes

See the [Errors](#errors) section to know how to read error codes.

Error Code | Message
---------- | -------
2000 | Order not created because the request contains error(s).
2001 | Purchase Order must be unique.
2002 | Ship To LanguageNo must be EN or FR.
2003 | product XXX is invalid.
2005 | Quantity must be greater than zero for product XXX.
2006 | Purchase Order's characters allowed are alphanumeric, dash and underscore.
2007 | Purchase Order must not exceed 22 characters..
2010 | Ship To Country Code must be CA or US.
2011 | Product XXX not found in Warehouse XXX.
2018 | Back Order option only available for STOCK products. (Product XXX)
2019 | Invalid pickup warehouse.
2020 | Shipping Service must not exceed 100 characters.
2021 | Invalid Shipping Service.
2023 | Oups! Qty XX exceeds our availability of XX for product XXX.
2024 | Declared value must be greater than zero. (Product XXX)
2101 | purchaseOrder is required.
2102 | Ship To LanguageNo is required.
2103 | Ship To Name is required.
2104 | Ship To Phone is required.
2105 | Ship To Address Line 1 is required.
2106 | Ship To City is required.
2107 | Ship To State is required.
2108 | Ship To Zip is required.
2109 | Ship To Country Code is required.
2110 | A product is required.
2113 | Ship To Name must not exceed 30 characters.
2114 | Concatenated Ship To Address Lines must not exceed 90 characters.
2115 | ShipTo City must not exceed 20 characters.
2116 | Ship To State Code must not exceed 2 characters.
2117 | Ship To Zip must not exceed 10 characters.
2119 | Ship To Phone must not exceed 20 characters.
2120 | Ship To Email must not exceed 60 characters.
2121 | Note must not exceed 30 characters.
2122 | Document Note must not exceed 960 characters.
2125 | Transit Note must not exceed 960 characters.
2126 | Cross reference must not exceed 24 characters for product XXX.
2128 | Invalid state for Country XX.
2129 | Declared value is required for international sales. (Product XXX)
6001 | Invalid warehouse, or access not allowed for this warehouse.

### Warnings
Product XXX, XX units ordered, XX units kept BO.

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
