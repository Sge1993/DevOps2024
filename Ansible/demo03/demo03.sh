#sudo apt install whois
#mkpasswd -m sha512crypt --stdin <<< "Top.Secret"
ansible linux -i hosts -m user -a 'name=demo password=$6$aBH6ND6fk5IAYHzh$MWF/w4Om6CgKaweXEJ/q01AUdD1HnKS1VfgwlSgz2NVKLHW/lU8RPXc1Ko6eFftc66AbO1klm6y5gzjbhJ52I1' -k -b -K