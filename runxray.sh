#!/bin/sh
# config xray
cat << EOF > /etc/xray/config.json
{
    "inbounds": [
	{
	"port": 80,
	"protocol": "$PROTOCOL",
	"settings": {
		"clients": [
					{
						"id": "$UUID",
						"level": 1,
						"alterId": 4,
						"security": "auto"
					}
		]
	},
	"streamSettings": {
		"network": "tcp",
		"tcpSettings": {
			"header": {
				"type": "http",
				"response": {
					"version": "1.1",
					"status": "200",
					"reason": "OK",
					"headers": {
						"Content-encoding": [
							"gzip"
						],
						"Content-Type": [
							"text/html; charset=utf-8"
						],
						"Cache-Control": [
							"no-cache"
						],
						"Vary": [
							"Accept-Encoding"
						],
						"X-Frame-Options": [
							"deny"
						],
						"X-XSS-Protection": [
							"1; mode=block"
						],
						"X-content-type-options": [
							"nosniff"
						]
					}
				}
			}
		}
	},
	"sniffing": {
		"enabled": true,
		"destOverride": [
			"http",
			"tls"
		]
	}
}
],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

# run xray
/usr/bin/xray run -config /etc/xray/config.json
