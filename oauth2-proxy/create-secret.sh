# Create cookie secret literal
openssl rand -base64 32

kubectl create secret generic oauth2-proxy-secret \
--namespace oauth2-proxy \
--from-literal=OAUTH2_PROXY_CLIENT_SECRET="my-oauth2-secret" \
--from-literal=OAUTH2_PROXY_COOKIE_SECRET="my-cookie-secret" \
--dry-run=client -o yaml > oauth2-proxy-secret.yaml

kubeseal --controller-namespace kube-system \
         --controller-name sealed-secrets-controller \
         --format yaml \
         --namespace oauth2-proxy \
         < oauth2-proxy-secret.yaml > sealed-oauth2-proxy-secret.yaml