# Setting up TLS using Lets Encrypt

## Install Certbot
```bash
sudo apt install certbot
```

## Initiate Certificate Generation
```bash
sudo certbot certonly --manual --preferred-challenges dns
```

## Verify DNS
```bash
dig code.itdad.world TXT
dig _acme-challenge.code.itdad.world TXT
```

## Create Kubernetes TLS Certificate
```bash
cd /etc/letsencrypt/live/code.itdad.world/
kubectl create secret tls code-tls --cert=fullchain.pem --key=privkey.pem
```
