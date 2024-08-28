# Pricing

## Get Pricing

<aside class="notice">
Get Pricing v2 not released yet
</aside>

```shell
curl "https://api.transitinc.com/v1/pricing?warehouse=001&type=FULL&format=JSON"
  -H "Authorization: Basic YourAuthTokenBase64"
```

> The above command returns JSON structured like this:

```json
{
  "version": "Full-201902130145",
  "pricing": [
    ["8-56140", 43],
    ["LOP-LP5", 8]
  ]
}
```

This endpoint retrieves the pricing for a specific Transit warehouse, all products.

### HTTP Request

`GET https://api.transitinc.com/v1/pricing`

### Query Parameters

Parameter | Required | Description
--------- | -------- | -----------
warehouse | yes | Transit warehouse code. Example: 001 is Levis Warehouse.
type | yes | FULL: for the full list of products refreshed each hour. UPDATE: for the list of all products that their pricing has changed today (since midnight).
format | yes | JSON for json output. CSV for csv output.

### Error codes

See the [Errors](#errors) section to know how to read error codes.

Error Code | Message
---------- | -------
6001 | Invalid warehouse, or access not allowed for this warehouse.
6002 | Invalid type.
6003 | Invalid format.
6004 | Information not available at this time.
