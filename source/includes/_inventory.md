# Inventory

## Get Inventory

```shell
curl "https://api.transitinc.com/v1/inventory?warehouse=001&type=FULL&format=JSON"
  -H "Authorization: Basic YourAuthTokenBase64"
```

> The above command returns JSON structured like this:

```json
{
  "version": "Full-201902130145",
  "inventory": [
    ["8-56140", 43],
    ["LOP-LP5", 8]
  ]
}
```

This endpoint retrieves the inventory for a specific Transit warehouse, all products.

### HTTP Request

`GET https://api.transitinc.com/v1/inventory`

### Query Parameters

Parameter | Required | Description
--------- | -------- | -----------
warehouse | yes | Transit warehouse code. Example: 001 is Levis Warehouse.
type | yes | FULL for a full list of products, refreshed each night. UPDATE for the list of products containing changes since last night.
format | yes | JSON for json output. CSV for csv output.

### Error codes

See the [Errors](#errors) section to know how to read error codes.

Error Code | Message
---------- | -------
6001 | Access not configured for this warehouse.
6002 | Invalid type.
6003 | Invalid format.
6004 | Information not available at this time.