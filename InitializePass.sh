gpg --quick-gen-key "Dago Dragony"
gpg --list-secret-keys

pass init $(read -p "enter gpg-id:" input;echo $input)

#gpg --gen-key
#
#gpg --list-keys
#gpg --list-secret-keys
#gpg --delete-secret-keys XXXXXXXX # private keys
#gpg --delete-keys XXXXXXXX # public keys
#
## encryption of a file
#gpg --symmetric message.txt
## Prompts you for a passphrase
## Creates message.txt.gpg (binary)
#
#gpg --armor --symmetric message.txt
## Same, but ASCII format output instead of binary
## Creates message.txt.asc (ASCII)
#
## Specify the encryption algorithm
#gpg --symmetric --cipher-algo AES256
#
## Get the list of cipher algorithms
#gpg --version
## E.g. 3DES, BLOWFISH, AES256, TWOFISH
#
## Specify output file
#gpg --output message.txt.gpg --symmeteric message.txt
#
## Encrypt and sign (all in the single output file)
#gpg --sign --symmetric message.txt
#
#
#
##------------------------
#gpg -K # tells where keys are stored, default in ~/.gnupg/