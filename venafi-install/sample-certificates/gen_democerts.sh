# jens.sabitzer@venafi.com
# creates demo certificates with some common mistakes
# creates secrets in kubernetes 
# creates ingress controlers
#
# usage (#no. of examples of each category to generate):
# ./gen_democerts.sh 3 5 7 6 5 12 2 1 2 5 4


#!/bin/bash

# Remove previous certs
rm temp_certs/*

# Function to generate the root CA
generate_root_ca() {
  mkdir -p temp_certs
  openssl genrsa -out temp_certs/rootCA.key 2048
  openssl req -x509 -new -nodes -key temp_certs/rootCA.key -sha256 -days 3650 -out temp_certs/rootCA.pem -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Phantom CA/CN=rootCA"
}

# Function to generate and sign certificates
generate_certificates() {
  local num_wildcards=$1
  local num_1024bit=$2
  local num_2048bit=$3
  local num_3072bit=$4
  local num_expired=$5
  local num_expiring_soon=$6
  local num_long_expiry=$7
  local num_code_signing=$8
  local num_sub_ca=$9
  local num_self_signed=${10}
  local num_unused=${11}

  for i in $(seq 1 $num_wildcards); do
    openssl genrsa -out temp_certs/wildcard_$i.key 2048
    openssl req -new -key temp_certs/wildcard_$i.key -out temp_certs/wildcard_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Masked Desperado/CN=*.maskeddesperado$i.com"
    openssl x509 -req -in temp_certs/wildcard_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/wildcard_$i.crt -days 365
  done

  for i in $(seq 1 $num_1024bit); do
    openssl genrsa -out temp_certs/cert_1024_$i.key 1024
    openssl req -new -key temp_certs/cert_1024_$i.key -out temp_certs/cert_1024_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Cipher Snake/CN=CipherSnake1024$1.com"
    openssl x509 -req -in temp_certs/cert_1024_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/cert_1024_$i.crt -days 365
  done

  for i in $(seq 1 $num_2048bit); do
    openssl genrsa -out temp_certs/cert_2048_$i.key 2048
    openssl req -new -key temp_certs/cert_2048_$i.key -out temp_certs/cert_2048_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=CipherSnake/OU=Demo/CN=CipherSnake2024$i.com"
    openssl x509 -req -in temp_certs/cert_2048_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/cert_2048_$i.crt -days 365
  done

  for i in $(seq 1 $num_3072bit); do
    openssl genpkey -algorithm RSA -out temp_certs/cert_3072_$i.key -pkeyopt rsa_keygen_bits:3072
    openssl req -new -key temp_certs/cert_3072_$i.key -out temp_certs/cert_3072_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=CipherSnake/OU=GoodCipher/CN=examle$i.com"
    openssl x509 -req -in temp_certs/cert_3072_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/cert_3072_$i.crt -days 365
  done

  for i in $(seq 1 $num_expired); do
    openssl genrsa -out temp_certs/expired_$i.key 2048
    openssl req -new -key temp_certs/expired_$i.key -out temp_certs/expired_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Deceased/CN=deceased$i.com"
    openssl x509 -req -in temp_certs/expired_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/expired_$i.crt -days -1
  done

  for i in $(seq 1 $num_expiring_soon); do
    openssl genrsa -out temp_certs/expiring_soon_$i.key 2048
    openssl req -new -key temp_certs/expiring_soon_$i.key -out temp_certs/expiring_soon_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Short Fuse/CN=shortfuse$i.com"
    openssl x509 -req -in temp_certs/expiring_soon_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/expiring_soon_$i.crt -days 7
  done

  for i in $(seq 1 $num_long_expiry); do
    openssl genrsa -out temp_certs/long_expiry_$i.key 2048
    openssl req -new -key temp_certs/long_expiry_$i.key -out temp_certs/long_expiry_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Time Bandit/CN=TimeBandit$i.com"
    openssl x509 -req -in temp_certs/long_expiry_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/long_expiry_$i.crt -days 7300
  done

  for i in $(seq 1 $num_code_signing); do
    :
    #openssl genrsa -out temp_certs/code_signing_$i.key 2048
    #openssl req -new -key temp_certs/code_signing_$i.key -out temp_certs/code_signing_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Counterfeiter/CN=counterfeiter$i.com"
    #openssl x509 -req -in temp_certs/code_signing_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/code_signing_$i.crt -days 365 -addtrust codeSigning
  done

  for i in $(seq 1 $num_sub_ca); do
    openssl genrsa -out temp_certs/sub_ca_$i.key 2048
    openssl req -new -key temp_certs/sub_ca_$i.key -out temp_certs/sub_ca_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Phantom CA/CN=PhantomCA$i.int"
    openssl x509 -req -in temp_certs/sub_ca_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/sub_ca_$i.crt -days 365 -extfile <(echo "basicConstraints=CA:TRUE")
  done

  for i in $(seq 1 $num_self_signed); do
    openssl genrsa -out temp_certs/self_signed_$i.key 2048
    openssl req -new -key temp_certs/self_signed_$i.key -out temp_certs/self_signed_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Lone Outlaw/CN=LoneOutlaw$i.com"
    openssl x509 -req -in temp_certs/self_signed_$i.csr -signkey temp_certs/self_signed_$i.key -out temp_certs/self_signed_$i.crt -days 365
  done

  for i in $(seq 1 $num_unused); do
    openssl genrsa -out temp_certs/unused_$i.key 2048
    openssl req -new -key temp_certs/unused_$i.key -out temp_certs/unused_$i.csr -subj "/C=US/ST=Utah/L=Salt Lake City/O=Example/OU=Ghost Rider/CN=GhostRider$i.com"
    openssl x509 -req -in temp_certs/unused_$i.csr -CA temp_certs/rootCA.pem -CAkey temp_certs/rootCA.key -CAcreateserial -out temp_certs/unused_$i.crt -days 365
  done
}

# Function to create Kubernetes secrets
create_k8s_secrets() {
  kubectl create namespace venafi || true

  for cert_file in temp_certs/*.crt; do
    key_file="${cert_file%.crt}.key"
    secret_name=$(basename "$cert_file" .crt | tr '[:upper:]' '[:lower:]' | tr '_' '-')
    kubectl -n venafi create secret tls "$secret_name" \
      --key="$key_file" \
      --cert="$cert_file"
  done
}

# Function to create random ingress controllers in Kubernetes
create_ingress_controllers() {
  local categories=("wildcard" "cert_1024" "cert_2048" "cert_3072" "expired" "expiring_soon" "long_expiry" "code_signing" "sub_ca" "self_signed")

  for category in "${categories[@]}"; do
    for cert_file in temp_certs/${category}_*.crt; do
      [ -e "$cert_file" ] || continue
      key_file="${cert_file%.crt}.key"
      secret_name=$(basename "$cert_file" .crt | tr '[:upper:]' '[:lower:]' | tr '_' '-')
      random_number=$(cat /dev/urandom | tr -dc '0-9' | fold -w 4 | head -n 1)
      ingress_name="${category}-${random_number}"
      ingress_name=$(echo "$ingress_name" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9-')
      subject=$(openssl x509 -in "$cert_file" -noout -subject)
      cn=$(echo "$subject" | sed -n 's/^.*CN *= *\([^,]*\).*$/\1/p' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9.-]//g')

      echo "Debug: Subject for $cert_file is '$subject'"
      echo "Debug: Extracted CN for $cert_file is '$cn'"

      if [ -z "$cn" ]; then
        echo "Warning: Could not extract CN from $cert_file"
        continue
      fi

      # Ensure hostname starts and ends with an alphanumeric character
      cn=$(echo "$cn" | sed 's/^-*//;s/-*$//')
      # Ensure CN does not start with a period
      if [[ "$cn" == .* ]]; then
        cn=$(echo "$cn" | sed 's/^\.//')
      fi

      echo "Creating Ingress for CN: $cn with secret name: $secret_name and ingress name: $ingress_name"

      cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
  namespace: venafi
spec:
  tls:
  - hosts:
    - "$cn"
    secretName: $secret_name
  rules:
  - host: "$cn"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: example-service
            port:
              number: 80
EOF
    done
  done
}

# Main function to run the script
main() {
  local num_wildcards=${1}
  local num_1024bit=${2}
  local num_2048bit=${3}
  local num_3072bit=${4}
  local num_expired=${5}
  local num_expiring_soon=${6}
  local num_long_expiry=${7}
  local num_code_signing=${8}
  local num_sub_ca=${9}
  local num_self_signed=${10}
  local num_unused=${11}

  generate_root_ca
  generate_certificates $num_wildcards $num_1024bit $num_2048bit $num_3072bit $num_expired $num_expiring_soon $num_long_expiry $num_code_signing $num_sub_ca $num_self_signed $num_unused
  create_k8s_secrets
  create_ingress_controllers
}

# Run the main function with arguments
main ${1} ${2} ${3} ${4} ${P5} ${6} $P7} ${8} ${9} ${10} ${11}
