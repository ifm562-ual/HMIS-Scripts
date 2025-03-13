#!/bin/bash
#Author: Ismael Fernandez Mendez

echo -e "GitLab installation will require HTTPS port. If this fails, check if it's open.\n" 2>&1 | tee -a logGitLab.log

echo -e "Trying to update system packages." 2>&1 | tee -a logGitLab.log
(sudo apt-get update -y) 2>&1 | tee -a logGitLab.log

echo -e "\nTrying to upgrade system packages." 2>&1 | tee -a logGitLab.log
(sudo apt-get upgrade -y) 2>&1 | tee -a logGitLab.log

echo -e "\nTrying to install GitLab dependencies." 2>&1 | tee -a logGitLab.log
(sudo apt-get install -y curl openssh-server ca-certificates tzdata perl) 2>&1 | tee -a logGitLab.log

read -p "Do you want to install Postfix? If affirmative, keep in mind that you'll require putting the correct server DNS name in Internet Site option during the wizard. (Y/N): " choice 2>&1 | tee -a logGitLab.log

case "$choice" in
	y|Y ) echo -e "Installing Postfix." 2>&1 | tee -a logGitLab.log; sudo apt-get install -y postfix 2>&1 | tee -a logGitLab.log;
	n|N) echo -e "Not installing Postfix" 2>&1 | tee -a logGitLab.log;
	* ) echo -e "Not installing Postfix (You did not entered N/n)" 2>&1 | tee -a logGitLab.log
esac

echo -e "\n\nAdding GitLab repository." 2>&1 | tee -a logGitLab.log
(curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash) 2>&1 | tee -a logGitLab.log

read -p "Please, enter correct EXTERNAL_URL attribute (Your DNS): " EXTERNALURL 2>&1 | tee -a logGitLab.log
echo -e "\nInstalling GitLab." 2>&1 | tee -a logGitLab.log
(sudo EXTERNAL_URL=$EXTERNALURL apt-get install gitlab-ce) 2>&1 | tee -a logGitLab.log

echo -e "Do not forget to check the configuration at /etc/gitlab/gitlab.rb and modify it if necessary." 2>&1 | tee -a logGitLab.log

