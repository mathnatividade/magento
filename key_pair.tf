# Generate new private key
resource "tls_private_key" "teste" {
    algorithm = "RSA"
}

# Generate a key-pair with above key
resource "aws_key_pair" "create_key_pair" {
    key_name   = "teste"
    public_key = tls_private_key.teste.public_key_openssh
}

# Saving Key Pair for ssh login for Client if needed
resource "null_resource" "save_key_pair"  {
    provisioner "local-exec" {
        command = "echo  ${tls_private_key.teste.private_key_pem} > keyname.pem"
    }
}