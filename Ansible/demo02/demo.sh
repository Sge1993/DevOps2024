ansible linux -i hosts -m shell -a '/bin/echo hello'
ansible linux -i hosts -m setup | grep ansible_distribution