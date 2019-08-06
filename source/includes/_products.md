# Products

## Get Products

```shell
curl "https://api.transitinc.com/v1/products?products=8-56140,LOP-LP5"
  -H "Authorization: Basic YourAuthTokenBase64"
```

> The above command returns JSON structured like this:

```json
{
  "products": [
    {
      "product": "8-56140",
      "name": "(5580) ROTOR (TOP QUALITY)",
      "price": 9.57,
      "prices": [],
      "available": 71
    },
    {
      "product": "LOP-LP5",
      "name": "OIL FILTER (LOOP)",
      "price": 3.57,
      "prices": [
        { "qty": 10, "price": 3.25 }
      ],
      "available": 12
    }
  ]
}
```

This endpoint retrieves a list of products.

### HTTP Request

`GET https://api.transitinc.com/v1/products`

### Query Parameters

Parameter | Required | Description
--------- | -------- | -----------
products | yes | Comma separated list of Transit part numbers

<aside class="notice">
  Remember — The request must be authenticated.
</aside>

<aside class="notice">
  <a href="/v1/products?products=8-56140,LOP-LP5">Try now in your browser</a>
</aside>

### Error codes

See the [Errors](#errors) section to know how to read error codes.

Error Code | Message
---------- | -------
4001 | At least one product number is required.