# Git
echo -n "Please input your git username: "
read username
echo -n "Please input your git email: "
read email

git config --global user.name "${username}"
git config --global user.email ${email}
git config --global push.default simple
