#!/bin/bash
cond=''
while : 
do
	printf 'Программа блокировки пользователей\n'
	printf 'Программа позволяет блокировать и разблокировать портфели пользователей\n'
	printf 'Разработчик: Шедько Андрей \n'
	printf "Cписок пользователей: \n"
	gawk -F ':' '{if ( $3>500 ) print "- "$1  }' /etc/passwd;
	printf "Введите имя пользователя\n"
	read NAME
	VAR="$(cut -f1 -d':' /etc/passwd |fgrep -c -x "$NAME")"
	#echo $NAME
	#echo $var
	if [[ $VAR -eq 1 ]]; then
		echo "Введите действие (lock/unlock)"
		read C
		if [[ $C == "lock" ]]; then
			passwd -l $NAME
		elif [[ $C == "unlock" ]]; then
			passwd -u $NAME
		else
			echo 'Ошибка: Неизвестная комманда.'
			printf 'Error: unknown command' &1>2
		fi
	else
		echo 'Error: no such user'&1>2
		printf 'Ошибка: Нет такого пользователя.'
	fi
	echo 'Продолжить? (anykey/n)'
	read cond
	if [[ $cond == "n" ]]; then
		echo "Выход\n"
		exit 250
	else
		printf "Продолжим\n"
	fi
done
