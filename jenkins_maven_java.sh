  #! bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install epel -y
  sudo amazon-linux-extras install java-openjdk11 -y
  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  sudo yum upgrade
  sudo yum install jenkins -y
  sudo systemctl enable jenkins
  sudo service jenkins start
  cd /opt
  sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
  sudo tar -xvf apache*.tar.gz
  sudo mv apache-maven-3.8.5 maven

  # ###### paths ###########
  # /etc/sudoers
  # /etc/ssh/sshd_config
  # /root/.bash_profile

  # ###### permissions for sudoers, sshd_config, .bash_profile #############
  # 440 sudoers
  # 600 sshd_config
  # 644 .bash_profile

  # ####### replacing the files ############
  # mv -f ./sudoers2 /etc/sudoers
  # mv -f ./sshd_config2 /etc/ssh/sshd_config
  # mv -f ./.bash_profile2 /root/.bash_profile
  