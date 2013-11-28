for month in $(cat months.lst); do
	echo -n "mes $month :=> "
	grep -c "$month" development.log
done
